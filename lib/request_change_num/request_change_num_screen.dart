import 'package:flutter/material.dart';
import 'package:superbikes/login/login_screen.dart';
import 'package:superbikes/request_change_num/components/request_change_num_form.dart';

import '../global/logo_header.dart';

class RequestChangeNumberScreen extends StatelessWidget {
  const RequestChangeNumberScreen({super.key});
  static const routeName = 'request-change-number';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Color.fromRGBO(76, 134, 182, 1),
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(0, 89, 162, 1),
              Color.fromRGBO(76, 134, 182, 1),
            ],
          )),
          child: FractionallySizedBox(
            heightFactor: 0.7,
            widthFactor: 0.7,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const LogoHeader(),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: const Text(
                      "Change Number",
                      style: TextStyle(
                        fontSize: 25,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const FractionallySizedBox(
                    widthFactor: 0.9,
                    child: RequestChangeNumForm(),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(LogInScreen.routeName);
                    },
                    child: const Text("Go Back"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
