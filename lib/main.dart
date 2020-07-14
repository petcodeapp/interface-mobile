import 'package:flutter/material.dart';
import 'package:petcode_app/screens/entry_screen.dart';
import 'package:petcode_app/screens/stp_start_screen.dart';
import 'package:petcode_app/services/auth.dart';
import 'package:petcode_app/services/pet_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PetHelper.getAllPetsByUid('eMk8XO44ncYtlDaB4h37aLovj5v2');
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: EntryScreen(),
    );
  }
}