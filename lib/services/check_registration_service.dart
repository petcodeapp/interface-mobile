import 'package:cloud_firestore/cloud_firestore.dart';

class CheckRegistrationService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> hasAccount(String uid) async {
    DocumentSnapshot userSnapshot =
        await _firestore.collection('users').doc(uid).get();

    if (userSnapshot.data == null) {
      print('hasAccount: false ' + userSnapshot.data.toString());
      return false;
    } else {
      print('hasAccount: true ' + userSnapshot.data.toString());
      return true;
    }
  }
}