import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petcode_app/models/Owner.dart';
import 'package:petcode_app/models/Reminder.dart';
import 'package:petcode_app/models/Scan.dart';
import 'package:petcode_app/models/Vaccination.dart';
import 'package:petcode_app/models/Vet.dart';
import 'package:petcode_app/models/VisibleValue.dart';

class Pet {
  String pid;
  String name;
  String profileUrl;
  String breed;
  String temperament;
  String species;
  String color;
  String additionalInfo;
  VisibleValue<String> specialNeeds;
  VisibleValue<String> allergies;
  bool isServiceAnimal;
  bool isLost;
  //bool isAdopted;
  int age;
  Timestamp birthdate;
  List<Vaccination> vaccinations;
  List<Reminder> reminders;
  List<Scan> scans;
  List<Owner> contacts;
  Vet vet;

  DocumentReference reference;

  Pet(
      {this.pid,
      this.name,
      this.profileUrl,
      this.breed,
      this.temperament,
      this.allergies,
      this.species,
      this.color,
      this.additionalInfo,
      this.specialNeeds,
      this.isServiceAnimal,
      this.isLost,
      //this.isAdopted,
      this.age,
      this.birthdate,
      this.vaccinations,
      this.reminders,
      this.scans,
      this.contacts,
      this.vet,
      this.reference});

  factory Pet.fromSnapshot(DocumentSnapshot snapshot) {
    Pet newPet = Pet.fromJson(snapshot.data());

    newPet.reference = snapshot.reference;
    return newPet;
  }

  factory Pet.fromJson(Map<String, dynamic> json) {
    List<dynamic> vaccinationMaps = json['vaccinations'] as List;
    List<Vaccination> convertedList;
    if (vaccinationMaps != null) {
      convertedList = <Vaccination>[];
      vaccinationMaps.forEach((vaccination) {
        convertedList.add(Vaccination.fromJson(vaccination));
      });
    }

    List<dynamic> reminderMaps = json['reminders'] as List;
    List<Reminder> convertedReminders;
    if (reminderMaps != null) {
      convertedReminders = <Reminder>[];
      reminderMaps.forEach((reminder) {
        convertedReminders.add(Reminder.fromJson(reminder));
      });
      for (int i = 0; i < convertedReminders.length; i++) {
        convertedReminders[i]..index = i;
      }
    }

    List<dynamic> scanMaps = json['scans'] as List;
    List<Scan> scanConverted;
    if (scanMaps != null) {
      scanConverted = <Scan>[];
      scanMaps.forEach((scan) {
        scanConverted.add(Scan.fromJson(scan));
      });
    }

    List<dynamic> ownerMaps = json['contacts'] as List;
    List<Owner> ownerConverted;
    if (ownerMaps != null) {
      ownerConverted = <Owner>[];
      ownerMaps.forEach((owner) {
        ownerConverted.add(Owner.fromJson(owner));
      });
    }

    return Pet(
      pid: json['pid'] as String,
      name: json['name'] as String,
      profileUrl: json['profileUrl'] as String,
      breed: json['breed'] as String,
      temperament: json['temperament'] as String,
      species: json['species'] as String,
      color: json['color'] as String,
      additionalInfo: json['additionalInfo'] as String,
      specialNeeds: VisibleValue.fromJson(json['specialNeeds']),
      allergies: VisibleValue.fromJson(json['allergies']),
      isServiceAnimal: json['isServiceAnimal'] as bool,
      isLost: json['isLost'] as bool,
      //isAdopted: json['isAdopted'] as bool,
      age: json['age'] as int,
      birthdate: json['birthday'] as Timestamp,
      vaccinations: convertedList,
      reminders: convertedReminders,
      scans: scanConverted,
      contacts: ownerConverted,
      vet: Vet.fromJson(json['vet']),
    );
  }

  Map<String, dynamic> toJson() => _PetToJson(this);

  Map<String, dynamic> _PetToJson(Pet instance) => <String, dynamic>{
        'pid': instance.pid,
        'name': instance.name,
        'profileUrl': instance.profileUrl,
        'breed': instance.breed,
        'temperament': instance.temperament,
        'species': instance.species,
        'color': instance.color,
        'additionalInfo': instance.additionalInfo,
        'specialNeeds': instance.specialNeeds != null
            ? instance.specialNeeds.toJson()
            : VisibleValue<String>().toJson(),
        'allergies': instance.allergies != null
            ? instance.allergies.toJson()
            : VisibleValue<String>().toJson(),
        'isServiceAnimal': instance.isServiceAnimal,
        'isLost': instance.isLost,
        //'isAdopted': instance.isAdopted,
        'age': instance.age,
        'birthdate': instance.birthdate,
        'vaccinations': _vaccinationMaps(instance.vaccinations),
        'reminders': _reminderMaps(instance.reminders),
        'scans': _scanMaps(instance.scans),
        'contacts': _ownerMaps(instance.contacts),
        'vet': instance.vet != null ? instance.vet.toJson() : Vet().toJson(),
      };

  List<Map<String, dynamic>> _vaccinationMaps(
      List<Vaccination> allVaccinations) {
    if (allVaccinations == null) {
      return null;
    } else {
      List<Map<String, dynamic>> convertedMaps = <Map<String, dynamic>>[];
      allVaccinations.forEach((vaccination) {
        convertedMaps.add(vaccination.toJson());
      });
      return convertedMaps;
    }
  }

  List<Map<String, dynamic>> _reminderMaps(List<Reminder> reminders) {
    if (reminders == null) {
      return null;
    } else {
      List<Map<String, dynamic>> reminderMaps = <Map<String, dynamic>>[];
      reminders.forEach((reminder) {
        reminderMaps.add(reminder.toJson());
      });
      return reminderMaps;
    }
  }

  List<Map<String, dynamic>> _scanMaps(List<Scan> allScans) {
    if (allScans == null) {
      return null;
    }
    List<Map<String, dynamic>> convertedMaps = <Map<String, dynamic>>[];
    allScans.forEach((scan) {
      convertedMaps.add(scan.toJson());
    });
    return convertedMaps;
  }

  List<Map<String, dynamic>> _ownerMaps(List<Owner> allOwners) {
    if (allOwners == null) {
      return null;
    }
    List<Map<String, dynamic>> convertedMaps = <Map<String, dynamic>>[];
    allOwners.forEach((owner) {
      convertedMaps.add(owner.toJson());
    });
    return convertedMaps;
  }

  @override
  bool operator ==(Object other) {
    return other is Pet && hashCode == other.hashCode;
  }

  @override
  int get hashCode => pid.hashCode;
}
