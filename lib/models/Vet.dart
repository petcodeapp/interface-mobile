import 'package:petcode_app/models/VisibleValue.dart';

class Vet {
  VisibleValue<String> phoneNumber;
  VisibleValue<String> name;

  Vet({this.phoneNumber, this.name});

  factory Vet.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      return Vet(
        name: VisibleValue<String>.fromJson(json['name']),
        phoneNumber: VisibleValue<String>.fromJson(json['phoneNumber']),
      );
    } else {
      return null;
    }
  }

  Map<String, dynamic> toJson() => _VetToJson(this);

  Map<String, dynamic> _VetToJson(Vet instance) => <String, dynamic>{
        'name': instance.name != null ? instance.name.toJson() : VisibleValue<String>().toJson(),
        'phoneNumber':
            instance.phoneNumber != null ? instance.phoneNumber.toJson() : VisibleValue<String>().toJson(),
      };
}
