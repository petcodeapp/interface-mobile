import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Firestore _firestore = Firestore.instance;

  Future<String> registerUser(String email, String password) async {
    try {
      FirebaseUser createdUser = (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user;
      _firestore.collection('users').document(createdUser.uid).setData({
        'uid': createdUser.uid,
      });
      return createdUser.uid;
    }
    catch (error) {
      print(error.code);
      return error.code;
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      AuthResult signInResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return signInResult.user.uid;
    }
    catch (error) {
      print(error.code);
      return error.code;
    }
  }

}