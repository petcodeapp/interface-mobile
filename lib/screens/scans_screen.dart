import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petcode_app/utils/style_constants.dart';

class ScansScreen extends StatefulWidget {
  @override
  _ScansScreenState createState() => _ScansScreenState();
}

class _ScansScreenState extends State<ScansScreen> {
  Completer<GoogleMapController> _controller = Completer();
  Position _currentLocation;
  double height;
  double width;

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Scan Locations',
                style: StyleConstants.blackTitleText,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                height: height * 0.4,
                child: _currentLocation != null
                    ? GoogleMap(
                        mapType: MapType.hybrid,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(_currentLocation.latitude,
                              _currentLocation.longitude),
                          zoom: 14,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                        zoomControlsEnabled: false,
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    'Most Recent',
                    style: StyleConstants.blackDescriptionText,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  recentScanWidget('Reggie', DateTime.now(),
                      '5 Address Ln. City, State 77494 USA'),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  recentScanWidget('Reggie', DateTime.now(),
                      '5 Address Ln. City, State 77494 USA'),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  recentScanWidget('Reggieasasdfdfasdfadsfa', DateTime.now(),
                      '5 Address Ln. City, State 77494 USA'),
                  SizedBox(
                    height: height * 0.01,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _getCurrentLocation() async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    Position currentLocation = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    setState(() {
      _currentLocation = currentLocation;
    });
  }

  Widget recentScanWidget(String petName, DateTime date, String address) {
    return Container(
      height: height * 0.1,
      width: width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: StyleConstants.blue,
      ),
      child: Row(
        children: [
          Container(
            width: width * 0.445,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Icon(
                      Icons.place,
                      color: StyleConstants.yellow,
                      size: width * 0.1,
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          petName,
                          style: StyleConstants.whiteTitleTextSmall,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          formatDate(date),
                          style: StyleConstants.whiteDescriptionTextXS,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          VerticalDivider(
            width: 2.0,
            color: StyleConstants.white,
          ),
          Container(
            width: width * 0.445,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                    child: Text(
                      address,
                      style: StyleConstants.whiteDescriptionTextSmall,
                      textAlign: TextAlign.center,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formatDate(DateTime date) {
    DateTime locationDate = date.toLocal();
    String end = date.hour < 12 ? 'am' : 'pm';
    String minute = date.minute < 10
        ? '0' + date.minute.toString()
        : date.minute.toString();
    return locationDate.month.toString() +
        '/' +
        locationDate.day.toString() +
        '/' +
        locationDate.year.toString() +
        ' @ ' +
        (locationDate.hour - 12).toString() +
        ':' +
        minute +
        ' ' +
        end;
  }
}
