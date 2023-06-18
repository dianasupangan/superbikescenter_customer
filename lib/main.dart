import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superbikes/home/home.dart';
import 'package:superbikes/login/login_screen.dart';
import 'package:superbikes/provider/loan.dart';
import 'package:superbikes/provider/user.dart';

import 'global/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => User(),
        ),
        ChangeNotifierProvider(
          create: (context) => Loan(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.light(
          useMaterial3: true,
        ),
        title: "SuperBikes",
        home: const LogInScreen(),
        routes: routes,
      ),
    );
  }
}
