import 'dart:async';
import 'package:petcode_app/widgets/sliding_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petcode_app/providers/current_location_provider.dart';
import 'package:petcode_app/providers/scans_map_provider.dart';
import 'package:petcode_app/screens/scans/recent_scan_widget.dart';
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

  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;

    CurrentLocationProvider currentLocationProvider =
        Provider.of<CurrentLocationProvider>(context);

    ScansMapProvider scansMapProvider = Provider.of<ScansMapProvider>(context);

    print(scansMapProvider.panelController != null &&
        scansMapProvider.panelController.isAttached &&
        !scansMapProvider.panelController.isPanelShown);

    return Scaffold(
      backgroundColor: StyleConstants.blue,
      body: SlidingUpPanel(
          controller: scansMapProvider.panelController,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
          backdropColor: StyleConstants.pageBackgroundColor,
          minHeight: height * 0.11,
          maxHeight: height * 0.5,
          header: Center(
            child: Container(
              width: width,
              child: GestureDetector(
                onTap: (){
                  if(scansMapProvider.panelController.isPanelOpen){
                    scansMapProvider.panelController.close();
                  }
                  else{
                    scansMapProvider.panelController.open();
                  }
                },
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
                        style: StyleConstants.blackTitleText.copyWith(fontFamily: 'Open Sans',
                            fontSize: 20.0, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  //end: Alignment(0.01, 0.01),
                  end: Alignment.bottomLeft,
                  stops: [0.01, 0.4, 0.6],
                  colors: [
                    const Color(0xffABDEED),
                    const Color(0xff51BFDA),
                    StyleConstants.blue
                  ], // whitish to gray
                  //tileMode: TileMode.repeated,
                )
            ),
            height: height,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: height * 0.15,
                  decoration: BoxDecoration(
                    gradient: StyleConstants.bgGradient,
                  ),
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
                              /*style: StyleConstants.whiteThinTitleText
                                  .copyWith(fontSize: 25.0, fontWeight: FontWeight.bold),*/

                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Open Sans',
                                fontSize: width * 0.055,
                                fontWeight: FontWeight.bold
                              )
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
                                    topRight: Radius.circular(20.0),
                                    topLeft: Radius.circular(20.0)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20.0),
                                        topLeft: Radius.circular(20.0)),
                                  ),
                                  child: Stack(
                                    children: [
                                      GoogleMap(
                                        padding: EdgeInsets.only(
                                            bottom: scansMapProvider
                                                    .mapBottomPadding + height * 0.08),
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
                                        markers: scansMapProvider
                                            .getMarkers(context),
                                        onTap: (LatLng location) {
                                          scansMapProvider.setNewScan(null);
                                          scansMapProvider.showPanel();
                                        },
                                      ),
                                      scansMapProvider.panelController !=
                                                  null &&
                                              scansMapProvider
                                                  .panelController.isAttached &&
                                              !scansMapProvider
                                                  .panelController.isPanelShown
                                          ? Positioned(
                                              bottom: height * 0.13,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  RecentScanWidget(
                                                    currentScan:
                                                        scansMapProvider
                                                            .selectedScan,
                                                  ),
                                                ],
                                              ),
                                            )
                                          : SizedBox.shrink(),
                                    ],
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
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
