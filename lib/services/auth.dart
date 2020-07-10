import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petcode_app/models/User.dart';

class AuthService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Firestore _firestore = Firestore.instance;

  Future<String> registerUser(String email, String password, String firstName,
      String lastName, String phoneNumber) async {
    try {
      FirebaseUser createdUser = (await _firebaseAuth
              .createUserWithEmailAndPassword(email: email, password: password))
          .user;
      User newUser = User(
          uid: createdUser.uid,
          email: email,
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber);
      _firestore.collection('users').document(createdUser.uid).setData(newUser.toJson());
      return createdUser.uid;
    } catch (error) {
      print(error.code);
      return error.code;
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      AuthResult signInResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return signInResult.user.uid;
    } catch (error) {
      print(error.code);
      return error.code;
    }
  }
}
