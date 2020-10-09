import 'package:flutter/material.dart';
import 'package:petcode_app/models/User.dart';
import 'package:petcode_app/providers/all_pets_provider.dart';
import 'package:petcode_app/screens/setup_tag/stp_start_screen.dart';
import 'package:petcode_app/screens/account/account_info/account_editing_screen.dart';
import 'package:petcode_app/services/firebase_auth_service.dart';
import 'package:petcode_app/services/pet_service.dart';
import 'package:petcode_app/services/user_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class AccountScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

    bool starOn = false;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: StyleConstants.blue,
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            gradient: StyleConstants.bgGradient,
          ),
          child: Column(
            children: [
              Container(
                height: height * 0.15,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Account', style: StyleConstants.whiteThinTitleTextSmall.copyWith(fontWeight: FontWeight.w600, fontSize: 22.0),),

                        ],
                      ),
                      SizedBox(height: height * 0.02,),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: width,
                height: height,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))
                ),
                child: Column(
                  children: [
                    SizedBox(height: height * 0.03,),
                    Container(
                      width: width * 0.9,
                      height: height * 0.175,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6.0,
                            offset: Offset(0, 3),
                          )
                        ]
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.1),
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
                            SizedBox(width: width * 0.06,),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.firstName + ' ' + user.lastName,
                                      style: StyleConstants.blackThinTitleText.copyWith(fontSize: 25.0),
                                    ),
                                    SizedBox(height: height * 0.01,),
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
                                        SizedBox(width: width * 0.01,),
                                        Text(
                                          user.petIds.length.toString() + ' Pets',
                                          style: TextStyle(
                                              color: StyleConstants.darkPurpleGrey,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16.0),
                                        ),
                                        SizedBox(width: width * 0.05,),
                                        Container(
                                          width: 7.0,
                                          height: 7.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: StyleConstants.yellow,
                                          ),
                                        ),
                                        SizedBox(width: width * 0.01,),
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
                                SizedBox(width: width * 0.06,)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.05,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text('Update Account Information'),
                            trailing: Icon(Icons.arrow_forward_ios, color: StyleConstants.blue,),
                            onTap: () => Navigator.push(
                              context, MaterialPageRoute(builder: (_) => AccountInfoEditingScreen())
                            ),
                          ),
                          Divider(thickness: 1.5,),
                          ListTile(
                            title: Text('View App Settings'),
                            trailing: Icon(Icons.arrow_forward_ios, color: StyleConstants.blue,),
                          ),
                          Divider(thickness: 1.5,),
                          ListTile(
                            title: Text('Change Notification Preferences'),
                            trailing: Icon(Icons.arrow_forward_ios, color: StyleConstants.blue,),
                          ),
                          Divider(thickness: 1.5,),
                          ListTile(
                            title: Text('Register New Tag'),
                            trailing: Icon(Icons.arrow_forward_ios, color: StyleConstants.blue,),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StpStartScreen()),
                            ),
                          ),
                          Divider(thickness: 1.5,),
                          ListTile(
                            title: Text('About App'),
                            trailing: Icon(Icons.arrow_forward_ios, color: StyleConstants.blue,),
                          ),
                          Divider(thickness: 1.5,),
                          ListTile(
                            title: Text('Logout'),
                            trailing: Icon(Icons.arrow_forward_ios, color: StyleConstants.blue,),
                            onTap: () {
                              final auth = Provider.of<FirebaseAuthService>(context,
                                  listen: false);
                              auth.signOut();
                            },
                          ),
                          Divider(thickness: 1.5,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
