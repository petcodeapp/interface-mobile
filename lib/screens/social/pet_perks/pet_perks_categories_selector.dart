import 'package:flutter/material.dart';
import 'package:petcode_app/utils/style_constants.dart';

class PetPerksCategoriesSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: height * 0.2,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(0, 3),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Center(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            SizedBox(
              width: 30.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset(
                    'assets/images/petperksplaceholderimg.png',
                    fit: BoxFit.cover,
                  ),
                  height: 100.0,
                  width: 100.0,
                ),
                Text(
                  'Toys',
                  style: StyleConstants.blackThinDescriptionText,
                ),
              ],
            ),
            SizedBox(
              width: 30.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset(
                    'assets/images/petperksplaceholderimg.png',
                    fit: BoxFit.cover,
                  ),
                  height: 100.0,
                  width: 100.0,
                ),
                Text(
                  'Food',
                  style: StyleConstants.blackThinDescriptionText,
                ),
              ],
            ),
            SizedBox(
              width: 30.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset(
                    'assets/images/petperksplaceholderimg.png',
                    fit: BoxFit.cover,
                  ),
                  height: 100.0,
                  width: 100.0,
                ),
                Text(
                  'Medication',
                  style: StyleConstants.blackThinDescriptionText,
                ),
              ],
            ),
            SizedBox(
              width: 30.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset(
                    'assets/images/petperksplaceholderimg.png',
                    fit: BoxFit.cover,
                  ),
                  height: 100.0,
                  width: 100.0,
                ),
                Text(
                  'Clothing',
                  style: StyleConstants.blackThinDescriptionText,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
