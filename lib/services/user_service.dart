import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:petcode_app/models/User.dart';

class UserService extends ChangeNotifier {
  Firestore _firestore = Firestore.instance;

  String _uid;
  User _currentUser;

  User get currentUser => _currentUser;

  UserService(String uid) {
    _uid = uid;
    startUserStream();
  }

  void startUserStream() {
    _firestore
        .collection('users')
        .document(_uid)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (snapshot.data != null) {
        _currentUser = User.fromSnapshot(snapshot);
        notifyListeners();
      }
    });
  }
}
