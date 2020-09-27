import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/models/Reminder.dart';
import 'package:petcode_app/models/User.dart';
import 'package:petcode_app/models/Vaccination.dart';

class DatabaseService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createPet(Pet pet) async {
    await _firestore.collection('pets').doc(pet.pid).set(pet.toJson());
  }

  Future<void> updatePet(Pet pet) async {
    await _firestore.collection('pets').doc(pet.pid).update(pet.toJson());
  }

  Future<void> updateUser(User user) async {
    await _firestore.collection('users').doc(user.uid).update(user.toJson());
  }

  Future<User> createUser(String email, String firstName, String lastName,
      String phoneNumber, String uid) async {
    User newUser = User(
      email: email,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      uid: uid,
      petIds: new List<String>(),
    );
    await _firestore.collection('users').doc(uid).set(newUser.toJson());
    return newUser;
  }

  Future<void> createUserPetList(String pid, String uid) async {
    List<String> petIds = new List<String>();
    petIds.add(pid);
    await _firestore.collection('users').doc(uid).update({'petIds': petIds});
  }

  Future<void> addToUserPetList(
      String pid, String uid, List<String> previousPets) async {
    previousPets.add(pid);
    await _firestore
        .collection('users')
        .doc(uid)
        .update({'petIds': previousPets});
  }

  //TODO: Use something better than index to update?
  Future<void> updateVaccination(
      Vaccination updatedVaccination, int index, Pet pet) async {
    List<Vaccination> updatedList = pet.vaccinations;
    updatedList[index] = updatedVaccination;
    await _firestore.collection('pets').doc(pet.pid).update({
      'vaccinations':
          updatedList.map((vaccination) => vaccination.toJson()).toList()
    });
  }

  Future<void> addVaccination(Vaccination newVaccination, Pet pet) async {
    List<Vaccination> updatedList = pet.vaccinations;
    updatedList.add(newVaccination);
    await _firestore.collection('pets').doc(pet.pid).update({
      'vaccinations':
          updatedList.map((vaccination) => vaccination.toJson()).toList()
    });
  }

  Future<void> deleteVaccination(int index, Pet pet) async {
    List<Vaccination> updatedList = pet.vaccinations;
    updatedList.removeAt(index);
    await _firestore.collection('pets').doc(pet.pid).update({
      'vaccinations':
          updatedList.map((vaccination) => vaccination.toJson()).toList()
    });
  }

  Future<void> addReminder(Reminder reminder, Pet pet) async {
    List<Reminder> updatedList = pet.reminders;
    updatedList.add(reminder);
    await _firestore.collection('pets').doc(pet.pid).update({
      'reminders': updatedList.map((reminder) => reminder.toJson()).toList()
    });
  }

  Future<void> updateReminder(Reminder reminder, Pet pet) async {
    List<Reminder> updatedList = pet.reminders;
    updatedList[reminder.index] = reminder;
    await _firestore.collection('pets').doc(pet.pid).update({
      'reminders': updatedList.map((reminder) => reminder.toJson()).toList()
    });
  }

  Future<void> deleteReminder(int index, Pet pet) async {
    List<Reminder> updatedList = pet.reminders;
    updatedList.removeAt(index);
    await _firestore.collection('pets').doc(pet.pid).update({
      'reminders': updatedList.map((reminder) => reminder.toJson()).toList()
    });
  }
}
