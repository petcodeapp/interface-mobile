import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/models/Reminder.dart';
import 'package:petcode_app/models/UpcomingEvent.dart';

class PetService extends ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Pet> petListFromQuery(QuerySnapshot querySnapshot) {
    List<Pet> returnedList = new List<Pet>();
    List<DocumentSnapshot> petSnapshots = querySnapshot.docs;
    for (int i = 0; i < petSnapshots.length; i++) {
      returnedList.add(Pet.fromSnapshot(petSnapshots[i]));
    }
    return returnedList;
  }

  Stream<List<Pet>> createPetStream(List<String> petIds) {
    return _firestore
        .collection('pets')
        .where('pid', whereIn: petIds)
        .snapshots()
        .map((QuerySnapshot querySnapshot) => petListFromQuery(querySnapshot));
  }

  List<UpcomingEvent> getAllPetMedication(List<Pet> allPets) {
    List<UpcomingEvent> allUpcomingEvents = new List<UpcomingEvent>();
    List<UpcomingEvent> allUpcomingEventsNoDate = new List<UpcomingEvent>();
    for (int i = 0; i < allPets.length; i++) {
      if (allPets[i].reminders != null) {
        for (int j = 0; j < allPets[i].reminders.length; j++) {
          Reminder currentReminder = allPets[i].reminders[j];
          if (currentReminder.name == null ||
              currentReminder.name.trim().isEmpty) {
            currentReminder.name = 'Untitled';
          }
          if (currentReminder.startDate != null) {
            UpcomingEvent upcomingEvent = UpcomingEvent(
                name: currentReminder.name,
                petName: allPets[i].name,
                date: currentReminder.startDate);
            allUpcomingEvents.add(upcomingEvent);
          } else {
            UpcomingEvent upcomingEvent = UpcomingEvent(
              name: currentReminder.name,
              petName: allPets[i].name,
            );
            allUpcomingEventsNoDate.add(upcomingEvent);
          }
        }
      }
      // if (_allPets[i].vaccinations != null) {
      //   for (int j = 0; j < _allPets[i].vaccinations.length; j++) {
      //     Vaccination currentVaccination = _allPets[i].vaccinations[j];
      //     if (currentVaccination.name == null ||
      //         currentVaccination.name.trim().isEmpty) {
      //       currentVaccination.name = 'Untitled';
      //     }
      //     if (currentVaccination.date != null) {
      //       UpcomingEvent upcomingEvent = UpcomingEvent(
      //           name: currentVaccination.name,
      //           petName: _allPets[i].name,
      //           date: currentVaccination.date);
      //       allUpcomingEvents.add(upcomingEvent);
      //     } else {
      //       UpcomingEvent upcomingEvent = UpcomingEvent(
      //         name: currentVaccination.name,
      //         petName: _allPets[i].name,
      //       );
      //       allUpcomingEventsNoDate.add(upcomingEvent);
      //     }
      //   }
      // }
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
