import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@immutable
class UserId {
  const UserId({@required this.uid});

  final String uid;
}

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class FirebaseAuthService extends ChangeNotifier {
  FirebaseAuth _firebaseAuth;
  FirebaseUser _firebaseUser;
  Status _status = Status.Uninitialized;
  bool isSigningIn = false;

  FirebaseAuthService.instance() : _firebaseAuth = FirebaseAuth.instance {
    _firebaseAuth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Status get status => _status;

  FirebaseUser get user => _firebaseUser;

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      final authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      print(e);
      notifyListeners();
      return false;
    }
  }

  Future<bool> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      _status = Status.Authenticating;
      print('updated status');
      isSigningIn = true;
      notifyListeners();
      final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      print(e);
      notifyListeners();
      return false;
    }
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      print(firebaseUser);
      _firebaseUser = firebaseUser;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
  }

  finishedSignIn() {
    isSigningIn = false;
    notifyListeners();
  }
}
