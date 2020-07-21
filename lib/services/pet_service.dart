import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';

class PetService extends ChangeNotifier {
  Firestore _firestore = Firestore.instance;

  List<Pet> _allPets = new List<Pet>();
  List<ImageProvider> _petImages = new List<NetworkImage>();

  List<Pet> get allPets => _allPets;

  List<ImageProvider> get petImages => _petImages;

  setPetIds(List<String> petIds) {
    startPetStream(petIds);
  }

  List<Pet> petListFromQuery(QuerySnapshot querySnapshot) {
    List<Pet> returnedList = new List<Pet>();
    List<DocumentSnapshot> petSnapshots = querySnapshot.documents;
    for (int i = 0; i < petSnapshots.length; i++) {
      returnedList.add(Pet.fromSnapshot(petSnapshots[i]));
    }
    return returnedList;
  }

  void startPetStream(List<String> petIds) {
    _firestore
        .collection('pets')
        .where('pid', whereIn: petIds)
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      _allPets.clear();
      _petImages.clear();
      _allPets = petListFromQuery(querySnapshot);
      for (int i = 0; i < _allPets.length; i++) {
        _petImages.add(NetworkImage(_allPets[i].profileUrl));
      }
      print('All Pets length : ' + _allPets.length.toString());
      notifyListeners();
    });
  }
}
