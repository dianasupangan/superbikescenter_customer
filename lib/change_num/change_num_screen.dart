import 'package:flutter/material.dart';
import 'package:superbikes/change_num/components/change_num_form.dart';
import 'package:superbikes/login/login_screen.dart';

import '../global/logo_header.dart';

class ChangeNumberScreen extends StatelessWidget {
  const ChangeNumberScreen({super.key});
  static const routeName = 'change-number';

  @override
  Widget build(BuildContext context) {
    double dWidth = MediaQuery.of(context).size.width;
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
                    child: const ChangeNumberPage(),
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
                    child: const ChangeNumberPage(),
                  ),
                ),
        ),
      ),
    );
  }
}

class ChangeNumberPage extends StatelessWidget {
  const ChangeNumberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const LogoHeader(),
          const SizedBox(
            height: 20,
          ),
          Text(
            "New Phone Number",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const ChangeNumForm(),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(LogInScreen.routeName);
            },
            child: const Text("< Back"),
          ),
        ],
      ),
    );
  }
}
