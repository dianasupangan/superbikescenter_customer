import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:superbikes/global/cyware_key.dart';
import 'package:superbikes/global/link_header.dart';
import 'package:superbikes/global/validate.dart';
import 'package:superbikes/widget/snackbar.dart';

import 'otp/otp_textfield.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final loanIdController = TextEditingController();
  final mobileNumberController = TextEditingController();
  bool isLoanId = true;
  bool isPhoneNumberCorrect = true;
  String deviceName = "";
  @override
  void initState() {
    getDeviceDetails();
    super.initState();
  }

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
              if (value.length == 3) {
                loanIdController.text += '-';
              }

              setState(() {
                isLoanId = Validate().validateLoanId(value);
              });
            },
            decoration: InputDecoration(
              label: const Text('Loan ID'),
              border: const OutlineInputBorder(),
              errorText: isLoanId == true ? null : "Enter your Loan ID",
              hintText: "XXX-XXXXXXX",
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
              hintText: "09XXXXXXXXX",
            ),
            controller: mobileNumberController,
            keyboardType: TextInputType.phone,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              LengthLimitingTextInputFormatter(11),
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
                        if (loanIdController.text == "" && isLoanId == false) {
                          showErrorMessage(context, message: "Enter Loan ID");
                        } else if (mobileNumberController.text == "" &&
                            isPhoneNumberCorrect == false) {
                          showErrorMessage(context,
                              message: "Enter Mobile Number");
                        } else if (loanIdController.text == "" &&
                            mobileNumberController.text == "") {
                          showErrorMessage(context,
                              message: "Accomplish all fields");
                        } else {
                          logIn();
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(
                            color: Color.fromRGBO(0, 89, 162, 1),
                          ),
                        ),
                        backgroundColor: const Color.fromRGBO(0, 89, 162, 1),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Log In"),
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
    // showMyDialog();
    final loanId = loanIdController.text;
    final mobileNum = mobileNumberController.text;
    final cywareCode = cywareCodeLogIn(loanId);
    var url = Uri.parse(link_header);
    var response = await http.post(
      url,
      body: jsonEncode(<String, dynamic>{
        "super_bikes": {
          "state": "state_login",
          "loan_id": loanId,
          "mobile_number": mobileNum,
          "device_name": deviceName,
          "cyware_key": cywareCode,
          "is_debug": "1"
        }
      }),
    );
    final utf = utf8.decode(response.bodyBytes);
    final json = jsonDecode(utf);

    print(json);
    print("$loanId $mobileNum");

    final status = json['cyware_super_bikes']['result']['status'];

    if (status == "success") {
      showMyDialog(loanId, mobileNum);
    } else if (status == "failed") {
      showErrorMessage(context,
          message: json['cyware_super_bikes']['result']['result']);
    } else {
      showErrorMessage(context, message: "Connection Error");
    }
  }

  void showMyDialog(String loanId, String mobileNum) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Log In OTP',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            OtpTextField(
              loanId: loanId,
              mobileNum: mobileNum,
            )
          ],
        );
      },
    );
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
