import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petcode_app/models/PetPerk.dart';

class PetPerksService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<PetPerk>> startPetPerksStream() {
    return _firestore.collection('petPerks').snapshots().map(
        (QuerySnapshot querySnapshot) =>
            petPerkListFromSnapshot(querySnapshot));
  }

  List<PetPerk> petPerkListFromSnapshot(QuerySnapshot snapshot) {
    List<PetPerk> petPerks = <PetPerk>[];
    for (int i = 0; i < snapshot.docs.length; i++) {
      petPerks.add(PetPerk.fromSnapshot(snapshot.docs[i]));
    }
    return petPerks;
  }
}
