import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadPetImage(File image, String imageName) async {
    TaskSnapshot taskSnapshot = await _firebaseStorage
        .ref()
        .child('petProfilePictures/' + imageName)
        .putFile(image)
        .catchError((Object e) {
      print(e);
      throw e;
    });
    final downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> uploadVaccineImage(File image, String imageName) async {
    TaskSnapshot taskSnapshot = await _firebaseStorage
        .ref()
        .child('vaccineImages/' + imageName)
        .putFile(image)
        .catchError((Object e) {
      print(e);
      throw e;
    });
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
