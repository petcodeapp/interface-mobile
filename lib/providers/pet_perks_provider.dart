import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:petcode_app/models/PetPerk.dart';
import 'package:petcode_app/services/pet_perks_service.dart';

class PetPerksProvider extends ChangeNotifier {
  List<PetPerk> _allPetPerks;
  PetPerksService _petPerksService;
  String _currentFilter;

  StreamSubscription<List<PetPerk>> _petPerksStream;

  List<PetPerk> get allPetPerks => _allPetPerks;
  String get currentFilter => _currentFilter;

  PetPerksProvider() {
    _allPetPerks = <PetPerk>[];
    _petPerksService = new PetPerksService();
    _currentFilter = 'none';
  }

  void listenToPetPerks() {
    _petPerksStream =
        _petPerksService.startPetPerksStream().listen((List<PetPerk> petPerks) {
      _allPetPerks = petPerks;
      notifyListeners();
    });
  }

  void setFilter(String filter) {
    _currentFilter = filter;
    notifyListeners();
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
