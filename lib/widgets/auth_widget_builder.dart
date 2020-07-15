import 'package:flutter/material.dart';
import 'package:petcode_app/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({Key key, @required this.builder}) : super(key: key);
  final Widget Function(BuildContext, AsyncSnapshot<UserId>) builder;

  Widget build(BuildContext context) {
    final authService =
        Provider.of<FirebaseAuthService>(context, listen: false);
    return StreamBuilder<UserId>(
        stream: authService.onAuthStateChanged,
        builder: (BuildContext context, AsyncSnapshot<UserId> snapshot) {
          UserId userId = snapshot.data;
          if (userId != null) {
            return MultiProvider(
              providers: [
                Provider<UserId>.value(value: userId),
              ],
              child: builder(context, snapshot),
            );
          } else {
            return builder(context, snapshot);
          }
        });
  }
}
