import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:superbikes/global/cyware_key.dart';

import 'otp/otp_textfield.dart';

class ChangeNumForm extends StatefulWidget {
  const ChangeNumForm({super.key});

  @override
  State<ChangeNumForm> createState() => _ChangeNumFormState();
}

class _ChangeNumFormState extends State<ChangeNumForm> {
  late final loanIdController = TextEditingController();
  final mobileNumberController = TextEditingController();

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
            decoration: const InputDecoration(
              label: Text('New Mobile Number'),
              border: OutlineInputBorder(),
            ),
            controller: loanIdController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 10,
          ),
          child: TextField(
            decoration: const InputDecoration(
              label: Text('Confirm New Mobile Number'),
              border: OutlineInputBorder(),
            ),
            controller: mobileNumberController,
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
                          loanIdController.text = '';
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

  Future<void> logIn() async {
    final loanId = loanIdController.text;
    final mobileNum = mobileNumberController.text;
    // final cywareCode = cywareCodeLogIn(loanId);
    var url = Uri.parse("http://10.6.18.166/cyware/super_bikes_api.cgi");
    // var response = await http.post(
    //   url,
    //   body: jsonEncode(<String, dynamic>{
    //     "super_bikes": {
    //       "state": "state_login",
    //       "loan_id": loanId,
    //       "mobile_number": mobileNum,
    //       "cyware_key": cywareCode,
    //       "is_debug": "1"
    //     }
    //   }),
    // );
    // final utf = utf8.decode(response.bodyBytes);
    // final json = jsonDecode(utf);

    // print("json: " + json.toString());

    // final status = json['cyware_super_bikes']['result']['status'];

    // if (status == "success") {
    showMyDialog(loanId, mobileNum);
    // } else if (status == "failed") {
    //   print("failed");
    // }
  }

  void showMyDialog(String loanId, String mobileNum) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Otp'),
          actions: <Widget>[OtpTextField(loanId: loanId, mobileNum: mobileNum)],
        );
      },
    );
  }
}
