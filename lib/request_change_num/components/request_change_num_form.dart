import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:superbikes/global/cyware_key.dart';
import 'package:superbikes/global/link_header.dart';
import 'package:superbikes/widget/snackbar.dart';

import '../../global/validate.dart';
import 'otp/otp_textfield.dart';

class RequestChangeNumForm extends StatefulWidget {
  const RequestChangeNumForm({super.key});

  @override
  State<RequestChangeNumForm> createState() => _RequestChangeNumFormState();
}

class _RequestChangeNumFormState extends State<RequestChangeNumForm> {
  late final loanIdController = TextEditingController();
  final mobileNumberController = TextEditingController();
  bool isLoanId = true;
  bool isPhoneNumberCorrect = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 10,
          ),
          child: TextField(
            onChanged: (value) {
              setState(() {
                isLoanId = Validate().validateLoanId(value);
              });
            },
            decoration: InputDecoration(
              label: const Text('Loan ID'),
              border: const OutlineInputBorder(),
              errorText: isLoanId == true ? null : "Enter your Loan ID",
            ),
            controller: loanIdController,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9-]'))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 10,
          ),
          child: TextField(
            onChanged: (value) {
              setState(() {
                isPhoneNumberCorrect = Validate().validateMobNum(value);
              });
            },
            decoration: InputDecoration(
              label: const Text('Mobile Number'),
              border: const OutlineInputBorder(),
              errorText: isPhoneNumberCorrect == true
                  ? null
                  : "Enter your Mobile Number",
            ),
            controller: mobileNumberController,
            keyboardType: TextInputType.phone,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
          child: ListTile(
            title: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: ElevatedButton(
                      onPressed: () {
                        if (loanIdController.text == "" &&
                            mobileNumberController.text == "") {
                          showErrorMessage(context,
                              message: "Accomplish all fields");
                        } else if (loanIdController.text == "" &&
                            isLoanId == false) {
                          showErrorMessage(context, message: "Enter Loan ID");
                        } else if (mobileNumberController.text == "" &&
                            isPhoneNumberCorrect == false) {
                          showErrorMessage(context,
                              message: "Enter Mobile Number");
                        } else {
                          confirmAccount();
                          setState(() {
                            loanIdController.text = '';
                            mobileNumberController.text = '';
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(
                          50,
                        ),
                        backgroundColor: const Color.fromRGBO(0, 89, 162, 1),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Get OTP"),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          loanIdController.text = '';
                          mobileNumberController.text = '';
                        });
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
                      child: const Text("Clear"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Future<void> confirmAccount() async {
    final loanId = loanIdController.text;
    final mobileNum = mobileNumberController.text;
    final cywareCode = cywareCodeOldNum(loanId);
    print(cywareCode);
    var url = Uri.parse(link_header);
    var response = await http.post(
      url,
      body: jsonEncode(<String, dynamic>{
        "super_bikes": {
          "state": "state_old_mobile",
          "loan_id": loanId,
          "mobile_number": mobileNum,
          "cyware_key": cywareCode,
          "is_debug": "1"
        }
      }),
    );
    final utf = utf8.decode(response.bodyBytes);
    final json = jsonDecode(utf);

    print("json: $json");

    final status = json['cyware_super_bikes']['result']['result'];

    if (status == "ok") {
      final otp = json['cyware_super_bikes']['data']['otp'];
      showMyDialog(loanId, mobileNum, otp);
    } else if (status == "Invalid Loan ID!") {
      showErrorMessage(context, message: "Invalid Loan ID!");
    } else if (status == "Invalid Mobile  Number!") {
      showErrorMessage(context, message: "Invalid Mobile  Number!");
    } else if (status == " Invalid API Key!") {
      showErrorMessage(context, message: "Invalid API Key!");
    } else if (status == "Invalid Account! ") {
      showErrorMessage(context, message: "Account not found!");
    } else {
      showErrorMessage(context, message: "Connection Error");
    }
  }

  void showMyDialog(String loanId, String mobileNum, String otp) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Confirm Account OTP',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            OtpTextField(loanId: loanId, mobileNum: mobileNum, otp: otp)
          ],
        );
      },
    );
  }
}
