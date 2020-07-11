class Owner {
  String name;
  String phoneNumber;
  String email;
  String address;

  Owner({this.name, this.phoneNumber, this.email, this.address});

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
    );
  }

  Map<String, dynamic> toJson() => _OwnerToJson(this);

  Map<String, dynamic> _OwnerToJson(Owner instance) => <String, dynamic>{
        'name': instance.name,
        'phoneNumber': instance.phoneNumber,
        'email': instance.email,
        'address': instance.address,
      };
}
