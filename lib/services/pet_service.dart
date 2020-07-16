import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';

class PetService with ChangeNotifier {
  Firestore _firestore = Firestore.instance;

  List<Pet> _allPets = new List<Pet>();

  List<Pet> get _pets => _allPets;

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
