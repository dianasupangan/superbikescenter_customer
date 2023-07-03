import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superbikes/global/cyware_key.dart';
import 'package:superbikes/home/home.dart';
import 'package:superbikes/login/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:superbikes/provider/loan.dart';

import '../../../global/link_header.dart';
import '../../../provider/user.dart';
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
  String? _otp;

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
                      _otp = _fieldOne.text +
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
    // showMyDialog();
    final otp = _otp;
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
            "otp": otp,
            "cyware_key": cywareCode,
            "is_debug": "1"
          }
        },
      ),
    );
    final utf = utf8.decode(response.bodyBytes);
    final json = jsonDecode(utf);

    print("json: " + json.toString());

    final status = json['cyware_super_bikes']['result']['status'];

    if (status == "success") {
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

      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } else if (status == "failed") {
      print("failed");
    }
  }
}
