import 'package:flutter/material.dart';

import 'global/routes.dart';
import 'login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      title: "SuperBikes",
      home: const LogInScreen(),
      routes: routes,
    );
  }
}
