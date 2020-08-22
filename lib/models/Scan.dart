import 'package:cloud_firestore/cloud_firestore.dart';

class Scan {
  //These 3 variables are used on the scan screen only
  String petName;
  String address;
  int petIndex;

  GeoPoint location;
  Timestamp date;

  Scan({this.petName, this.address, this.petIndex, this.location, this.date});

  factory Scan.fromJson(Map<String, dynamic> json) {
    return Scan(
      location: json['location'] as GeoPoint,
      date: json['date'] as Timestamp,
    );
  }

  Map<String, dynamic> toJson() => _ScanToJson(this);

  Map<String, dynamic> _ScanToJson(Scan instance) => <String, dynamic>{
        'location': instance.location,
        'date': instance.date,
      };
}
