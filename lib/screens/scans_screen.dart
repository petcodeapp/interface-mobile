import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/services/map_service.dart';
import 'package:petcode_app/services/pet_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class ScansScreen extends StatefulWidget {
  @override
  _ScansScreenState createState() => _ScansScreenState();
}

class _ScansScreenState extends State<ScansScreen> {
  Completer<GoogleMapController> _controller = Completer();
  PetService _petService;
  MapService _mapService;
  double height;
  double width;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    _mapService = Provider.of<MapService>(context);
    _petService = Provider.of<PetService>(context);
    Pet currentPet = _petService.allPets[0];

    if (_mapService.currentLocation == null) {
      _mapService.getCurrentLocation();
    }

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
                child: _mapService.currentLocation != null
                    ? GoogleMap(
                        mapType: MapType.hybrid,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(_mapService.currentLocation.latitude,
                              _mapService.currentLocation.longitude),
                          zoom: 14,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                        zoomControlsEnabled: true,
                        markers: _mapService.createMarkers(currentPet.scans),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
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
                Expanded(
                  child: ScrollConfiguration(
                    behavior: NoGlowBehavior(),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: currentPet.scans.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            recentScanWidget(
                                currentPet.name,
                                currentPet.scans[index].date.toDate(),
                                '5 Address Ln. City, State 77494 USA'),
                            SizedBox(
                              height: height * 0.02,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
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
    String hour = date.hour < 12 ? locationDate.hour.toString() : (locationDate.hour - 12).toString();
    if (hour == '0') {
      hour = '12';
    }
    String minute = date.minute < 10
        ? '0' + date.minute.toString()
        : date.minute.toString();
    return locationDate.month.toString() +
        '/' +
        locationDate.day.toString() +
        '/' +
        locationDate.year.toString() +
        ' @ ' +
        hour +
        ':' +
        minute +
        ' ' +
        end;
  }
}
