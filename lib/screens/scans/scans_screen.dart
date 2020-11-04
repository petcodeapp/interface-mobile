import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petcode_app/providers/current_location_provider.dart';
import 'package:petcode_app/providers/scans_provider.dart';
import 'package:petcode_app/screens/scans/scans_list_widget.dart';
import 'package:petcode_app/utils/style_constants.dart';
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
    double height = StyleConstants.height;
    double width = StyleConstants.width;

    ScansProvider scansProvider = Provider.of<ScansProvider>(context);

    CurrentLocationProvider currentLocationProvider =
        Provider.of<CurrentLocationProvider>(context);

    return Scaffold(
      backgroundColor: StyleConstants.blue,
      body: SlidingUpPanel(
          controller: _panelController,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
          backdropColor: StyleConstants.pageBackgroundColor,
          minHeight: height * 0.11,
          maxHeight: height * 0.5,
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
                      'View Scan Locations',
                      style: StyleConstants.blackTitleText.copyWith(
                          fontSize: 20.0, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Container(
            height: height,
            decoration: BoxDecoration(
              color: StyleConstants.blue,
              gradient: StyleConstants.bgGradient,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: height * 0.15,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Scan Locations',
                              style: StyleConstants.whiteTitleTextSmall,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                      ],
                    ),
                  ),
                ),
                currentLocationProvider.currentLocation != null
                    ? Expanded(
                        child: currentLocationProvider.currentLocation != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10.0),
                                    topLeft: Radius.circular(10.0)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10.0),
                                        topLeft: Radius.circular(10.0)),
                                  ),
                                  child: GoogleMap(
                                    padding: EdgeInsets.only(
                                        bottom:
                                            _mapBottomPadding + height * 0.18),
                                    mapType: MapType.normal,
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(
                                          currentLocationProvider
                                              .currentLocation.latitude,
                                          currentLocationProvider
                                              .currentLocation.longitude),
                                      zoom: 14.0,
                                    ),
                                    onMapCreated:
                                        (GoogleMapController controller) {
                                      setState(() {});
                                      _controller.complete(controller);
                                    },
                                    zoomControlsEnabled: true,
                                    markers: scansProvider.mapMarkers,
                                  ),
                                ),
                              )
                            : Center(
                                child: SpinKitDualRing(
                                    size: 30.0, color: StyleConstants.yellow),
                              ),
                      )
                    : Center(
                        child: SpinKitDualRing(
                            size: 30.0, color: StyleConstants.yellow),
                      ),
              ],
            ),
          ),
          panel: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.08,
                ),
                Container(
                  height: height * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ScansListWidget(
                      mapController: _controller,
                      panelController: _panelController,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
