import 'package:flutter/material.dart';
import 'package:petcode_app/models/User.dart';
import 'package:petcode_app/providers/all_pets_provider.dart';
import 'package:petcode_app/services/user_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class BasicAccountInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;

    UserService userService = Provider.of<UserService>(context);
    User user = userService.currentUser;

    AllPetsProvider allPetsProvider = Provider.of<AllPetsProvider>(context);
    int numScans = 0;
    if (allPetsProvider.allPets != null) {
      for (int i = 0; i < allPetsProvider.allPets.length; i++) {
        if (allPetsProvider.allPets[i].scans != null) {
          numScans += allPetsProvider.allPets[i].scans.length;
        }
      }
    }

    return Container(
      width: width * 0.9,
      //height: height * 0.175,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6.0,
              offset: Offset(0, 3),
            )
          ]),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: height * 0.05, horizontal: width * 0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 40.0,
              backgroundImage: allPetsProvider.allPets.length > 0
                  ? allPetsProvider.allPets[0].petImage
                  : AssetImage('assets/images/puppyphoto.jpg'),
            ),
            SizedBox(
              width: width * 0.06,
            ),
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.firstName + ' ' + user.lastName,
                      style: StyleConstants.blackThinTitleText
                          .copyWith(fontSize: 25.0),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 7.0,
                          height: 7.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: StyleConstants.blue,
                          ),
                        ),
                        SizedBox(
                          width: width * 0.01,
                        ),
                        Text(
                          user.petIds.length.toString() + ' Pets',
                          style: TextStyle(
                              color: StyleConstants.darkPurpleGrey,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0),
                        ),
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Container(
                          width: 7.0,
                          height: 7.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: StyleConstants.yellow,
                          ),
                        ),
                        SizedBox(
                          width: width * 0.01,
                        ),
                        Text(
                          numScans.toString() + ' Scans',
                          style: TextStyle(
                              color: StyleConstants.darkPurpleGrey,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
