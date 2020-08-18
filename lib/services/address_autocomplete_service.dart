import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:petcode_app/models/Address.dart';
import 'package:uuid/uuid.dart';

class AddressAutocompleteService {
  String apiKey;
  String sessionToken;

  AddressAutocompleteService() {
    setUpService();
  }

  setUpService() async {
    apiKey = await FlutterSecureStorage().read(key: 'google_maps_key');
    sessionToken = Uuid().v4();
  }

  Future<List<Address>> getLocationResults(String input) async {
    if (input.isNotEmpty) {
      String baseUrl =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String type = 'address';

      String request =
          '$baseUrl?input=$input&key=$apiKey&types=$type&sessiontoken=$sessionToken';
      Response response = await Dio().get(request);

      final predictions = response.data['predictions'];

      List<Address> addresses = new List<Address>();
      print(predictions);

      for (int i = 0; i < predictions.length; i++) {
        final structuredFormatting = predictions[i]['structured_formatting'];
        addresses.add(new Address(fullName: predictions[i]['description'],
            mainText: structuredFormatting['main_text'],
            secondaryText: structuredFormatting['secondary_text']));
      }
      print(addresses);
      addresses.add(new Address(fullName: 'Powered By Google'));
      return addresses;
    }
    return new List<Address>();
  }
}
