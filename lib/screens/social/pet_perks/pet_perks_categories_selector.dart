import 'package:flutter/material.dart';
import 'package:petcode_app/providers/pet_perks_provider.dart';
import 'package:petcode_app/utils/hero_icons.dart';
import 'package:petcode_app/utils/hero_icons2.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class PetPerksCategoriesSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double height = StyleConstants.height;
    double width = StyleConstants.width;

    PetPerksProvider petPerksProvider = Provider.of<PetPerksProvider>(context);

    return Container(
      height: height * 0.13,
      width: width,
      child: SizedBox(
        height: height * 0.05,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            SizedBox(
              width: width * 0.08,
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.01),
              child: GestureDetector(
                onTap: () {
                  petPerksProvider.setFilter('toys');
                },
                child: Container(
                  width: width * 0.4,
                  height: height * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.16),
                        blurRadius: 10.0,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: StyleConstants.yellow,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          height: height * 0.09,
                          width: height * 0.09,
                          child: Center(
                            child: Icon(
                                HeroIcons2.bone_2,
                              color: Colors.white,
                              size: 35.0,
                            ),
                          ),
                        ),
                        Text(
                          'Toys',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width * 0.05,
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.01),
              child: GestureDetector(
                onTap: () {
                  petPerksProvider.setFilter('food');
                },
                child: Container(
                  width: width * 0.4,
                  height: height * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.16),
                        blurRadius: 10.0,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: StyleConstants.yellow,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          height: height * 0.09,
                          width: height * 0.09,
                          child: Center(
                            child: Icon(
                              HeroIcons2.dog_food_1,
                              color: Colors.white,
                              size: 35.0,
                            ),
                          ),
                        ),
                        Text(
                          'Food',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width * 0.05,
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.01),
              child: GestureDetector(
                onTap: () {
                  petPerksProvider.setFilter('medicine');
                },
                child: Container(
                  width: width * 0.5,
                  height: height * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.16),
                        blurRadius: 10.0,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.035),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: StyleConstants.yellow,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          height: height * 0.09,
                          width: height * 0.09,
                          child: Center(
                            child: Icon(
                              HeroIcons2.pills_1,
                              color: Colors.white,
                              size: 35.0,
                            ),
                          ),
                        ),
                        Text(
                          'Medicine',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
