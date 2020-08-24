import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearbyPark {
  String name;
  String address;
  LatLng location;

  NearbyPark({this.name, this.address, this.location});
}