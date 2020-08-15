import 'package:dio/dio.dart';
import 'package:petcode_app/models/Address.dart';

class AddressAutocompleteService {
  String apiKey;
  String sessionToken;

  AddressAutocompleteService({this.apiKey, this.sessionToken});

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

      for (int i = 0; i < predictions.length; i++) {
        final structuredFormatting = predictions[i]['structured_formatting'];
        addresses.add(new Address(
            mainText: structuredFormatting['main_text'],
            secondaryText: structuredFormatting['secondary_text']));
      }

      return addresses;
    }
  }
}
