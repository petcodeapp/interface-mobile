import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petcode_app/models/NearbyPark.dart';

class NearbyParksService {
  String apiKey;

  NearbyParksService() {
    setUpService();
  }

  setUpService() async {
    apiKey = await FlutterSecureStorage().read(key: 'google_maps_key');
  }

  Future<List<NearbyPark>> getNearbyParks(LatLng location) async {
    String baseUrl =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json';
    String locationString = '${location.latitude},${location.longitude}';
    String radius = '4000';
    String keyword = 'dog park';

    String request =
        '$baseUrl?location=$locationString&radius=$radius&keyword=$keyword&key=$apiKey';

    Response response = await Dio().get(request);

    final results = response.data['results'];

    List<NearbyPark> nearbyParks = new List<NearbyPark>();

    for (int i = 0; i < results.length; i++) {
      final parkLocation = results[i]['geometry']['location'];
      nearbyParks.add(new NearbyPark(
        name: results[i]['name'],
        address: results[i]['vicinity'],
        location: LatLng(parkLocation['lat'], parkLocation['lng']),
      ));
    }

    return nearbyParks;
  }

  Set<Marker> nearbyParksToMarkers(List<NearbyPark> nearbyParks) {
    List<Marker> allMarkers = new List<Marker>();

    for (int i = 0; i < nearbyParks.length; i++) {
      allMarkers.add(
        new Marker(
          markerId: MarkerId(nearbyParks[i].name + i.toString() + 'ID'),
          position: nearbyParks[i].location,
        ),
      );
    }

    return allMarkers.toSet();
  }
}
