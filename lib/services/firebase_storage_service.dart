import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageService {
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadPetImage(File image, String imageName) async {
    StorageTaskSnapshot storageTaskSnapshot = await _firebaseStorage
        .ref()
        .child('petProfilePictures/' + imageName)
        .putFile(image)
        .onComplete;
    if (storageTaskSnapshot.error != null) {
      print('error: ' + storageTaskSnapshot.error.toString());
      throw storageTaskSnapshot;
    } else {
      final downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    }
  }
}
