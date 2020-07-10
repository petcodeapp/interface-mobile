import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petcode_app/models/Pet.dart';

class PetHelper {
  Firestore _firestore = Firestore.instance;
  StreamController controller = new StreamController();

  PetHelper() {
    controller.stream.listen((event) {
      if (event is DocumentSnapshot) {
        Pet newPet = Pet.fromSnapshot(event);
        print(newPet.name);
      }
    });
  }

  Future<DocumentReference> addPetToDb(Pet pet) async {
    print('adding');
    await _firestore.collection('pets').document(pet.pid).setData(pet.toJson());
    return _firestore.collection('pets').document(pet.pid);
  }

  void updatePet(Pet pet) {
    _firestore.collection('pets').document(pet.pid).updateData(pet.toJson());
  }

  addListener(Pet pet) {
    controller.addStream(pet.reference.snapshots());
  }
}
