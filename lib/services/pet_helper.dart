import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petcode_app/models/Owner.dart';
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
    await _firestore.collection('pets').document(pet.pid).setData(pet.toJson());
    return _firestore.collection('pets').document(pet.pid);
  }

  void updatePet(Pet pet) {
    _firestore.collection('pets').document(pet.pid).updateData(pet.toJson());
  }

  addPetInitial(String pid) async {
    Pet pet = new Pet(pid: pid);
    print(pid);
    _firestore.collection('pets').document(pid).setData(pet.toJson());
  }

  addPetContact(String pid, Owner contact1, Owner contact2) async {

    Map<String, dynamic> contact1Json;
    if (contact1 != null) {
      contact1Json = contact1.toJson();
    }

    Map<String, dynamic> contact2Json;
    if (contact2 != null) {
      contact2Json = contact2.toJson();
    }

    _firestore.collection('pets').document(pid).updateData({
      'contact_1': contact1Json,
      'contact_2': contact2Json,
    });
  }

  updateImageUrl(String pid, String imageUrl) {
    _firestore.collection('pets').document(pid).updateData({
      'profileUrl': imageUrl,
    });
  }

  addPetInfo(String pid, String name, String breed, int age, String temperament, bool isServiceAnimal) {
    _firestore.collection('pets').document(pid).updateData({
      'name': name,
      'breed': breed,
      'temperament': temperament,
      'isServiceAnimal': isServiceAnimal,
      'age': age,
    });
  }

  updateMedicalInfo(String pid, String allergies, String vetName, String vetPhoneNumber) {
    _firestore.collection('pets').document(pid).updateData({
      'allergies': allergies,
      'vetName': vetName,
      'vetPhoneNumber': vetPhoneNumber,
    });
  }


  addListener(Pet pet) {
    controller.addStream(pet.reference.snapshots());
  }
}
