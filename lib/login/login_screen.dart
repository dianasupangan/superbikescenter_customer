import 'package:flutter/material.dart';
import "components/login_form.dart";

import '../request_change_num/request_change_num_screen.dart';
import '../global/logo_header.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    double dWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            ),
          ),
          alignment: Alignment.center,
          child: dWidth > 500
              ? SizedBox(
                  width: 500,
                  height: 550,
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.white,
                    child: const LogInPage(),
                  ),
                )
              : FractionallySizedBox(
                  widthFactor: .9,
                  heightFactor: .7,
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.white,
                    child: const LogInPage(),
                  ),
                ),
        ),
      ),
    );
  }
}

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LogoHeader(),
            const SizedBox(
              height: 20,
            ),
            const LoginForm(),
            const Text("Please keep your mobile number updated"),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(RequestChangeNumberScreen.routeName);
              },
              child: const Text("Update here"),
            ),
          ],
        ),
      ),
    );
  }
}
