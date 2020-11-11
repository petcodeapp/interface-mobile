import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petcode_app/models/NearbyPark.dart';
import 'package:petcode_app/providers/current_location_provider.dart';
import 'package:petcode_app/providers/nearby_parks_map_provider.dart';
import 'package:petcode_app/providers/nearby_parks_provider.dart';
import 'package:petcode_app/providers/notifications_provider.dart';
import 'package:petcode_app/providers/provider_state.dart';
import 'package:petcode_app/utils/hero_icons2.dart';
import 'package:petcode_app/utils/map_constants.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/screens/social/discover_parks/show_nearby_park_widget.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DiscoverParksScreen extends StatefulWidget {
  @override
  _DiscoverParksScreenState createState() => _DiscoverParksScreenState();
}

class _DiscoverParksScreenState extends State<DiscoverParksScreen> {
  double _height;
  double _width;

  double _mapBottomPadding;

  NearbyParksProvider _nearbyParksProvider;
  NearbyParksMapProvider _nearbyParksMapProvider;

  Completer<GoogleMapController> _controller = Completer();
  PanelController _panelController;

  bool _cameraMoved = false;
  bool firstLoad = true;

  NearbyPark _selectedPark;

  @override
  void initState() {
    _mapBottomPadding = StyleConstants.height * 0.11;

    _panelController = new PanelController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("moved: " + _cameraMoved.toString());
    _height = StyleConstants.height;
    _width = StyleConstants.width;

    CurrentLocationProvider currentLocationProvider =
        Provider.of<CurrentLocationProvider>(context);

    _nearbyParksProvider = Provider.of<NearbyParksProvider>(context);

    _nearbyParksMapProvider = Provider.of<NearbyParksMapProvider>(context);

    if (currentLocationProvider.currentLocation != null && firstLoad) {
      _nearbyParksProvider.getNearbyParks(
          LatLng(
            currentLocationProvider.currentLocation.latitude,
            currentLocationProvider.currentLocation.longitude,
          ),
          14.0);
      _nearbyParksMapProvider.setCameraPosition(CameraPosition(
          target: LatLng(
            currentLocationProvider.currentLocation.latitude,
            currentLocationProvider.currentLocation.longitude,
          ),
          zoom: 14.0));
      firstLoad = false;
    }

    BorderRadiusGeometry topRoundedRadius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );

    return Scaffold(
      body: SlidingUpPanel(
        controller: _panelController,
        minHeight: _height * 0.11,
        borderRadius: topRoundedRadius,
        header: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: topRoundedRadius,
            ),
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
                    height: _height * 0.02,
                  ),
                  Text(
                    'Nearby Pet Parks',
                    style: TextStyle(
                      color: StyleConstants.lightBlack,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          height: _height,
          decoration: BoxDecoration(
            color: StyleConstants.blue,
            gradient: StyleConstants.bgGradient,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: _height * 0.15,
                decoration: BoxDecoration(
                  gradient: StyleConstants.bgGradient,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: _width * 0.1, vertical: _height * 0.02),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: _height * 0.055,
                          child: Text('Pet Parks',
                              style: StyleConstants.whiteDescriptionText
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.0)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          height: _height * 0.06,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 25.0,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              currentLocationProvider.currentLocation != null
                  ? Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0)),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.0),
                                topLeft: Radius.circular(10.0)),
                          ),
                          child: Stack(
                            children: [
                              GoogleMap(
                                padding:
                                    EdgeInsets.only(bottom: _mapBottomPadding),
                                initialCameraPosition:
                                    _nearbyParksMapProvider.cameraPosition,
                                onMapCreated: (GoogleMapController controller) {
                                  _controller.complete(controller);
                                },
                                markers: createMarkers(
                                    _nearbyParksProvider.nearbyParks),
                                onCameraMove: (CameraPosition position) {
                                  _nearbyParksMapProvider
                                      .setCameraPosition(position);
                                  if (_cameraMoved == false) {
                                    setState(() {
                                      _cameraMoved = true;
                                    });
                                  }
                                },
                                onTap: (LatLng tappedPosition) async {
                                  await _panelController.show();
                                  setState(() {
                                    _selectedPark = null;
                                    _mapBottomPadding = _height * 0.11;
                                  });
                                },
                                mapToolbarEnabled: false,
                              ),
                              _panelController.isAttached &&
                                      !_panelController.isPanelShown
                                  ? Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: _height * 0.025),
                                        child: ShowNearbyParkWidget(
                                          shownPark: _selectedPark,
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                              _cameraMoved
                                  ? searchAreaWidget()
                                  : SizedBox.shrink(),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
        panel: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: topRoundedRadius,
          ),
          child: Column(
            children: [
              SizedBox(
                height: _height * 0.08,
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
                                mainAxisSize: MainAxisSize.min,
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
        ),
        color: StyleConstants.veryLightGrey,
      ),
    );
  }

  Widget searchAreaWidget() {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: _height * 0.02,
          ),
          GestureDetector(
            onTap: () async {
              await _nearbyParksProvider.getNearbyParks(
                  LatLng(_nearbyParksMapProvider.cameraPosition.target.latitude,
                      _nearbyParksMapProvider.cameraPosition.target.longitude),
                  _nearbyParksMapProvider.cameraPosition.zoom);
              setState(() {
                _cameraMoved = false;
              });
            },
            child: Container(
              height: 40.0,
              width: 125.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Center(
                child: _nearbyParksProvider.providerState == ProviderState.Idle
                    ? Text(
                        'Search this Area',
                        style: TextStyle(
                          color: StyleConstants.red,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.0,
                        ),
                      )
                    : AspectRatio(
                        aspectRatio: 1.0,
                        child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                            )),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Set<Marker> createMarkers(List<NearbyPark> nearbyParks) {
    if (nearbyParks == null) {
      return null;
    } else {
      List<Marker> allMarkers = new List<Marker>();

      for (int i = 0; i < nearbyParks.length; i++) {
        allMarkers.add(
          new Marker(
            markerId: MarkerId(nearbyParks[i].name + i.toString() + 'ID'),
            position: nearbyParks[i].location,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                MapConstants.bitmapDescriptorHues[1]),
            onTap: () async {
              await _panelController.hide();
              setState(() {
                _cameraMoved = true;
                _selectedPark = nearbyParks[i];
                _mapBottomPadding = _height * 0.32;
              });
            },
          ),
        );
      }
      return allMarkers.toSet();
    }
  }
}
