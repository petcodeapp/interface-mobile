import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/models/User.dart';
import 'package:petcode_app/models/Vaccination.dart';

class DatabaseService {
  Firestore _firestore = Firestore.instance;

  Future<void> createPet(Pet pet) async {
    await _firestore.collection('pets').document(pet.pid).setData(pet.toJson());
  }

  Future<void> updatePet(Pet pet) async {
    await _firestore
        .collection('pets')
        .document(pet.pid)
        .updateData(pet.toJson());
  }

  Future<void> updateUser(User user) async {
    await _firestore
        .collection('users')
        .document(user.uid)
        .updateData(user.toJson());
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
    await _firestore
        .collection('users')
        .document(uid)
        .setData(newUser.toJson());
    return newUser;
  }

  Future<void> createUserPetList(String pid, String uid) async {
    List<String> petIds = new List<String>();
    petIds.add(pid);
    await _firestore
        .collection('users')
        .document(uid)
        .updateData({'petIds': petIds});
  }

  Future<void> addToUserPetList(
      String pid, String uid, List<String> previousPets) async {
    previousPets.add(pid);
    await _firestore
        .collection('users')
        .document(uid)
        .updateData({'petIds': previousPets});
  }

  Future<void> updateVaccination(
      Vaccination updatedVaccination, int index, Pet pet) async {
    List<Vaccination> updatedList = pet.vaccinations;
    updatedList[index] = updatedVaccination;
    await _firestore.collection('pets').document(pet.pid).updateData({
      'vaccinations':
          updatedList.map((vaccination) => vaccination.toJson()).toList()
    });
  }
}
