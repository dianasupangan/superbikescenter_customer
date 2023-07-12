import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:superbikes/global/cyware_key.dart';
import 'package:superbikes/global/link_header.dart';
import 'package:superbikes/widget/snackbar.dart';

import '../../global/validate.dart';
import '../../provider/loan_id.dart';
import 'otp/otp_textfield.dart';

class ChangeNumForm extends StatefulWidget {
  const ChangeNumForm({super.key});

  @override
  State<ChangeNumForm> createState() => _ChangeNumFormState();
}

class _ChangeNumFormState extends State<ChangeNumForm> {
  late final mobileNumberController = TextEditingController();
  final confirmMobileNumberController = TextEditingController();
  bool isPhoneNumberCorrect = true;
  bool isPhoneNumberCorrectA = true;

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
                isPhoneNumberCorrect = Validate().validateMobNum(value);
              });
            },
            decoration: InputDecoration(
              label: const Text('New Mobile Number'),
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
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 10,
          ),
          child: TextField(
            onChanged: (value) {
              setState(() {
                isPhoneNumberCorrectA = Validate().validateMobNum(value);
              });
            },
            decoration: InputDecoration(
              label: const Text('Confirm New Mobile Number'),
              border: const OutlineInputBorder(),
              errorText: isPhoneNumberCorrectA == true
                  ? null
                  : "Enter your Mobile Number",
            ),
            controller: confirmMobileNumberController,
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
                        logIn();
                        setState(() {
                          confirmMobileNumberController.text = '';
                          mobileNumberController.text = '';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(
                          50,
                        ),
                        backgroundColor: const Color.fromRGBO(0, 89, 162, 1),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Confirm"),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          confirmMobileNumberController.text = '';
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

  Future<void> logIn() async {
    final loanIdData = Provider.of<LoanId>(context, listen: false);
    final loanId = loanIdData.items.last.loanId.toString();
    final confirmMobileNum = confirmMobileNumberController.text;
    final mobileNum = mobileNumberController.text;
    final cywareCode = cywareCodeNewNum(loanId);
    var url = Uri.parse(link_header);

    if (confirmMobileNum == mobileNum) {
      var response = await http.post(
        url,
        body: jsonEncode(<String, dynamic>{
          "super_bikes": {
            "state": "state_update_mobile",
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

      final status = json['cyware_super_bikes']['result']['status'];

      if (status == "success") {
        final otp = json['cyware_super_bikes']['data']['otp'];
        showMyDialog(loanId, mobileNum, otp);
      } else if (status == "failed") {
        showErrorMessage(context, message: "Update Failed");
      } else if (status == " Invalid API Key!!") {
        showErrorMessage(context, message: "Invalid API Key!");
      } else {
        showErrorMessage(context, message: "Connection Error");
      }
    } else {
      showErrorMessage(context, message: "Phone number does not match");
    }
  }

  void showMyDialog(String loanId, String mobileNum, String otp) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Update Number In OTP',
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
