import 'package:cloud_firestore/cloud_firestore.dart';

class Vaccination {
  String name;
  String imageUrl;
  Timestamp date;
  Timestamp expirationDate;


  Vaccination({this.name, this.imageUrl, this.date, this.expirationDate});

  factory Vaccination.fromJson(Map<String, dynamic> json) {
    return Vaccination(
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      date: json['date'] as Timestamp,
      expirationDate: json['expirationDate'] as Timestamp,
    );
  }

  Map<String, dynamic> toJson() => _VaccinationToJson(this);

  Map<String, dynamic> _VaccinationToJson(Vaccination instance) => <String, dynamic> {
    'name': instance.name,
    'imageUrl': instance.imageUrl,
    'date': instance.date,
  };
}