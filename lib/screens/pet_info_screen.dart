import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';

class PetInfoScreen extends StatelessWidget {
  PetInfoScreen({Key key, this.currentPet}) : super(key: key);
  final Pet currentPet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(currentPet.name),
          Text(currentPet.breed),
          Text(currentPet.age.toString()),
        ],
      ),
    );
  }
}
