import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petcode_app/models/Medication.dart';
import 'package:petcode_app/models/Owner.dart';
import 'package:petcode_app/models/Scan.dart';
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
  String additionalInfo;
  bool isServiceAnimal;
  bool isLost;
  int age;
  List<Vaccination> vaccinations;
  List<Medication> medications;
  List<Scan> scans;
  Owner contact_1;
  Owner contact_2;

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
      this.additionalInfo,
      this.isServiceAnimal,
      this.isLost,
      this.age,
      this.vaccinations,
      this.medications,
      this.scans,
      this.contact_1,
      this.contact_2,
      this.reference});

  factory Pet.fromSnapshot(DocumentSnapshot snapshot) {
    Pet newPet = Pet.fromJson(snapshot.data);
    newPet.reference = snapshot.reference;
    return newPet;
  }

  factory Pet.fromJson(Map<String, dynamic> json) {
    List<dynamic> vaccinationMaps = json['vaccinations'] as List;
    List<Vaccination> convertedList;
    if (vaccinationMaps != null) {
      convertedList = new List<Vaccination>();
      vaccinationMaps.forEach((vaccination) {
        convertedList.add(Vaccination.fromJson(vaccination));
      });
    }

    List<dynamic> medicationMaps = json['medications'] as List;
    List<Medication> medicationConverted;
    if (convertedList == null) {
      medicationConverted = new List<Medication>();
      medicationMaps.forEach((medication) {
        medicationConverted.add(Medication.fromJson(medication));
      });
    }

    List<dynamic> scanMaps = json['scans'] as List;
    List<Scan> scanConverted;
    if (scanMaps != null) {
      scanMaps.forEach((scan) {
        scanConverted.add(Scan.fromJson(scan));
      });
    }

    Map owner1Map = json['contact_1'] as Map;
    Owner owner1;
    if (owner1Map == null) {
      owner1 = null;
    } else {
      owner1 = Owner.fromJson(owner1Map);
    }

    Map owner2Map = json['contact_2'] as Map;
    Owner owner2;
    if (owner2Map == null) {
      owner2 = null;
    } else {
      owner2 = Owner.fromJson(owner2Map);
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
      additionalInfo: json['additionalInfo'] as String,
      isServiceAnimal: json['isServiceAnimal'] as bool,
      isLost: json['isLost'] as bool,
      age: json['age'] as int,
      vaccinations: convertedList,
      medications: medicationConverted,
      scans: scanConverted,
      contact_1: owner1,
      contact_2: owner2,
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
        'additionalInfo': instance.additionalInfo,
        'isServiceAnimal': instance.isServiceAnimal,
        'isLost': instance.isLost,
        'age': instance.age,
        'vaccinations': _vaccinationMaps(instance.vaccinations),
        'medications': _medicationMaps(instance.medications),
        'scans': _scanMaps(instance.scans),
        'contact_1': _ownerMap(instance.contact_1),
        'contact_2': _ownerMap(instance.contact_2),
      };

  List<Map<String, dynamic>> _vaccinationMaps(
      List<Vaccination> allVaccinations) {
    if (allVaccinations == null) {
      return null;
    } else {
      List<Map<String, dynamic>> convertedMaps = List<Map<String, dynamic>>();
      allVaccinations.forEach((vaccination) {
        convertedMaps.add(vaccination.toJson());
      });
      return convertedMaps;
    }
  }

  List<Map<String, dynamic>> _medicationMaps(List<Medication> allMedications) {
    if (allMedications == null) {
      return null;
    }
    List<Map<String, dynamic>> convertedMaps = new List<Map<String, dynamic>>();
    allMedications.forEach((medication) {
      convertedMaps.add(medication.toJson());
    });
    return convertedMaps;
  }

  Map<String, dynamic> _ownerMap(Owner owner) {
    if (owner == null) {
      return null;
    } else {
      return owner.toJson();
    }
  }

  List<Map<String, dynamic>> _scanMaps(List<Scan> allScans) {
    if (allScans == null) {
      return null;
    }
    List<Map<String, dynamic>> convertedMaps = new List<Map<String, dynamic>>();
    allScans.forEach((scan) {
      convertedMaps.add(scan.toJson());
    });
    return convertedMaps;
  }
}
