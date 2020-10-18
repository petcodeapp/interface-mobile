import 'package:petcode_app/models/PetPerk.dart';
import 'package:petcode_app/providers/notifications_provider.dart';
import 'package:petcode_app/screens/social/pet_perks/pet_perk_description_widget.dart';
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
        _showPetPerks(context, height, width, petPerk);
        if (updateProvider != null && updateProvider) {
          print('update');
          Provider.of<NotificationsProvider>(context, listen: false)
              .clearIndex();
        }
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        //height: height * 0.2,
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: height * 0.14,
                width: height * 0.14,
                decoration: BoxDecoration(
                  color: StyleConstants.yellow,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Center(
                  child: Image.asset('assets/images/petsmartlogo.png'),
                ),
              ),
              Text(
                petPerk.description,
                style: StyleConstants.blackThinDescriptionTextSmall.copyWith(
                    color: StyleConstants.blue, fontWeight: FontWeight.w400),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPetPerks(
      BuildContext context, double height, double width, PetPerk petPerk) {
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
          child: PetPerkDescriptionWidget(
            currentPetPerk: petPerk,
          ),
        );
      },
    );
  }
}
