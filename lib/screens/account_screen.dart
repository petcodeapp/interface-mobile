import 'package:flutter/material.dart';
import 'package:petcode_app/services/firebase_auth_service.dart';
import 'package:petcode_app/services/user_service.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    if (userService.currentUser == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Account'),
              Text(userService.currentUser.firstName),
              Text(userService.currentUser.lastName),
              Text(userService.currentUser.email),
              FlatButton(
                child: Text('Log out'),
                onPressed: () {
                  final auth =
                      Provider.of<FirebaseAuthService>(context, listen: false);
                  auth.signOut();
                },
              )
            ]),
      );
    }
  }
}
