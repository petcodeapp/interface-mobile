import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petcode_app/models/PlacePhoto.dart';
import 'package:petcode_app/providers/current_location_provider.dart';
import 'package:petcode_app/providers/nearby_parks_provider.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';

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
                                parkLocationWidget(
                                    _nearbyParksProvider
                                        .nearbyParks[index].name,
                                    _nearbyParksProvider
                                        .nearbyParks[index].address,
                                    _nearbyParksProvider
                                        .nearbyParks[index].placePhotos,
                                    _nearbyParksProvider
                                        .nearbyParks[index].location),
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

  Widget parkLocationWidget(String parkName, String address,
      List<PlacePhoto> placePhotos, LatLng location) {
    return Container(
      height: _height * 0.29,
      width: _width * 0.9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: StyleConstants.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 0.6,
              offset: Offset(0, 3),
            )
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: _height * 0.19,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: placePhotos.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(
                        _width * 0.03, 10.0, _width * 0.015, 10.0),
                    child: Container(
                      child: Stack(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image(
                            image: placePhotos[index].photo,
                            height: _height * 0.15,
                            width: _width * 0.4,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          left: 10.0,
                          bottom: _height * 0.03,
                          child: Container(
                            width: _width * 0.3,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  placePhotos[index].attributionNames.length,
                              itemBuilder: (BuildContext context, int index2) {
                                return RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          backgroundColor: Colors.black38),
                                      text: placePhotos[index]
                                          .attributionNames[index2],
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          String attributionUrl =
                                              placePhotos[index]
                                                  .attributionLinks[index2];
                                          print('hello');
                                          print(attributionUrl);
                                          if (await canLaunch(attributionUrl)) {
                                            await launch(attributionUrl);
                                          } else {
                                            print('Can\'t launch');
                                          }
                                        }),
                                );
                              },
                            ),
                          ),
                        ),
                      ]),
                    ),
                  );
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(left: 14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                parkName,
                                style: StyleConstants.blueTitleText,
                                maxLines: 2,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Flexible(
                              child: Text(
                                address,
                                style: StyleConstants.yellowDescriptionText,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(right: 15.0),
                          child: GestureDetector(
                            onTap: () async {
                              GoogleMapController controller =
                                  await _controller.future;
                              controller.animateCamera(
                                  CameraUpdate.newLatLng(location));
                              _cameraPosition = CameraPosition(
                                  target: location,
                                  zoom: _cameraPosition.zoom,
                                  bearing: _cameraPosition.bearing,
                                  tilt: _cameraPosition.tilt);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: StyleConstants.blue,
                                border: Border.all(width: 1.3),
                              ),
                              padding: EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.near_me,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
