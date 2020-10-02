import 'package:petcode_app/models/PetPerk.dart';
import 'package:petcode_app/providers/notifications_provider.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PetPerkWidget extends StatelessWidget {
  PetPerkWidget({Key key, this.updateProvider, this.petPerk}) : super(key: key);

  final bool updateProvider;
  final PetPerk petPerk;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        _showPetPerks(context, height, width);
        if (updateProvider != null && updateProvider) {
          print('update');
          Provider.of<NotificationsProvider>(context, listen: false)
              .clearIndex();
        }
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        height: height * 0.2,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 6.0,
                offset: Offset(0, 3),
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            petPerk.discountAmount.toString() + '%',
                            style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.w600,
                                color: StyleConstants.yellow),
                          ),
                          Text(
                            ' Discount',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400,
                                color: StyleConstants.blue),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        petPerk.storeName,
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w600,
                            color: StyleConstants.blue),
                      )
                    ],
                  ),
                  Spacer(),
                  Container(
                      height: 100,
                      width: 150,
                      child: Image.asset(
                        'assets/images/petsmartlogo.jpg',
                      )),
                ],
              ),
              Text(
                petPerk.description,
                style: StyleConstants.blackThinDescriptionTextSmall.copyWith(
                    color: StyleConstants.blue, fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showPetPerks(BuildContext context, double height, double width) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: height * 0.6,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Pet Perks',
                      style: StyleConstants.blackThinTitleText,
                    )),
                Row(
                  children: [
                    Text('50%',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 60.0,
                            color: StyleConstants.yellow)),
                    Container(
                        height: 100.0,
                        width: 200.0,
                        child: Image.asset('assets/images/petsmartlogo.jpg')),
                  ],
                ),
                Text(
                  'Discount at PetSmart',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w600,
                      color: StyleConstants.blue),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Details',
                  style: StyleConstants.blackThinTitleTextMedium,
                ),
                Text(
                    'Back to School Sale! Get an extra 50% off regular & sale Belk exclusive & select national brands purchases (40% off select national brands; 20% off select designer brands)'),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Text(
                      'Promo Code: ',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 25.0,
                          color: StyleConstants.blue),
                    ),
                    Text(
                      'PETCODE123',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                          color: StyleConstants.yellow),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: height * 0.08,
                    width: width * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: StyleConstants.blue,
                    ),
                    child: Center(
                      child: Text(
                        'Shop Now',
                        style: StyleConstants.whiteThinTitleTextSmall,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
