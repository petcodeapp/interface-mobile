import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@immutable
class UserId {
  const UserId({@required this.uid});

  final String uid;
}

class FirebaseAuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  UserId _userIdFromFirebaseUser(FirebaseUser user) {
    if (user == null) {
      return null;
    } else {
      return UserId(uid: user.uid);
    }
  }

  Stream<UserId> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged
        .map((FirebaseUser user) => _userIdFromFirebaseUser(user));
  }

  Future<UserId> signInWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userIdFromFirebaseUser(authResult.user);
  }

  Future<UserId> createUserWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userIdFromFirebaseUser(authResult.user);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
