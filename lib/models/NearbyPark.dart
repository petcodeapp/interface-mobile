import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petcode_app/models/PlacePhoto.dart';

class NearbyPark {
  String name;
  String address;
  LatLng location;
  List<PlacePhoto> placePhotos;

  NearbyPark({this.name, this.address, this.location, this.placePhotos});
}