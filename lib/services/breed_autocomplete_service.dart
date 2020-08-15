import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    as SecureStorage;

class BreedAutocompleteService {
  String _apiKey;

  BreedAutocompleteService() {
    setUpService();
  }

  void setUpService() async {
    String dogApiKey =
        await SecureStorage.FlutterSecureStorage().read(key: 'dog_api_key');
    _apiKey = dogApiKey;
  }

  Future<List<String>> searchBreeds(String input) async {
    String baseUrl = 'https://api.thedogapi.com/v1/breeds/search';

    Response response = await Dio().get(
      baseUrl,
      queryParameters: {'q': input},
      options: Options(
        headers: {'x-api-key': _apiKey},
      ),
    );

    final results = response.data;

    List<String> breedResults = new List<String>();

    for (int i = 0; i < min(5, results.length); i++) {
      breedResults.add(results[i]['name']);
    }

    print(breedResults);
    return breedResults;
  }
}
