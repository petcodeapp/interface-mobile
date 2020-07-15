import 'package:flutter/material.dart';
import 'package:petcode_app/services/image_picker_service.dart';
import 'package:petcode_app/services/pet_service.dart';
import 'package:petcode_app/services/user_service.dart';
import 'package:petcode_app/widgets/auth_widget.dart';
import 'package:petcode_app/widgets/auth_widget_builder.dart';
import 'package:petcode_app/services/firebase_auth_service.dart';
import 'services/firebase_storage_service.dart';
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
        Provider<FirebaseStorageService>(
          create: (_) => FirebaseStorageService(),
        ),
        Provider<UserService>(
          create: (_) => UserService(),
        ),
        Provider<PetService>(
          create: (_) => PetService(),
        ),
        Provider<ImagePickerService>(
          create: (_) => ImagePickerService(),
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
