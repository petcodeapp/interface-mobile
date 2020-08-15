import 'package:dio/dio.dart';
import 'package:petcode_app/models/Address.dart';

class AddressAutocompleteService {
  Future<List<Address>> getLocationResults(String input, String apiKey) async {
    if (input.isNotEmpty) {

      String baseUrl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String type = 'address';

      //TODO Add session token

      String request = '$baseUrl?input=$input&key=$apiKey&types=$type';
      Response response = await Dio().get(request);

      final predictions = response.data['predictions'];

      List<Address> addresses = new List<Address>();

      for (int i = 0; i < predictions.length; i++) {
        final structuredFormatting = predictions[i]['structured_formatting'];
        addresses.add(new Address(mainText: structuredFormatting['main_text'], secondaryText: structuredFormatting['secondary_text']));
      }

      return addresses;
    }
  }

}