import 'dart:math';
import 'package:dio/dio.dart';

class BreedAutocompleteService {
  String apiKey;
  BreedAutocompleteService({this.apiKey});

  Future<List<String>> searchBreeds(String input) async {
    String baseUrl = 'https://api.thedogapi.com/v1/breeds/search';

    Response response = await Dio().get(
      baseUrl,
      queryParameters: {'q': input},
      options: Options(
        headers: {'x-api-key': apiKey},
      ),
    );

    print(response);

    final results = response.data;

    List<String> breedResults = new List<String>();

    for (int i = 0; i < min(5, results.length); i++) {
      breedResults.add(results[i]['name']);
    }

    return breedResults;
  }
}
