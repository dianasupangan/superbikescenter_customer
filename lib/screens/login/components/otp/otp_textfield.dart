import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superbikes/global/cyware_key.dart';
import 'package:superbikes/screens/home/home.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:superbikes/screens/login/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:superbikes/provider/loan.dart';
import 'package:superbikes/widget/snackbar.dart';

import '../../../../global/link_header.dart';
import '../../../../provider/user.dart';
import 'otp_input.dart';

class OtpTextField extends StatefulWidget {
  final String loanId;
  final String mobileNum;

  const OtpTextField({
    super.key,
    required this.loanId,
    required this.mobileNum,
  });

  @override
  State<OtpTextField> createState() => _OtpTextFieldState();
}

class _OtpTextFieldState extends State<OtpTextField> {
  String deviceName = "";
  @override
  void initState() {
    getDeviceDetails();
    Timer(const Duration(minutes: 5), () {
      Navigator.of(context)
          .pop(MaterialPageRoute(builder: (context) => const LogInScreen()));
    });
    super.initState();
  }

  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();

  // This is the entered code
  // It will be displayed in a Text widget
  String? otp;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Phone Number Verification'),
        const SizedBox(
          height: 30,
        ),
        // Implement 4 input fields
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OtpInput(_fieldOne, true), // auto focus
            OtpInput(_fieldTwo, false),
            OtpInput(_fieldThree, false),
            OtpInput(_fieldFour, false)
          ],
        ),
        const SizedBox(
          height: 30,
        ),

        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      otp = _fieldOne.text +
                          _fieldTwo.text +
                          _fieldThree.text +
                          _fieldFour.text;
                    });
                    confirmOTP();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(
                      50,
                    ),
                    backgroundColor: const Color.fromRGBO(0, 89, 162, 1),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Submit"),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(
                      50,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(
                        color: Color.fromRGBO(0, 89, 162, 1),
                      ),
                    ),
                    backgroundColor: Colors.white,
                    foregroundColor: const Color.fromRGBO(0, 89, 162, 1),
                  ),
                  child: const Text("Back"),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> confirmOTP() async {
    final userData = Provider.of<User>(context, listen: false);
    final loanData = Provider.of<Loan>(context, listen: false);
    final loanId = widget.loanId;
    final mobileNum = widget.mobileNum;
    final cywareCode = cywareCodeOtp(loanId);
    var url = Uri.parse(link_header);
    var response = await http.post(
      url,
      body: jsonEncode(
        <String, dynamic>{
          "super_bikes": {
            "state": "state_login_otp",
            "loan_id": loanId,
            "mobile_number": mobileNum,
            "device_name": deviceName,
            "otp": otp,
            "cyware_key": cywareCode,
            "is_debug": "1"
          }
        },
      ),
    );
    final utf = utf8.decode(response.bodyBytes);
    final json = jsonDecode(utf);

    print(json);

    final status = json['cyware_super_bikes']['result']['result'];

    if (status == "ok") {
      userData.clear();
      loanData.clear();

      final acctName =
          json['cyware_super_bikes']['data']['account_name'].toString();
      final loanStat =
          json['cyware_super_bikes']['data']['loan_status'].toString();
      final loanTerms =
          json['cyware_super_bikes']['data']['loan_terms'].toString();
      final monthPaid =
          json['cyware_super_bikes']['data']['months_paid'].toString();
      userData.add(loanId, acctName, acctName, loanStat, loanTerms, monthPaid);

      final paymentDate =
          json['cyware_super_bikes']['data']['payment_date'].toString();
      final paymentAmount =
          json['cyware_super_bikes']['data']['payment_amount'].toString();
      final orNumber =
          json['cyware_super_bikes']['data']['or_number'].toString();
      loanData.add(paymentDate, paymentAmount, orNumber);

      showSuccessMessage(context, message: "Log in success");
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } else if (status == "OTP NOT MATCH!") {
      showErrorMessage(context, message: "OTP invalid");
      Navigator.of(context).pop();
    } else if (status == "Invalid API Key!") {
      showErrorMessage(context, message: "Invalid API Key!");
      Navigator.of(context).pop();
    } else {
      showErrorMessage(context, message: "Connection Error");
      Navigator.of(context).pop();
    }
  }

  Future<void> getDeviceDetails() async {
    String dName = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    WebBrowserInfo webInfo = await deviceInfo.webBrowserInfo;
    final device = webInfo.userAgent;

    if (device!.contains("Macintosh")) {
      dName = "Macintosh";
    } else if (device.contains("iPhone")) {
      dName = "iPhone";
    } else if (device.contains("Android")) {
      dName = "Android";
    } else if (device.contains("Windows")) {
      dName = "Windows";
    } else {
      dName = device;
    }

    setState(() {
      deviceName = dName;
    });
  }
}
