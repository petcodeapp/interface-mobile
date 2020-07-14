import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class FirebaseStorageHelper {

  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final imagePicker = ImagePicker();

  Future<File> getImageFromGallery() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    return File(pickedFile.path);
  }

  Future<File> getImageFromCamera() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.camera);
    return File(pickedFile.path);
  }

  Future<dynamic> addPetImageToStorage(File image) async {
    StorageTaskSnapshot snapshot = await _firebaseStorage.ref().child('petProfileUrls/${Path.basename(image.path)}').putFile(image).onComplete;
    return snapshot.ref.getDownloadURL();
  }


}