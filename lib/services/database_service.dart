import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/models/User.dart';

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

  Future<User> createUser(String email, String firstName, String lastName,
      String phoneNumber, String uid) async {
    User newUser = User(
      email: email,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      uid: uid,
    );
    await _firestore
        .collection('users')
        .document(uid)
        .setData(newUser.toJson());
    return newUser;
  }
}
