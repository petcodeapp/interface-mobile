import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:petcode_app/models/Address.dart';
import 'package:petcode_app/services/address_autocomplete_service.dart';

class AddressAutocompleteProvider extends ChangeNotifier {

  AddressAutocompleteService _autocompleteService;
  List<Address> _addresses;

  String _mapsApiKey;

  setUpService() async {
    _autocompleteService = new AddressAutocompleteService();
    _mapsApiKey = await FlutterSecureStorage().read(key: 'google_maps_key');
  }

  void getAddressPredictions(String input) async {
    _addresses = await _autocompleteService.getLocationResults(input, _mapsApiKey);
    notifyListeners();
  }

}