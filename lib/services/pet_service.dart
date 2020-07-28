import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/models/Medication.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/models/UpcomingEvent.dart';
import 'package:petcode_app/models/Vaccination.dart';

class PetService extends ChangeNotifier {
  Firestore _firestore = Firestore.instance;

  List<Pet> _allPets = new List<Pet>();
  List<ImageProvider> _petImages = new List<ImageProvider>();
  StreamSubscription _petStream;

  List<Pet> get allPets => _allPets;

  List<ImageProvider> get petImages => _petImages;

  setPetIds(List<String> petIds) {
    startPetStream(petIds);
  }

  stopPetStream() {
    _allPets = new List<Pet>();
    _petImages = new List<ImageProvider>();
    if (_petStream != null) {
      _petStream.cancel();
    }
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
    if (petIds != null && petIds.length > 0) {
      _petStream = _firestore
          .collection('pets')
          .where('pid', whereIn: petIds)
          .snapshots()
          .listen((QuerySnapshot querySnapshot) {
        _allPets.clear();
        _petImages.clear();
        _allPets = petListFromQuery(querySnapshot);
        for (int i = 0; i < _allPets.length; i++) {
          if (_allPets[i].profileUrl != null) {
            _petImages.add(NetworkImage(_allPets[i].profileUrl));
          }
          else {
            _petImages.add(AssetImage('assets/images/puppyphoto.jpg'));
          }
        }
        print('All Pets length : ' + _allPets.length.toString());
        notifyListeners();
      });
    }
  }

  List<UpcomingEvent> getAllPetMedication() {
    List<UpcomingEvent> allUpcomingEvents = new List<UpcomingEvent>();
    List<UpcomingEvent> allUpcomingEventsNoDate = new List<UpcomingEvent>();
    for (int i = 0; i < _allPets.length; i++) {
      if (_allPets[i].medications != null) {
        for (int j = 0; j < _allPets[i].medications.length; j++) {
          Medication currentMedication = _allPets[i].medications[j];
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
