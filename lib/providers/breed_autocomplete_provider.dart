import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:petcode_app/services/breed_autocomplete_service.dart';

class BreedAutocompleteProvider extends ChangeNotifier {
  List<String> _breeds;
  BreedAutocompleteService _autocompleteService;

  BreedAutocompleteProvider() {
    setUpService();
  }

  void setUpService() async {
    String dogApiKey = await FlutterSecureStorage().read(key: 'dog_api_key');
    _autocompleteService = new BreedAutocompleteService(apiKey: dogApiKey);
  }

  void getBreedPredictions(String input) async {
    _breeds = await _autocompleteService.searchBreeds(input);
    notifyListeners();
  }
}
