import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/models/UpcomingEvent.dart';
import 'package:petcode_app/providers/provider_state.dart';
import 'package:petcode_app/services/pet_service.dart';

class AllPetsProvider extends ChangeNotifier {
  List<Pet> _allPets;
  StreamSubscription _petsSubscription;
  ProviderState _providerState = ProviderState.Idle;

  List<Pet> get allPets => _allPets;

  ProviderState get providerState => _providerState;

  PetService _petService;

  AllPetsProvider() {
    _petService = new PetService();
  }

  void setPetIds(List<String> petIds) {
    if (petIds != null && petIds.length > 0) {
      _providerState = ProviderState.Busy;
      notifyListeners();
      _petsSubscription = _petService.createPetStream(petIds).listen((List<Pet> allPets) {
        _allPets = allPets;
        _providerState = ProviderState.Idle;
        notifyListeners();
      });
    }
    else {
      _allPets = new List<Pet>();
    }
  }

  List<UpcomingEvent> getAllPetReminders() {
    return _petService.getAllPetMedication(_allPets);
  }

  void clear() {
    _allPets = null;
    if (_petsSubscription != null) {
      _petsSubscription.cancel();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    if (_petsSubscription != null) {
      _petsSubscription.cancel();
    }
    super.dispose();
  }
}
