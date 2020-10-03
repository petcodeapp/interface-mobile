import 'package:flutter/material.dart';
import 'package:petcode_app/utils/style_constants.dart';

class PetPerkComingSoonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        height: 125,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: StyleConstants.lightGrey,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'More',
                style: StyleConstants.whiteThinTitleTextSmall,
              ),
              Text(
                'Coming',
                style: StyleConstants.whiteThinTitleTextSmall,
              ),
              Text(
                'Soon!',
                style: StyleConstants.whiteThinTitleTextSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
