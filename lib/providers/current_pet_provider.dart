import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:petcode_app/models/Pet.dart';

class CurrentPetProvider extends ChangeNotifier {
  Pet _currentPet;

  Pet get currentPet => _currentPet;

  void clearPet() {
    _currentPet = null;
    notifyListeners();
  }

  void setCurrentPet(Pet newPet) {
    _currentPet = newPet;
    notifyListeners();
  }

  void updatePet(List<Pet> allPets) {
    if (allPets.length == 0) {
      _currentPet = null;
    } else {
      allPets.firstWhere((Pet pet) => pet == _currentPet, orElse: () {
        return allPets[0];
      });
    }
    notifyListeners();
  }
}
