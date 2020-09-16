import 'package:flutter/material.dart';
import 'package:petcode_app/providers/provider_state.dart';
import 'package:petcode_app/screens/dashboard/dashboard_screen/navigation_row.dart';
import 'package:petcode_app/screens/dashboard/dashboard_screen/no_pets_indicator.dart';
import 'package:petcode_app/screens/dashboard/dashboard_screen/pets_carousel_widget.dart';
import 'package:petcode_app/screens/dashboard/dashboard_screen/upcoming_events_widget.dart';
import 'package:petcode_app/services/pet_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    PetService petService = Provider.of<PetService>(context);

    petService = Provider.of<PetService>(context);

    if (petService.allPets == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (petService.allPets.length == 0 &&
        petService.providerState == ProviderState.Idle) {
      return Scaffold(
        body: NoPetsAvailableIndicator(),
      );
    } else {
      return Scaffold(
        backgroundColor: StyleConstants.pageBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: StyleConstants.blue,
          title: Container(
              height: 75,
              child: Image.asset(
                'assets/images/appbarlogoyellow.png',
                fit: BoxFit.cover,
              )),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                PetsCarouselWidget(),
                SizedBox(
                  height: height * 0.03,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: NavigationRow(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.035),
                  child: UpcomingEventsWidget(),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
