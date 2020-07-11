import 'package:cloud_firestore/cloud_firestore.dart';

class Vaccination {
  String name;
  String imageUrl;
  Timestamp date;


  Vaccination({this.name, this.imageUrl, this.date});

  factory Vaccination.fromJson(Map<String, dynamic> json) {
    return Vaccination(
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      date: json['date'] as Timestamp,
    );
  }

  Map<String, dynamic> toJson() => _VaccinationToJson(this);

  Map<String, dynamic> _VaccinationToJson(Vaccination instance) => <String, dynamic> {
    'name': instance.name,
    'imageUrl': instance.imageUrl,
    'date': instance.date,
  };
}