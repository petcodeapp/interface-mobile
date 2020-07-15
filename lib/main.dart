import 'package:flutter/material.dart';
import 'package:petcode_app/widgets/auth_widget.dart';
import 'package:petcode_app/widgets/auth_widget_builder.dart';
import 'package:petcode_app/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(
          create: (_) => FirebaseAuthService(),
        ),
      ],
      child: AuthWidgetBuilder(builder: (context, userIdSnapshot) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          home: AuthWidget(userIdSnapshot: userIdSnapshot,),
        );
      }),
    );
  }
}
