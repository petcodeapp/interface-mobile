import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/models/Vaccination.dart';
import 'package:share/share.dart';

class ShareRecordsScreen extends StatelessWidget {
  ShareRecordsScreen({Key key, this.petVaccinations}) : super(key: key);
  final List<Vaccination> petVaccinations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: petVaccinations.length,
        itemBuilder: (BuildContext context, int index) {
          print(petVaccinations[index].imageUrl);
          if (petVaccinations[index].imageUrl != null) {
            return CachedNetworkImage(
                imageUrl: petVaccinations[index].imageUrl);
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
