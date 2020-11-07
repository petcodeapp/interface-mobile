import 'package:flutter/material.dart';
import 'package:petcode_app/utils/style_constants.dart';

class ComingSoonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;

    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        width: width * 0.9,
        height: height * 0.2,
        child: Stack(
          children: [
            Align(alignment: Alignment.center,
              child: Container(
                width: width * 1,
                height: height * 0.5,
                color: StyleConstants.lightGrey,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'More Coming Soon!',
                style: StyleConstants.whiteThinTitleTextSmall,
              ),
            )
          ],
        ),
      ),
    );
  }
}
