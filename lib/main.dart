import 'package:flutter/material.dart';
import 'package:petcode_app/screens/entry_screen.dart';
import 'package:petcode_app/screens/root_screen.dart';
import 'package:petcode_app/screens/stp_nameandphone_screen.dart';
import 'package:petcode_app/screens/stp_start_screen.dart';
import 'package:petcode_app/services/check_registration_service.dart';
import 'package:petcode_app/services/database_service.dart';
import 'package:petcode_app/services/firebase_auth_service.dart';
import 'package:petcode_app/services/firebase_storage_service.dart';
import 'package:petcode_app/services/image_picker_service.dart';
import 'package:petcode_app/services/pet_service.dart';
import 'package:petcode_app/services/user_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseAuthService>(
          create: (_) => FirebaseAuthService(),
        ),
        Provider<FirebaseStorageService>(
          create: (_) => FirebaseStorageService(),
        ),
        Provider<ImagePickerService>(
          create: (_) => ImagePickerService(),
        ),
        Provider<DatabaseService>(
          create: (_) => DatabaseService(),
        ),
        Provider<CheckRegistrationService>(
          create: (_) => CheckRegistrationService(),
        ),
        ChangeNotifierProxyProvider<FirebaseAuthService, UserService>(
          create: (_) => UserService(),
          update: (BuildContext context, FirebaseAuthService authService,
              UserService userService) {
            if (authService.user == null) {
              return userService;
            } else {
              return userService..setUid(authService.user.uid);
            }
          },
        ),
        ChangeNotifierProxyProvider<UserService, PetService>(
          create: (_) => PetService(),
          update: (BuildContext context, UserService userService,
              PetService petService) {
            if (userService.currentUser == null) {
              return petService;
            } else {
              return petService..setPetIds(userService.currentUser.petIds);
            }
          },
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseAuthService>(
      builder: (context, FirebaseAuthService auth, _) {
        print('changed: ' + auth.status.index.toString());
        if (auth.status == Status.Uninitialized) {
          return Scaffold(
            backgroundColor: StyleConstants.blue,
            body: Center(
              child: Text('loading'),
            ),
          );
        } else if (auth.status == Status.Authenticating ||
            auth.status == Status.Unauthenticated) {
          print('entry screen!');
          return EntryScreen();
        } else {
          if (auth.needsAccount) {
            print('needs account');
            return StpNameAndPhoneScreen();
          } else if (auth.isSigningUp) {
            return StpStartScreen();
          } else {
            return RootScreen();
          }
        }
      },
    );
  }
}
