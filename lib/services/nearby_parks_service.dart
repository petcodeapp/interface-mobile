import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:html/parser.dart';
import 'package:petcode_app/models/NearbyPark.dart';
import 'package:petcode_app/models/PlacePhoto.dart';
import 'package:petcode_app/utils/style_constants.dart';

class NearbyParksService {
  String apiKey;

  NearbyParksService() {
    setUpService();
  }

  setUpService() async {
    apiKey = await FlutterSecureStorage().read(key: 'google_maps_key');
  }

  Future<List<NearbyPark>> getNearbyParks(LatLng location, double zoom) async {
    String baseUrl =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json';
    String locationString = '${location.latitude},${location.longitude}';
    String radius =
        (min(6081740800 / (256 * pow(2, zoom).toDouble()), 50000)).toString();

    print('radius: ' + radius);
    String keyword = 'dog park';

    String request =
        '$baseUrl?location=$locationString&radius=$radius&keyword=$keyword&key=$apiKey';

    Response response = await Dio().get(request);

    final results = response.data['results'];

    List<NearbyPark> nearbyParks = new List<NearbyPark>();

    for (int i = 0; i < results.length; i++) {
      final parkLocation = results[i]['geometry']['location'];

      List<PlacePhoto> placePhotos = await getPhotos(results[i]['place_id']);

      nearbyParks.add(new NearbyPark(
        name: results[i]['name'],
        address: results[i]['vicinity'],
        location: LatLng(parkLocation['lat'], parkLocation['lng']),
        placePhotos: placePhotos,
      ));
    }

    return nearbyParks;
  }

  Future<List<PlacePhoto>> getPhotos(String placeId) async {
    String baseUrl = 'https://maps.googleapis.com/maps/api/place/details/json';
    String fields = 'photo';
    String request = '$baseUrl?place_id=$placeId&fields=$fields&key=$apiKey';

    Response response = await Dio().get(request);

    List<PlacePhoto> photos = new List<PlacePhoto>();

    final data = response.data['result']['photos'];

    for (int i = 0; i < min(2, data.length); i++) {
      final photo = data[i];
      List<String> photoAttributionNames = new List<String>();
      List<String> photoAttributionLinks = new List<String>();

      final attributions = photo['html_attributions'];
      for (int j = 0; j < attributions.length; j++) {
        var doc = parseFragment(attributions[j]);
        var child = doc.firstChild;
        print('text: ' + doc.text);

        try {
          photoAttributionNames.add(doc.text);
          photoAttributionLinks.add(child.attributes['href']);
        } catch (e) {
          print(e);
        }
      }
      photos.add(PlacePhoto(
          photo: CachedNetworkImageProvider(
              'https://maps.googleapis.com/maps/api/place/photo?maxheight=200&photoreference=${photo['photo_reference']}&key=$apiKey'),
          attributionNames: photoAttributionNames,
          attributionLinks: photoAttributionLinks));
    }

    return photos;
  }

  Set<Marker> nearbyParksToMarkers(List<NearbyPark> nearbyParks) {
    List<Marker> allMarkers = new List<Marker>();

    for (int i = 0; i < nearbyParks.length; i++) {
      allMarkers.add(
        new Marker(
          markerId: MarkerId(nearbyParks[i].name + i.toString() + 'ID'),
          position: nearbyParks[i].location,
          icon: BitmapDescriptor.defaultMarkerWithHue(42.0),
        ),
      );
    }

    return allMarkers.toSet();
  }
}
