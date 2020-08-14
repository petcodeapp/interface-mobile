import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/models/Scan.dart';
import 'package:petcode_app/services/map_service.dart';
import 'package:petcode_app/services/pet_service.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class ScansScreen extends StatefulWidget {
  @override
  _ScansScreenState createState() => _ScansScreenState();
}

class _ScansScreenState extends State<ScansScreen> {
  Completer<GoogleMapController> _controller = Completer();
  double _height;
  double _width;

  PetService _petService;
  MapService _mapService;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    _mapService = Provider.of<MapService>(context);
    _petService = Provider.of<PetService>(context);

    if (_mapService.currentLocation == null) {
      _mapService.getCurrentLocation();
    }

    List<Scan> petScans = new List<Scan>();
    List<Pet> allPets = _petService.allPets;
    for (int i = 0; i < allPets.length; i++) {
      if (allPets[i].scans != null) {
        for (int j = 0; j < allPets[i].scans.length; j++) {
          Scan currentScan = allPets[i].scans[j];
          currentScan.petName = allPets[i].name;
          currentScan.petIndex = i;
          petScans.add(currentScan);
        }
      }
    }

    petScans.sort((Scan scanA, Scan scanB) {
      return scanB.date.compareTo(scanA.date);
    });

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: _height * 0.35,
            child: _mapService.currentLocation != null
                ? GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(_mapService.currentLocation.latitude,
                          _mapService.currentLocation.longitude),
                      zoom: 14.0,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    zoomControlsEnabled: true,
                    markers: _mapService.createMarkers(petScans),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: ScrollConfiguration(
              behavior: NoGlowBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: _height * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: _width * 0.05),
                      child: Container(
                        width: _width,
                        child: Text(
                          'Scan Locations',
                          style: StyleConstants.greyThinTitleText,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _height * 0.02,
                    ),
                    scanLocationsList(petScans),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget scanLocationsList(List<Scan> petScans) {
    List<Widget> scans = new List<Widget>();
    for (int i = 0; i < petScans.length; i++) {
      scans.add(recentScanWidget(
          petScans[i].petName,
          petScans[i].date.toDate(),
          _mapService.markerColors[petScans[i].petIndex],
          petScans[i].location));
      scans.add(
        SizedBox(
          height: _height * 0.02,
        ),
      );
    }

    return Column(
      children: scans,
    );
  }

  Widget recentScanWidget(String petName, DateTime date, Color markerColor,
      GeoPoint markerPosition) {
    return GestureDetector(
      onTap: () async {
        GoogleMapController controller = await _controller.future;
        LatLng mapPosition =
            LatLng(markerPosition.latitude, markerPosition.longitude);
        controller.animateCamera(
          CameraUpdate.newLatLng(
            mapPosition,
          ),
        );
      },
      child: Container(
        height: _height * 0.13,
        width: _width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: StyleConstants.purpleGrey,
        ),
        child: Row(
          children: [
            Container(
              width: _width * 0.443,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Icon(
                        Icons.place,
                        color: markerColor,
                        size: _width * 0.1,
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
                            style: StyleConstants.greyThinTitleTextSmall,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            StringHelper.getDateString(date) +
                                ' ' +
                                StringHelper.getTimeString(date),
                            style: StyleConstants.greyThinDescriptionTextSmall,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            VerticalDivider(
              indent: _height * 0.02,
              endIndent: _height * 0.02,
              width: 4.0,
              color: StyleConstants.darkPurpleGrey,
            ),
            Container(
              width: _width * 0.443,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: _width * 0.01),
                        child: FutureBuilder<String>(
                          future:
                              _mapService.getLocationAddress(markerPosition),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.done) {
                              return CircularProgressIndicator();
                            } else {
                              if (snapshot.hasError) {
                                return Text('Error');
                              } else {
                                return Text(
                                  snapshot.data,
                                  style: StyleConstants
                                      .greyThinDescriptionTextSmall,
                                  textAlign: TextAlign.center,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                );
                              }
                            }
                          },
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
