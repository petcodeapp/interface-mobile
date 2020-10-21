import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petcode_app/providers/all_pets_provider.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/providers/current_location_provider.dart';
import 'package:petcode_app/providers/image_marker_provider.dart';
import 'package:petcode_app/providers/nearby_parks_map_provider.dart';
import 'package:petcode_app/providers/nearby_parks_provider.dart';
import 'package:petcode_app/providers/notifications_provider.dart';
import 'package:petcode_app/providers/scans_provider.dart';
import 'package:petcode_app/screens/auth/entry_screen.dart';
import 'package:petcode_app/screens/root_screen.dart';
import 'package:petcode_app/services/check_registration_service.dart';
import 'package:petcode_app/services/database_service.dart';
import 'package:petcode_app/services/firebase_auth_service.dart';
import 'package:petcode_app/services/firebase_storage_service.dart';
import 'package:petcode_app/services/image_picker_service.dart';
import 'package:petcode_app/services/user_service.dart';
import 'package:petcode_app/set_up_keys.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/no_glow_behavior.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SetUpKeys().createKeys();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);

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
              print('clear');
              return userService..clearUid();
            } else {
              print('set up user service');
              return userService..setUid(authService.user.uid);
            }
          },
        ),
        ChangeNotifierProxyProvider<UserService, AllPetsProvider>(
          create: (_) => AllPetsProvider(),
          update: (BuildContext context, UserService userService,
              AllPetsProvider allPetsProvider) {
            if (userService.currentUser == null) {
              return allPetsProvider..clear();
            } else {
              print(userService.currentUser.firstName);
              return allPetsProvider..setPetIds(userService.currentUser.petIds);
            }
          },
        ),
        ChangeNotifierProxyProvider<AllPetsProvider, CurrentPetProvider>(
            create: (_) => CurrentPetProvider(),
            update: (BuildContext context, AllPetsProvider allPetsProvider,
                CurrentPetProvider currentPetProvider) {
              if (allPetsProvider.allPets == null ||
                  allPetsProvider.allPets.length == 0) {
                return currentPetProvider..clearPet();
              } else if (currentPetProvider.currentPet != null) {
                return currentPetProvider..updatePet(allPetsProvider.allPets);
              } else {
                return currentPetProvider
                  ..setCurrentPet(allPetsProvider.allPets[0]);
              }
            }),
        ChangeNotifierProxyProvider<AllPetsProvider, ImageMarkerProvider>(
            create: (_) => ImageMarkerProvider(),
            update: (BuildContext context, AllPetsProvider allPetsProvider,
                ImageMarkerProvider imageMarkerProvider) {
              if (allPetsProvider.allPets == null ||
                  allPetsProvider.allPets.length == 0) {
                return imageMarkerProvider..clear();
              } else {
                List<String> urls = new List<String>();
                for (int i = 0; i < allPetsProvider.allPets.length; i++) {
                  urls.add(allPetsProvider.allPets[i].profileUrl);
                }
                return imageMarkerProvider..setImages(urls);
              }
            }),
        ChangeNotifierProxyProvider2<AllPetsProvider, ImageMarkerProvider,
                ScansProvider>(
            create: (_) => ScansProvider(),
            update: (BuildContext context,
                AllPetsProvider allPetsProvider,
                ImageMarkerProvider imageMarkerProvider,
                ScansProvider scansProvider) {
              if (allPetsProvider.allPets == null ||
                  allPetsProvider.allPets.length == 0 ||
                  imageMarkerProvider.markerImages == null ||
                  imageMarkerProvider.markerImages.length == 0) {
                return scansProvider..clear();
              } else {
                return scansProvider
                  ..setScans(allPetsProvider.allPets,
                      imageMarkerProvider.markerImages);
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
        ChangeNotifierProxyProvider<FirebaseAuthService, NotificationsProvider>(
            create: (_) => NotificationsProvider(),
            update: (BuildContext context, FirebaseAuthService authService,
                NotificationsProvider notificationsProvider) {
              return notificationsProvider..loggedIn = authService.user != null;
            }),
        ChangeNotifierProvider<NearbyParksMapProvider>(
          create: (_) => NearbyParksMapProvider(),
        )
      ],
      child: MaterialApp(
        builder: (context, child) {
          return ScrollConfiguration(behavior: NoGlowBehavior(), child: child);
        },
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StyleConstants().init(context);
    FirebaseAuthService auth = Provider.of<FirebaseAuthService>(context);
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
  }
}
