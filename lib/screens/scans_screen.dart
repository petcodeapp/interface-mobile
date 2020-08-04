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
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Scan Locations',
                style: StyleConstants.blackTitleText,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _width * 0.03),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                height: _height * 0.4,
                child: _mapService.currentLocation != null
                    ? GoogleMap(
                        mapType: MapType.hybrid,
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
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Column(
              children: [
                SizedBox(
                  height: _height * 0.02,
                ),
                Text(
                  'Most Recent',
                  style: StyleConstants.blackDescriptionText,
                ),
                SizedBox(
                  height: _height * 0.02,
                ),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: NoGlowBehavior(),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: petScans.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            recentScanWidget(
                                petScans[index].petName,
                                petScans[index].date.toDate(),
                                '5 Address Ln. City, State 77494 USA',
                                _mapService
                                    .markerColors[petScans[index].petIndex],
                                petScans[index].location),
                            SizedBox(
                              height: _height * 0.02,
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

  Widget recentScanWidget(String petName, DateTime date, String address,
      Color markerColor, GeoPoint markerPosition) {
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
        height: _height * 0.1,
        width: _width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: StyleConstants.blue,
        ),
        child: Row(
          children: [
            Container(
              width: _width * 0.445,
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
                            style: StyleConstants.whiteTitleTextSmall,
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
              width: _width * 0.445,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: _width * 0.01),
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
      ),
    );
  }
}
