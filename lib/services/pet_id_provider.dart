import 'package:flutter/foundation.dart';
import 'package:petcode_app/models/PetId.dart';

class PetIdProvider extends ChangeNotifier {
  PetId _petId;

  PetId get petId => _petId;

  void setPetId(PetId newPetId) {
    _petId = newPetId;
    notifyListeners();
  }
}
