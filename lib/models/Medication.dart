import 'package:cloud_firestore/cloud_firestore.dart';

class Medication {
  String name;
  Timestamp date;
  int frequency;

  Medication({this.name, this.date, this.frequency});

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      name: json['name'] as String,
      date: json['date'] as Timestamp,
      frequency: json['frequency'] as int,
    );
  }

  Map<String, dynamic> toJson() => _MedicationToJson(this);

  Map<String, dynamic> _MedicationToJson(Medication instance) =>
      <String, dynamic>{
        'name': instance.name,
        'date': instance.date,
        'frequency': instance.frequency,
      };
}
