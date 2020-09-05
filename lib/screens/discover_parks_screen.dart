import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petcode_app/providers/current_location_provider.dart';
import 'package:petcode_app/providers/nearby_parks_provider.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/show_nearby_park_widget.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DiscoverParksScreen extends StatefulWidget {
  @override
  _DiscoverParksScreenState createState() => _DiscoverParksScreenState();
}

class _DiscoverParksScreenState extends State<DiscoverParksScreen> {
  double _height;
  double _width;

  NearbyParksProvider _nearbyParksProvider;
  CurrentLocationProvider _currentLocationProvider;

  CameraPosition _cameraPosition;

  Completer<GoogleMapController> _controller = Completer();
  PanelController _panelController = new PanelController();

  bool firstLoad = true;
  bool _cameraMoved = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    _currentLocationProvider = Provider.of<CurrentLocationProvider>(context);
    _nearbyParksProvider = Provider.of<NearbyParksProvider>(context);

    if (_currentLocationProvider.currentLocation != null && firstLoad) {
      _cameraPosition = CameraPosition(
          target: LatLng(
            _currentLocationProvider.currentLocation.latitude,
            _currentLocationProvider.currentLocation.longitude,
          ),
          zoom: 14.0);
      _nearbyParksProvider.getNearbyParks(
          LatLng(_currentLocationProvider.currentLocation.latitude,
              _currentLocationProvider.currentLocation.longitude),
          14.0);
      firstLoad = false;
    }

    BorderRadiusGeometry topRoundedRadius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: StyleConstants.blue,
        title: Container(
            //color: Colors.white,
            height: 75,
            //width: 200,
            child: Image.asset(
              'assets/images/appbarlogoyellow.png',
              fit: BoxFit.cover,
            )),
      ),
      body: SlidingUpPanel(
        controller: _panelController,
        minHeight: _height * 0.11,
        borderRadius: topRoundedRadius,
        header: Center(
          child: Container(
            width: _width,
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
                    height: _height * 0.01,
                  ),
                  Text(
                    'Nearby Pet Parks',
                    style: StyleConstants.blackTitleText,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: _currentLocationProvider.currentLocation != null
            ? GoogleMap(
                padding: EdgeInsets.only(bottom: 180.0),
                initialCameraPosition: _cameraPosition,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: _nearbyParksProvider.nearbyParkMarkers,
                onCameraMove: (CameraPosition position) {
                  //_nearbyParksProvider.getNearbyParks(position.target);
                  _cameraPosition = position;
                  _cameraMoved = true;
                },
              )
            : Center(child: CircularProgressIndicator()),
        panel: Column(
          children: [
            SizedBox(
              height: _height * 0.1,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: _nearbyParksProvider.nearbyParks != null
                      ? ListView.builder(
                          itemCount: _nearbyParksProvider.nearbyParks.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                ShowNearbyParkWidget(
                                  shownPark:
                                      _nearbyParksProvider.nearbyParks[index],
                                ),
                                SizedBox(
                                  height: _height * 0.03,
                                ),
                              ],
                            );
                          },
                        )
                      : SizedBox.shrink(),
                ),
              ),
            ),
          ],
        ),
        color: StyleConstants.veryLightGrey,
      ),
    );
  }
}
