import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petcode_app/models/Owner.dart';
import 'package:petcode_app/models/Pet.dart';

class PetHelper {
  static Firestore _firestore = Firestore.instance;
  static StreamController controller = new StreamController();

  static Future<DocumentReference> addPetToDb(Pet pet) async {
    await _firestore.collection('pets').document(pet.pid).setData(pet.toJson());
    return _firestore.collection('pets').document(pet.pid);
  }

  static void updatePet(Pet pet) {
    _firestore.collection('pets').document(pet.pid).updateData(pet.toJson());
  }

  static updatePetContacts(String pid, Owner contact1, Owner contact2) async {
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

  static updateImageUrl(String pid, String imageUrl) {
    _firestore.collection('pets').document(pid).updateData({
      'profileUrl': imageUrl,
    });
  }

  static addPetInfo(String pid, String name, String breed, int age, String temperament,
      bool isServiceAnimal) {
    _firestore.collection('pets').document(pid).updateData({
      'name': name,
      'breed': breed,
      'temperament': temperament,
      'isServiceAnimal': isServiceAnimal,
      'age': age,
    });
  }

  static updateMedicalInfo(
      String pid, String allergies, String vetName, String vetPhoneNumber) {
    _firestore.collection('pets').document(pid).updateData({
      'allergies': allergies,
      'vetName': vetName,
      'vetPhoneNumber': vetPhoneNumber,
    });
  }

  static addListener(Pet pet) {
    controller.addStream(pet.reference.snapshots());
  }

  static getAllPetsByUid(String uid) async {
    _firestore.collection('pets').where('uid',isEqualTo: uid).snapshots().listen((QuerySnapshot event) {
      for (DocumentSnapshot doc in event.documents) {
        print(doc.data);
      }
    });
  }
}
