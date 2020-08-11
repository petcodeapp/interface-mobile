import 'package:flutter/material.dart';
import 'package:petcode_app/models/PetId.dart';
import 'package:petcode_app/screens/entry_screen.dart';
import 'package:petcode_app/screens/root_screen.dart';
import 'package:petcode_app/services/check_registration_service.dart';
import 'package:petcode_app/services/database_service.dart';
import 'package:petcode_app/services/firebase_auth_service.dart';
import 'package:petcode_app/services/firebase_storage_service.dart';
import 'package:petcode_app/services/image_picker_service.dart';
import 'package:petcode_app/services/map_service.dart';
import 'package:petcode_app/services/pet_id_provider.dart';
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
              return userService..clearUid();
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
              return petService..stopPetStream();
            } else {
              return petService..setPetIds(userService.currentUser.petIds);
            }
          },
        ),
        ChangeNotifierProvider<MapService>(
          create: (_) => MapService(),
        ),
        ChangeNotifierProxyProvider<PetService, PetIdProvider>(
            create: (_) => PetIdProvider(),
            update: (BuildContext context, PetService petService,
                PetIdProvider petIdProvider) {
              if (petService.allPets == null ||
                  petService.allPets.length == 0 ||
                  petIdProvider.petId != null) {
                return petIdProvider;
              } else {
                return petIdProvider
                  ..setPetId(PetId(petService.allPets[0].pid));
              }
            })
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
          return RootScreen();
        }
      },
    );
  }
}
