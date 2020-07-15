import 'package:flutter/material.dart';
import 'package:petcode_app/screens/entry_screen.dart';
import 'package:petcode_app/screens/root_screen.dart';
import 'package:petcode_app/services/firebase_auth_service.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key key, @required this.userIdSnapshot}) : super(key: key);
  final AsyncSnapshot<UserId> userIdSnapshot;

  Widget build(BuildContext context) {
    if (userIdSnapshot.connectionState != ConnectionState.active) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      if (userIdSnapshot.hasData) {
        return RootScreen();
      } else {
        return EntryScreen();
      }
    }
  }
}
