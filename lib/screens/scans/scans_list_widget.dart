import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petcode_app/models/Scan.dart';
import 'package:petcode_app/providers/scans_provider.dart';
import 'package:petcode_app/utils/map_constants.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ScansListWidget extends StatelessWidget {
  ScansListWidget({Key key, this.mapController, this.panelController}) : super(key: key);

  final Completer<GoogleMapController> mapController;
  final PanelController panelController;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    ScansProvider scansProvider = Provider.of<ScansProvider>(context);
    List<Scan> petScans = scansProvider.allScans;

    if (petScans != null) {
      petScans.sort((Scan scanA, Scan scanB) {
        return scanB.date.compareTo(scanA.date);
      });
    }

    List<Widget> scans = new List<Widget>();
    if (petScans != null) {
      for (int i = 0; i < petScans.length; i++) {
        scans.add(recentScanWidget(
            petScans[i].petName,
            petScans[i].date.toDate(),
            MapConstants.markerColors[petScans[i].petIndex],
            petScans[i].location,
            petScans[i].address,
            height,
            width));
        scans.add(
          SizedBox(
            height: height * 0.02,
          ),
        );
      }
    }
    return Container(
      child: ListView(
        children: scans,
      ),
    );
  }

  Widget recentScanWidget(String petName, DateTime date, Color markerColor,
      GeoPoint markerPosition, String address, double height, double width) {
    return GestureDetector(
      onTap: () async {
        panelController.close();
        GoogleMapController googleMapController = await mapController.future;
        LatLng mapPosition =
            LatLng(markerPosition.latitude, markerPosition.longitude);
        googleMapController.animateCamera(
          CameraUpdate.newLatLng(
            mapPosition,
          ),
        );
      },
      child: Container(
        width: width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Container(
            height: height * 0.13,
            //width: width * 0.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(0, 3),
                    blurRadius: 6.0,
                  ),
                ]),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: width * 0.05,
                    backgroundImage: AssetImage('assets/images/stockdog1.jpg'),
                  ),
                  SizedBox(width: width * 0.05,),
                  Container(
                    width: width * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${StringHelper.getDateString(date)} - ${StringHelper.getTimeString(date)}',
                          style: StyleConstants.lightBlackDescriptionTextSmall,
                        ),
                        Text(
                          address,
                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.8)),

                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: StyleConstants.blue,
                    ),
                    height: width * 0.09,
                    width: width * 0.09,
                    child: Center(
                      child: Transform.rotate(
                        angle: 45 * 3.14 / 180,
                        child: Icon(
                          Icons.navigation,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
