import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petcode_app/models/User.dart';

class UserService {
  Firestore _firestore = Firestore.instance;

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
