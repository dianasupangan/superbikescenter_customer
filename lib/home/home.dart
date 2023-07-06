import 'package:flutter/material.dart';
import 'package:superbikes/home/components/account_details.dart';
import 'package:superbikes/home/components/payment_details.dart';

import '../global/logo_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = 'home-screen';

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
                    child: const HomePage(),
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
                    child: const HomePage(),
                  ),
                ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
          child: FractionallySizedBox(
            widthFactor: .7,
            child: LogoHeader(),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: AccountDetails(),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: PaymentDetails(),
          ),
        ),
        FractionallySizedBox(
          widthFactor: 0.5,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Exit"),
                Icon(Icons.logout),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
