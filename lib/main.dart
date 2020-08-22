import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petcode_app/providers/map_provider.dart';
import 'package:petcode_app/screens/entry_screen.dart';
import 'package:petcode_app/screens/root_screen.dart';
import 'package:petcode_app/services/check_registration_service.dart';
import 'package:petcode_app/services/database_service.dart';
import 'package:petcode_app/services/firebase_auth_service.dart';
import 'package:petcode_app/services/firebase_storage_service.dart';
import 'package:petcode_app/services/image_picker_service.dart';
import 'package:petcode_app/services/map_service.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/services/pet_service.dart';
import 'package:petcode_app/services/user_service.dart';
import 'package:petcode_app/set_up_keys.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SetUpKeys().createGoogleMapsKey();
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
              print(authService.user.uid);
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
              print(userService.currentUser.firstName);
              return petService..setPetIds(userService.currentUser.petIds);
            }
          },
        ),
        ChangeNotifierProxyProvider<PetService, CurrentPetProvider>(
            create: (_) => CurrentPetProvider(),
            update: (BuildContext context, PetService petService,
                CurrentPetProvider currentPetProvider) {
              if (petService.allPets == null ||
                  petService.allPets.length == 0) {
                return currentPetProvider..clearPet();
              } else if (currentPetProvider.currentPet != null) {
                return currentPetProvider..updatePet(petService.allPets);
              } else {
                return currentPetProvider..setCurrentPet(petService.allPets[0]);
              }
            }),
        ChangeNotifierProxyProvider<PetService, MapProvider>(
            create: (_) => MapProvider(),
            update: (BuildContext context, PetService petService,
                MapProvider mapProvider) {
              if (petService.allPets == null ||
                  petService.allPets.length == 0) {
                return mapProvider..clear();
              } else {
                return mapProvider..setScans(petService.allPets);
              }
            }),
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
        if (auth.status == Status.Uninitialized) {
          return Scaffold(
            backgroundColor: StyleConstants.blue,
            body: Center(
              child: Text('loading'),
            ),
          );
        } else if (auth.status == Status.Authenticating ||
            auth.status == Status.Unauthenticated) {
          return EntryScreen();
        } else {
          return RootScreen();
        }
      },
    );
  }
}
