import 'package:flutter/material.dart';
import 'package:petcode_app/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Text('Account'),
        FlatButton(
          child: Text('Log out'),
          onPressed: () {
            final auth = Provider.of<FirebaseAuthService>(context, listen: false);
            auth.signOut();
            Navigator.pop(context);
          },
        )
      ]),
    );
  }
}
