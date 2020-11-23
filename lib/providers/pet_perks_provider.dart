import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:petcode_app/models/PetPerk.dart';
import 'package:petcode_app/services/pet_perks_service.dart';

class PetPerksProvider extends ChangeNotifier {
  List<PetPerk> _allPetPerks;
  PetPerksService _petPerksService;

  StreamSubscription<List<PetPerk>> _petPerksStream;

  List<PetPerk> get allPetPerks => _allPetPerks;

  PetPerksProvider() {
    _allPetPerks = new List<PetPerk>();
    _petPerksService = new PetPerksService();
  }

  void listenToPetPerks() {
    _petPerksStream =
        _petPerksService.startPetPerksStream().listen((List<PetPerk> petPerks) {
      _allPetPerks = petPerks;
      notifyListeners();
    });
  }

  void clear() {
    _allPetPerks = null;
    _petPerksService = null;
    if (_petPerksStream != null) {
      _petPerksStream.cancel();
    }
    _petPerksStream = null;
  }

  @override
  void dispose() {
    _allPetPerks = null;
    _petPerksService = null;
    if (_petPerksStream != null) {
      _petPerksStream.cancel();
    }
    super.dispose();
  }
}
