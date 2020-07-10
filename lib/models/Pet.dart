import 'package:cloud_firestore/cloud_firestore.dart';

class Pet {
  String pid;
  String name;

  DocumentReference reference;

  Pet({this.pid, this.name});

  factory Pet.fromSnapshot(DocumentSnapshot snapshot) {
    Pet newPet = Pet.fromJson(snapshot.data);
    newPet.reference = snapshot.reference;
    return newPet;
  }

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      pid: json['pid'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() => _PetToJson(this);

  Map<String, dynamic> _PetToJson(Pet instance) => <String, dynamic>{
        'pid': instance.pid,
        'name': instance.name,
      };
}
