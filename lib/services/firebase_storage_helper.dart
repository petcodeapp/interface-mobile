import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class FirebaseStorageHelper {

  static FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  static final imagePicker = ImagePicker();

  static Future<File> getImageFromGallery() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    return File(pickedFile.path);
  }

  static Future<File> getImageFromCamera() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.camera);
    return File(pickedFile.path);
  }

  static Future<dynamic> addPetImageToStorage(File image) async {
    StorageTaskSnapshot snapshot = await _firebaseStorage.ref().child('profilePictures/${Path.basename(image.path)}').putFile(image).onComplete;
    return snapshot.ref.getDownloadURL();
  }


}