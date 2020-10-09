import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petcode_app/providers/current_location_provider.dart';
import 'package:petcode_app/providers/scans_provider.dart';
import 'package:petcode_app/screens/scans/scans_list_widget.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/custom_app_bars/change_pet_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ScansScreen extends StatefulWidget {
  @override
  _ScansScreenState createState() => _ScansScreenState();
}

class _ScansScreenState extends State<ScansScreen> {
  Completer<GoogleMapController> _controller = Completer();

  double _mapBottomPadding;

  PanelController _panelController;

  @override
  void initState() {
    _mapBottomPadding = 0;
    _panelController = new PanelController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    ScansProvider scansProvider = Provider.of<ScansProvider>(context);

    CurrentLocationProvider currentLocationProvider =
        Provider.of<CurrentLocationProvider>(context);

    return Scaffold(
      appBar: ChangePetAppBar(),
      body: SlidingUpPanel(
          controller: _panelController,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
          backdropColor: StyleConstants.pageBackgroundColor,
          minHeight: height * 0.11,
          onPanelSlide: (double position) {
            setState(() {
              _mapBottomPadding = position * (500 - height * 0.11);
            });
          },
          header: Center(
            child: Container(
              width: width,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 150.0),
                      child: Divider(
                        thickness: 3.0,
                        color: StyleConstants.darkGrey,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      'Scan Locations',
                      style: StyleConstants.blackTitleText,
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Container(
            height: height,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: currentLocationProvider.currentLocation != null
                      ? GoogleMap(
                          padding: EdgeInsets.only(
                              bottom: _mapBottomPadding + height * 0.295),
                          mapType: MapType.normal,
                          indoorViewEnabled: true,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                                currentLocationProvider
                                    .currentLocation.latitude,
                                currentLocationProvider
                                    .currentLocation.longitude),
                            zoom: 14.0,
                          ),
                          onMapCreated: (GoogleMapController controller) {
                            setState(() {

                            });
                            _controller.complete(controller);
                          },
                          zoomControlsEnabled: true,
                          markers: scansProvider.mapMarkers,
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              ],
            ),
          ),
          panel: Container(
            decoration: BoxDecoration(
              color: StyleConstants.pageBackgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.1,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ScansListWidget(
                      controller: _controller,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
