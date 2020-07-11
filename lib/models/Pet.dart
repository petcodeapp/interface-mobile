import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petcode_app/models/Vaccination.dart';

class Pet {
  String pid;
  String name;
  String profileUrl;
  String breed;
  String temperament;
  String allergies;
  String specialNeeds;
  String vetName;
  String vetPhoneNumber;
  bool isServiceAnimal;
  int age;
  List<Vaccination> vaccinations;
  List medications;
  Map contact_1;
  Map contact_2;

  DocumentReference reference;

  Pet(
      {this.pid,
      this.name,
      this.profileUrl,
      this.breed,
      this.temperament,
      this.allergies,
      this.specialNeeds,
      this.vetName,
      this.vetPhoneNumber,
      this.isServiceAnimal,
      this.age,
      this.vaccinations,
      this.medications,
      this.contact_1,
      this.contact_2,
      this.reference});

  factory Pet.fromSnapshot(DocumentSnapshot snapshot) {
    Pet newPet = Pet.fromJson(snapshot.data);
    newPet.reference = snapshot.reference;
    return newPet;
  }

  factory Pet.fromJson(Map<String, dynamic> json) {
    List vaccinationMaps = json['vaccinations'] as List;
    List<Vaccination> convertedList;
    if (vaccinationMaps == null) {
      return null;
    } else {
      convertedList = new List<Vaccination>();
      vaccinationMaps.forEach((vaccination) {
        convertedList.add(Vaccination.fromJson(vaccination));
      });
    }
    return Pet(
      pid: json['pid'] as String,
      name: json['name'] as String,
      profileUrl: json['profileUrl'] as String,
      breed: json['breed'] as String,
      temperament: json['temperament'] as String,
      allergies: json['allergies'] as String,
      specialNeeds: json['specialNeeds'] as String,
      vetName: json['vetName'] as String,
      vetPhoneNumber: json['vetPhoneNumber'] as String,
      isServiceAnimal: json['isServiceAnimal'] as bool,
      age: json['age'] as int,
      vaccinations: convertedList,
      medications: json['medications'] as List,
      contact_1: json['contact_1'] as Map,
      contact_2: json['contact_2'] as Map,
    );
  }

  Map<String, dynamic> toJson() => _PetToJson(this);

  Map<String, dynamic> _PetToJson(Pet instance) => <String, dynamic>{
        'pid': instance.pid,
        'name': instance.name,
        'profileUrl': instance.profileUrl,
        'breed': instance.breed,
        'temperament': instance.temperament,
        'allergies': instance.allergies,
        'specialNeeds': instance.specialNeeds,
        'vetName': instance.vetName,
        'vetPhoneNumber': instance.vetPhoneNumber,
        'isServiceAnimal': instance.isServiceAnimal,
        'age': instance.age,
        'vaccinations': _vaccinationMaps(instance.vaccinations),
        'medications': instance.medications,
        'contact_1': instance.contact_1,
        'contact_2': instance.contact_2,
      };

  List<Map<String, dynamic>> _vaccinationMaps(List<Vaccination> allVaccinations) {
    if (allVaccinations == null) {
      return null;
    }
    else {
      List<Map<String, dynamic>> convertedMaps = List<Map<String, dynamic>>();
      allVaccinations.forEach((vaccination) {
        convertedMaps.add(vaccination.toJson());
      });
      return convertedMaps;
    }
  }
}
