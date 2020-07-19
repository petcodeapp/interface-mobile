import 'package:cloud_firestore/cloud_firestore.dart';

class CheckRegistrationService {
  Firestore _firestore = Firestore.instance;

  Future<bool> hasAccount(String uid) async {
    DocumentSnapshot userSnapshot =
        await _firestore.collection('users').document(uid).get();

    if (userSnapshot.data == null) {
      print('hasAccount: false ' + userSnapshot.data.toString());
      return false;
    } else {
      print('hasAccount: true ' + userSnapshot.data.toString());
      return true;
    }
  }
}