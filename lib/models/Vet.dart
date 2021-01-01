import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petcode_app/models/VisibleValue.dart';

class Vet {
  VisibleValue<String> phoneNumber;
  VisibleValue<String> name;



  Vet({this.phoneNumber, this.name});

  factory Vet.fromJson(Map<String, dynamic> json) {
    return Vet(
      name: VisibleValue<String>.fromJson(json['name']),
      phoneNumber: VisibleValue<String>.fromJson(json['phoneNumber']),
    );
  }

  Map<String, dynamic> toJson() => _VetToJson(this);

  Map<String, dynamic> _VetToJson(Vet instance) => <String, dynamic> {
    'name': instance.name.toJson(),
    'phoneNumber': instance.phoneNumber.toJson(),
  };
}