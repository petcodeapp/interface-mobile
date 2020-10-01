import 'package:flutter/material.dart';
import 'package:petcode_app/models/PetPerk.dart';
import 'package:petcode_app/utils/style_constants.dart';

class PetPerkDescriptionWidget extends StatelessWidget {
  PetPerkDescriptionWidget({Key key, this.currentPetPerk}) : super(key: key);
  final PetPerk currentPetPerk;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: StyleConstants.width * 0.05),
      child: SingleChildScrollView(
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
            currentPetPerk.discountAmount != null
                ? Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                            currentPetPerk.discountAmount.toString() + '%',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 60.0,
                                color: StyleConstants.yellow)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                            child:
                                Image.asset('assets/images/petsmartlogo.jpg')),
                      ),
                    ],
                  )
                : SizedBox.shrink(),
            Text(
              'Discount at ' + (currentPetPerk.storeName ?? 'this store'),
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w600,
                  color: StyleConstants.blue),
            ),
            SizedBox(
              height: 20.0,
            ),
            currentPetPerk.description != null &&
                    currentPetPerk.description.isNotEmpty
                ? Text(
                    'Details',
                    style: StyleConstants.blackThinTitleTextMedium,
                  )
                : SizedBox.shrink(),
            currentPetPerk.description != null &&
                    currentPetPerk.description.isNotEmpty
                ? Text(currentPetPerk.description)
                : SizedBox.shrink(),
            SizedBox(
              height: 20.0,
            ),
            currentPetPerk.promoCode != null &&
                    currentPetPerk.promoCode.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Promo Code: ',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: StyleConstants.width * 0.06,
                            color: StyleConstants.blue),
                      ),
                      Text(
                        currentPetPerk.promoCode,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: StyleConstants.width * 0.06,
                            color: StyleConstants.yellow),
                      ),
                    ],
                  )
                : SizedBox.shrink(),
            SizedBox(
              height: 20.0,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: StyleConstants.height * 0.08,
                width: StyleConstants.width * 0.5,
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
  }
}
