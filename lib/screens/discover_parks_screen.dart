import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petcode_app/providers/current_location_provider.dart';
import 'package:petcode_app/providers/nearby_parks_provider.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DiscoverParksScreen extends StatefulWidget {
  @override
  _DiscoverParksScreenState createState() => _DiscoverParksScreenState();
}

class _DiscoverParksScreenState extends State<DiscoverParksScreen> {
  double _height;
  double _width;

  NearbyParksProvider _nearbyParksProvider;
  CurrentLocationProvider _currentLocationProvider;

  Completer<GoogleMapController> _controller = Completer();

  bool firstLoad = true;

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
      _nearbyParksProvider.getNearbyParks(LatLng(
          _currentLocationProvider.currentLocation.latitude,
          _currentLocationProvider.currentLocation.longitude));
      firstLoad = false;
    }

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
                        thickness: 5.0,
                      ),
                    ),
                    SizedBox(
                      height: _height * 0.01,
                    ),
                    Text(
                      'Pet Parks Near You',
                      style: StyleConstants.blackThinTitleTextSmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: _currentLocationProvider.currentLocation != null
              ? GoogleMap(
                  padding: EdgeInsets.only(bottom: 180.0),
                  initialCameraPosition: CameraPosition(
                      target: LatLng(
                          _currentLocationProvider.currentLocation.latitude,
                          _currentLocationProvider.currentLocation.longitude),
                      zoom: 14.0),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: _nearbyParksProvider.nearbyParkMarkers,
                )
              : Container(
                  height: _height * 0.01,
                  width: _width * 0.01,
                  child: CircularProgressIndicator()),
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
                                  SizedBox(
                                    height: _height * 0.03,
                                  ),
                                  parkLocationWidget(
                                      _nearbyParksProvider
                                          .nearbyParks[index].name,
                                      _nearbyParksProvider
                                          .nearbyParks[index].address),
                                ],
                              );
                            },
                          )
                        : SizedBox.shrink(),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget parkLocationWidget(String parkName, String address) {
    return Container(
      height: _height * 0.13,
      width: _width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: StyleConstants.purpleGrey,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              //color: Colors.blue,
              //width: _width * 0.443,
              child: Center(
                child: Icon(
                  Icons.place,
                  color: StyleConstants.red,
                  size: _width * 0.1,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    parkName,
                    style: StyleConstants.lightBlackThinTitleTextSmall,
                    maxLines: 2,
                  ),
                ),
                Flexible(
                  child: Text(
                    address,
                    style: StyleConstants.greyThinDescriptionTextSmall,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
