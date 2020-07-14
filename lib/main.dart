import 'package:flutter/material.dart';
import 'package:petcode_app/screens/stp_start_screen.dart';
import 'package:petcode_app/services/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService().registerUser('samuel6161@gmail.com', '12345678', 'Samuel', 'Yuan', '1234567890');
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: StpStartScreen(),
    );
  }
}