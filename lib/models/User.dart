import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  //String firstName;
  //String lastName;
  String fullName;

  String phoneNumber;
  String email;
  List<String> pets;

  DocumentReference reference;

  User(
      {this.uid,
      //this.firstName,
      //this.lastName,
      this.fullName,
      this.phoneNumber,
      this.email,
      this.pets});

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
        phoneNumber: json['phoneNumber'] as String,
        email: json['email'] as String,
        pets: convertPetIds,
      );
    } else {
      return User(
        uid: '',
        //firstName: '',
        //lastName: '',
        fullName: '',
        phoneNumber: '',
        email: '',
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
        'phoneNumber': instance.phoneNumber,
        'email': instance.email,
        'pets': instance.pets,
      };
}
