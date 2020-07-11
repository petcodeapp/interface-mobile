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
      return 'complete';
    } catch (error) {
      print(error.code);
      return error.code;
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      AuthResult signInResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return 'complete';
    } catch (error) {
      print(error.code);
      return error.code;
    }
  }

  String passwordValidator(String password) {
    if (password.length < 7) {
      return 'Please enter a password with a length of at least 8';
    }
    else {
      return null;
    }
  }

  String confirmPasswordValidator(String password, String confirmPassword) {
    if (password != confirmPassword) {
      return 'Passwords don\'t match';
    }
    else {
      return null;
    }
  }

  String phoneNumberValidator(String phoneNumber) {
    if (int.tryParse(phoneNumber) == null) {
      return 'Please enter a valid phone number';
    }
    else {
      return null;
    }
  }
}
