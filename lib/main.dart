import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/providers/current_location_provider.dart';
import 'package:petcode_app/providers/nearby_parks_provider.dart';
import 'package:petcode_app/providers/notifications_provider.dart';
import 'package:petcode_app/providers/scans_provider.dart';
import 'package:petcode_app/screens/entry_screen.dart';
import 'package:petcode_app/screens/root_screen.dart';
import 'package:petcode_app/services/check_registration_service.dart';
import 'package:petcode_app/services/database_service.dart';
import 'package:petcode_app/services/firebase_auth_service.dart';
import 'package:petcode_app/services/firebase_storage_service.dart';
import 'package:petcode_app/services/image_picker_service.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/services/pet_service.dart';
import 'package:petcode_app/services/user_service.dart';
import 'package:petcode_app/set_up_keys.dart';
import 'package:petcode_app/utils/no_glow_behavior.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SetUpKeys().createGoogleMapsKey();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

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
        ChangeNotifierProvider<NotificationsProvider>(
          create: (_) => NotificationsProvider(),
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
        ChangeNotifierProxyProvider<PetService, ScansProvider>(
            create: (_) => ScansProvider(),
            update: (BuildContext context, PetService petService,
                ScansProvider scansProvider) {
              if (petService.allPets == null ||
                  petService.allPets.length == 0) {
                return scansProvider..clear();
              } else {
                return scansProvider..setScans(petService.allPets);
              }
            }),
        ChangeNotifierProxyProvider<FirebaseAuthService,
                CurrentLocationProvider>(
            create: (_) => CurrentLocationProvider(),
            update: (BuildContext context, FirebaseAuthService authService,
                CurrentLocationProvider currentLocationProvider) {
              if (authService.user == null) {
                return currentLocationProvider..clear();
              } else {
                return currentLocationProvider..getCurrentLocation();
              }
            }),
        ChangeNotifierProxyProvider<FirebaseAuthService, NearbyParksProvider>(
            create: (_) => NearbyParksProvider(),
            update: (BuildContext context, FirebaseAuthService authService,
                NearbyParksProvider nearbyParksProvider) {
              if (authService.user == null) {
                return nearbyParksProvider..clear();
              } else {
                return nearbyParksProvider..setUpProvider();
              }
            }),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        builder: (context, child) {
          return ScrollConfiguration(behavior: NoGlowBehavior(), child: child);
        },
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
