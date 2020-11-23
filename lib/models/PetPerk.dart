import 'package:cloud_firestore/cloud_firestore.dart';

class PetPerk {
  String storeName;
  String description;
  String promoCode;
  String storePhotoUrl;
  List<String> categories;
  int discountAmount;

  DocumentReference reference;

  PetPerk(
      {this.storeName,
      this.description,
      this.promoCode,
      this.storePhotoUrl,
      this.categories,
      this.discountAmount,
      this.reference});

  factory PetPerk.fromSnapshot(DocumentSnapshot snapshot) {
    PetPerk newPetPerk = PetPerk.fromJson(snapshot.data());
    newPetPerk.reference = snapshot.reference;
    return newPetPerk;
  }

  factory PetPerk.fromJson(Map<String, dynamic> json) {
    return PetPerk(
        storeName: json['storeName'] as String,
        description: json['description'] as String,
        promoCode: json['promoCode'] as String,
        storePhotoUrl: json['storePhotoUrl'] as String,
        categories: List<String>.from(json['categories']),
        discountAmount: json['discountAmount'] as int);
  }

  Map<String, dynamic> toJson() => _PetPerkToJson(this);

  _PetPerkToJson(PetPerk instance) => <String, dynamic>{
        'storeName': instance.storeName,
        'description': instance.description,
        'promoCode': instance.promoCode,
        'storePhotoUrl': instance.storePhotoUrl,
        'categories': instance.categories,
        'discountAmount': instance.discountAmount,
      };
}
