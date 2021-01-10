import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerService {
  Future<File> pickImage(ImageSource source) async {
    PickedFile picked = await ImagePicker().getImage(source: source);
    return File(picked.path);
  }
}
