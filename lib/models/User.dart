import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String fullName;
  List<String> pets;

  DocumentReference reference;

  User({this.uid, this.fullName, this.pets});

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    User newUser = User.fromJson(snapshot.data());
    newUser.reference = snapshot.reference;
    return newUser;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    List<String> convertPetIds = <String>[];
    if (json != null) {
      List petIds = json['pets'] as List;
      if (petIds != null) {
        petIds.forEach((petId) {
          convertPetIds.add(petId.toString());
        });
      }

      return User(
        uid: json['uid'] as String,
        //firstName: json['firstName'] as String,
        //lastName: json['lastName'] as String,
        fullName: json['fullName'] as String,
        pets: convertPetIds,
      );
    } else {
      return User(
        uid: '',
        //firstName: '',
        //lastName: '',
        fullName: '',
        pets: <String>[],
      );
    }
  }

  Map<String, dynamic> toJson() => _UserToJson(this);

  Map<String, dynamic> _UserToJson(User instance) => <String, dynamic>{
        'uid': instance.uid,
        //'firstName': instance.firstName,
        //'lastName': instance.lastName,
        'fullName': instance.fullName,
        'pets': instance.pets,
      };
}
