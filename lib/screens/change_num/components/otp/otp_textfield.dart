import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superbikes/global/cyware_key.dart';
import 'package:superbikes/global/link_header.dart';
import 'package:superbikes/screens/login/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:superbikes/widget/snackbar.dart';

import '../../../../provider/loan_id.dart';
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
  @override
  void initState() {
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
    final loanIdData = Provider.of<LoanId>(context, listen: false);
    // final otp = _otp;
    final loanId = widget.loanId;
    final mobileNum = widget.mobileNum;
    final cywareCode = cywareCodeNewNumOtp(loanId);
    var url = Uri.parse(link_header);
    var response = await http.post(
      url,
      body: jsonEncode(
        <String, dynamic>{
          "super_bikes": {
            "state": "state_update_mobile_otp",
            "loan_id": loanId,
            "mobile_number": mobileNum,
            "otp": otp,
            "cyware_key": cywareCode,
            "is_debug": "1"
          }
        },
      ),
    );
    final utf = utf8.decode(response.bodyBytes);
    final json = jsonDecode(utf);

    final status = json['cyware_super_bikes']['result']['result'];
    print(json);

    if (status == "ok") {
      loanIdData.clear();
      showSuccessMessage(context, message: "Contact Updated");
      Navigator.of(context).pushReplacementNamed(LogInScreen.routeName);
    } else if (status == "Invalid OTP!") {
      showErrorMessage(context, message: "OTP failed");
      Navigator.of(context).pop();
    } else if (status == " Invalid API Key!!") {
      showErrorMessage(context, message: "Invalid API Key!");
      Navigator.of(context).pop();
    } else {
      showErrorMessage(context, message: "Connection Error");
      Navigator.of(context).pop();
    }
  }
}
