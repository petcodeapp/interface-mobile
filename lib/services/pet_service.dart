import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:provider/provider.dart';

class PetService {
  Firestore _firestore = Firestore.instance;

  Future<void> createPet(Pet pet) async {
    await _firestore.collection('pets').document(pet.pid).setData(pet.toJson());
  }

  Future<void> updatePet(Pet pet) async {
    await _firestore
        .collection('pets')
        .document(pet.pid)
        .updateData(pet.toJson());
  }

  List<Pet> petListFromQuery(QuerySnapshot snapshot) {
    List<Pet> returnedList = new List<Pet>();
    List<DocumentSnapshot> petSnapshots = snapshot.documents;
    for (int i = 0; i < petSnapshots.length; i++) {
      returnedList.add(Pet.fromSnapshot(petSnapshots[i]));
    }
    return returnedList;
  }

  Stream<List<Pet>> petStream(String uid) {
    return _firestore
        .collection('pets')
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((QuerySnapshot querySnapshot) => petListFromQuery(querySnapshot));
  }
}
