import 'package:flutter/material.dart';
import 'package:petcode_app/screens/account/basic_account_info_widget.dart';
import 'package:petcode_app/screens/setup_tag/stp_start_screen.dart';
import 'package:petcode_app/screens/account/account_info/account_editing_screen.dart';
import 'package:petcode_app/services/firebase_auth_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;

    return Scaffold(
      backgroundColor: StyleConstants.white,
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            //end: Alignment(0.01, 0.01),
            end: Alignment.bottomLeft,
            stops: [0.01, 0.4, 0.6],
            colors: [
              const Color(0xffABDEED),
              const Color(0xff51BFDA),
              StyleConstants.blue
            ], // whitish to gray
            //tileMode: TileMode.repeated,
          )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: height * 0.15,
                decoration: BoxDecoration(
                  gradient: StyleConstants.bgGradient,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Account',
                            style: StyleConstants.pageTitleText,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.03,
                        ),
                        BasicAccountInfoWidget(),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.05),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text('Update Account Information'),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: StyleConstants.blue,
                                ),
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            AccountInfoEditingScreen())),
                              ),
                              Divider(
                                thickness: 1.5,
                              ),
                              ListTile(
                                title: Text('View App Settings'),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: StyleConstants.blue,
                                ),
                              ),
                              Divider(
                                thickness: 1.5,
                              ),
                              ListTile(
                                title: Text('Change Notification Preferences'),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: StyleConstants.blue,
                                ),
                              ),
                              Divider(
                                thickness: 1.5,
                              ),
                              ListTile(
                                title: Text('Register New Tag'),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: StyleConstants.blue,
                                ),
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StpStartScreen()),
                                ),
                              ),
                              Divider(
                                thickness: 1.5,
                              ),
                              ListTile(
                                title: Text('About App'),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: StyleConstants.blue,
                                ),
                              ),
                              Divider(
                                thickness: 1.5,
                              ),
                              ListTile(
                                title: Text('Logout'),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: StyleConstants.blue,
                                ),
                                onTap: () {
                                  final auth = Provider.of<FirebaseAuthService>(
                                      context,
                                      listen: false);
                                  auth.signOut();
                                },
                              ),
                              Divider(
                                thickness: 1.5,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
