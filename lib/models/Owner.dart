import 'package:petcode_app/models/VisibleValue.dart';

class Owner {
  VisibleValue<String> name;
  VisibleValue<String> phoneNumber;
  VisibleValue<String> email;
  VisibleValue<String> address;

  Owner({this.name, this.phoneNumber, this.email, this.address});

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      name: VisibleValue<String>.fromJson(json['name']),
      phoneNumber: VisibleValue<String>.fromJson(json['phoneNumber']),
      email: VisibleValue<String>.fromJson(json['email']),
      address: VisibleValue<String>.fromJson(json['address']),
    );
  }

  Map<String, dynamic> toJson() => _OwnerToJson(this);

  Map<String, dynamic> _OwnerToJson(Owner instance) => <String, dynamic>{
        'name': instance.name.toJson(),
        'phoneNumber': instance.phoneNumber.toJson(),
        'email': instance.email.toJson(),
        'address': instance.address.toJson(),
      };
}
