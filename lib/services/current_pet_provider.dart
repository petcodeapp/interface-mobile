import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:petcode_app/models/Pet.dart';

class CurrentPetProvider extends ChangeNotifier {
  Pet _currentPet;

  Pet get currentPet => _currentPet;

  void setCurrentPet(Pet newPet) {
    _currentPet = newPet;
    notifyListeners();
  }
}
