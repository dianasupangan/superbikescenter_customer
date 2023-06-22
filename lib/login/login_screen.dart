import 'package:flutter/material.dart';
import 'package:superbikes/login/components/login_form.dart';

import '../global/logo_header.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});
  static const routeName = '/';

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
                  const LogoHeader(),
                  const FractionallySizedBox(
                    widthFactor: 0.9,
                    child: LoginForm(),
                  ),
                  const Text("Please keep your mobile number updated!"),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Update here"),
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
