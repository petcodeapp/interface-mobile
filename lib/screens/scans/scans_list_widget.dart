import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petcode_app/models/Scan.dart';
import 'package:petcode_app/providers/scans_map_provider.dart';
import 'package:petcode_app/providers/scans_provider.dart';
import 'package:petcode_app/screens/scans/recent_scan_widget.dart';
import 'package:provider/provider.dart';

class ScansListWidget extends StatelessWidget {
  ScansListWidget({Key key, this.mapController}) : super(key: key);

  final Completer<GoogleMapController> mapController;

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
        scans.add(listItemWidget(petScans[i], context));
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

  Widget listItemWidget(Scan scan, BuildContext context) {
    ScansMapProvider scansMapProvider = Provider.of<ScansMapProvider>(context);

    return GestureDetector(
      onTap: () async {
        scansMapProvider.closePanel();
        GoogleMapController googleMapController = await mapController.future;
        LatLng mapPosition =
            LatLng(scan.location.latitude, scan.location.longitude);
        googleMapController.animateCamera(
          CameraUpdate.newLatLng(
            mapPosition,
          ),
        );
      },
      child: RecentScanWidget(
        currentScan: scan,
      ),
    );
  }
}
