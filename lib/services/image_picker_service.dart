import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  Future<File> pickImage(ImageSource source) async {
     PickedFile picked = await ImagePicker().getImage(source: source);
     return File(picked.path);
  }
}