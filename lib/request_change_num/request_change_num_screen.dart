import 'package:flutter/material.dart';
import 'package:superbikes/login/login_screen.dart';
import 'package:superbikes/request_change_num/components/request_change_num_form.dart';

class RequestChangeNumberScreen extends StatelessWidget {
  const RequestChangeNumberScreen({super.key});
  static const routeName = 'request-change-number';

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
                    child: const RequestNumberPage(),
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
                    child: const RequestNumberPage(),
                  ),
                ),
        ),
      ),
    );
  }
}

class RequestNumberPage extends StatelessWidget {
  const RequestNumberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // const LogoHeader(),
        const Padding(
          padding: EdgeInsets.all(9.0),
          child: Text(
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
          child: const Text("< Back"),
        ),
      ],
    );
  }
}
