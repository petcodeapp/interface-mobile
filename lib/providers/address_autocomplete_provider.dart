import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:petcode_app/models/Address.dart';
import 'package:petcode_app/services/address_autocomplete_service.dart';
import 'package:uuid/uuid.dart';

class AddressAutocompleteProvider extends ChangeNotifier {
  AddressAutocompleteService _autocompleteService;
  List<Address> _addresses;

  List<Address> get addresses => _addresses;

  AddressAutocompleteProvider() {
    setUpService();
  }

  setUpService() async {
    String mapsApiKey =
        await FlutterSecureStorage().read(key: 'google_maps_key');
    _autocompleteService = new AddressAutocompleteService(
        apiKey: mapsApiKey, sessionToken: Uuid().v4());
  }

  void getAddressPredictions(String input) async {
    _addresses = await _autocompleteService.getLocationResults(input);
    notifyListeners();
  }
}
