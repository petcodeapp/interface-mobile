import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

@immutable
class UserId {
  const UserId({@required this.uid});

  final String uid;
}

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class FirebaseAuthService extends ChangeNotifier {
  auth.FirebaseAuth _firebaseAuth;
  auth.User  _firebaseUser;
  GoogleSignIn _googleSignIn;

  Status _status = Status.Uninitialized;

  FirebaseAuthService() {
    _firebaseAuth = auth.FirebaseAuth.instance;
    _firebaseAuth.authStateChanges().listen(_onAuthStateChanged);
    _googleSignIn = new GoogleSignIn(scopes: ['email']);
  }

  Status get status => _status;

  auth.User get user => _firebaseUser;

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

  Future<bool> signInWithGoogle() async {
    try {
      GoogleSignInAccount account = await _googleSignIn.signIn();
      GoogleSignInAuthentication authentication = await account.authentication;
      auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken);

      print(account.displayName);
      auth.UserCredential authResult =
          await _firebaseAuth.signInWithCredential(credential);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> _onAuthStateChanged(auth.User firebaseUser) async {
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
    try {
      await _googleSignIn.signOut();
    } catch (e) {
      print(e);
    }
    _firebaseUser = null;
    _status = Status.Unauthenticated;
    notifyListeners();
  }

}
