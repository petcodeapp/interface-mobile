import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/models/Reminder.dart';
import 'package:petcode_app/models/UpcomingEvent.dart';
import 'package:petcode_app/models/Vaccination.dart';
import 'package:petcode_app/providers/provider_state.dart';

class PetService extends ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Pet> _allPets;
  StreamSubscription _petStream;
  ProviderState _providerState = ProviderState.Idle;

  List<Pet> get allPets => _allPets;

  ProviderState get providerState => _providerState;

  setPetIds(List<String> petIds) {
    startPetStream(petIds);
  }

  stopPetStream() {
    _allPets = null;
    if (_petStream != null) {
      _petStream.cancel();
    }
    notifyListeners();
  }

  List<Pet> petListFromQuery(QuerySnapshot querySnapshot) {
    List<Pet> returnedList = new List<Pet>();
    List<DocumentSnapshot> petSnapshots = querySnapshot.docs;
    for (int i = 0; i < petSnapshots.length; i++) {
      returnedList.add(Pet.fromSnapshot(petSnapshots[i]));
    }
    return returnedList;
  }

  void startPetStream(List<String> petIds) {
    _providerState = ProviderState.Busy;
    notifyListeners();
    _allPets = new List<Pet>();
    if (petIds != null && petIds.length > 0) {
      _petStream = _firestore
          .collection('pets')
          .where('pid', whereIn: petIds)
          .snapshots()
          .listen((QuerySnapshot querySnapshot) {
        _allPets.clear();
        _allPets = petListFromQuery(querySnapshot);
        _providerState = ProviderState.Idle;
        notifyListeners();
      });
    }
  }

  List<UpcomingEvent> getAllPetMedication() {
    List<UpcomingEvent> allUpcomingEvents = new List<UpcomingEvent>();
    List<UpcomingEvent> allUpcomingEventsNoDate = new List<UpcomingEvent>();
    for (int i = 0; i < _allPets.length; i++) {
      if (_allPets[i].reminders != null) {
        for (int j = 0; j < _allPets[i].reminders.length; j++) {
          Reminder currentMedication = _allPets[i].reminders[j];
          if (currentMedication.name == null ||
              currentMedication.name.trim().isEmpty) {
            currentMedication.name = 'Untitled';
          }
          if (currentMedication.date != null) {
            UpcomingEvent upcomingEvent = UpcomingEvent(
                name: currentMedication.name,
                petName: _allPets[i].name,
                date: currentMedication.date);
            allUpcomingEvents.add(upcomingEvent);
          } else {
            UpcomingEvent upcomingEvent = UpcomingEvent(
              name: currentMedication.name,
              petName: _allPets[i].name,
            );
            allUpcomingEventsNoDate.add(upcomingEvent);
          }
        }
      }
      if (_allPets[i].vaccinations != null) {
        for (int j = 0; j < _allPets[i].vaccinations.length; j++) {
          Vaccination currentVaccination = _allPets[i].vaccinations[j];
          if (currentVaccination.name == null ||
              currentVaccination.name.trim().isEmpty) {
            currentVaccination.name = 'Untitled';
          }
          if (currentVaccination.date != null) {
            UpcomingEvent upcomingEvent = UpcomingEvent(
                name: currentVaccination.name,
                petName: _allPets[i].name,
                date: currentVaccination.date);
            allUpcomingEvents.add(upcomingEvent);
          } else {
            UpcomingEvent upcomingEvent = UpcomingEvent(
              name: currentVaccination.name,
              petName: _allPets[i].name,
            );
            allUpcomingEventsNoDate.add(upcomingEvent);
          }
        }
      }
    }
    allUpcomingEvents
        .sort((UpcomingEvent upcomingEventA, UpcomingEvent upcomingEventB) {
      return upcomingEventA.date.compareTo(upcomingEventB.date);
    });
    allUpcomingEventsNoDate
        .sort((UpcomingEvent upcomingEventA, UpcomingEvent upcomingEventB) {
      if (upcomingEventA.petName == upcomingEventB.petName) {
        return upcomingEventA.name.compareTo(upcomingEventB.name);
      } else {
        return upcomingEventA.petName.compareTo(upcomingEventB.petName);
      }
    });
    allUpcomingEvents.addAll(allUpcomingEventsNoDate);
    return allUpcomingEvents;
  }
}
