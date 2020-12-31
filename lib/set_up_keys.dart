import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SetUpKeys {
  createKeys() {
    FlutterSecureStorage().write(key: 'google_maps_key', value: 'AIzaSyCFv6xZY77hmKpaUm8y5yO7YFFfvRRNdzs');
    FlutterSecureStorage().write(key: 'dog_api_key', value: 'cef57583-fc1a-46a1-8f8c-34addb9c59f3');
  }
}
