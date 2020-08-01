import 'package:flutter/material.dart';
import 'package:petcode_app/models/User.dart';
import 'package:petcode_app/services/user_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class AccountScreen2 extends StatefulWidget {
  @override
  _AccountScreen2State createState() => _AccountScreen2State();
}

class _AccountScreen2State extends State<AccountScreen2> {
  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    User user = userService.currentUser;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height * 1.1,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              CircleAvatar(
                radius: 100.0,
                backgroundImage: AssetImage('assets/images/stockdog1.jpg'),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text('Lucas Cai', style: StyleConstants.blackTitleTextLarge,),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('3', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25.0),),
                      Text('Pets', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16.0),),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('254', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25.0),),
                      Text('Scans', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16.0),),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: Offset(0, -3),
                      ),
                    ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        SizedBox(height: height * 0.03,),
                        Row(
                          children: [
                            Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: StyleConstants.green.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Icon(
                                Icons.account_circle,
                                color: StyleConstants.green,
                                size: 50.0,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Text(
                              'Update Account Info',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 25.0,
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.02,),
                        Row(
                          children: [
                            Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: StyleConstants.green.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Icon(
                                Icons.settings,
                                color: StyleConstants.green,
                                size: 50.0,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Text(
                              'App Settings',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 25.0,
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.01,),
                        Divider(thickness: 1.0,),
                        SizedBox(height: height * 0.01,),
                        Row(
                          children: [
                            Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: StyleConstants.yellow.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Icon(
                                Icons.turned_in,
                                color: StyleConstants.yellow,
                                size: 50.0,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Text(
                              'Register a Tag',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 25.0,
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.02,),
                        Row(
                          children: [
                            Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: StyleConstants.yellow.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Icon(
                                Icons.place,
                                color: StyleConstants.yellow,
                                size: 50.0,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Text(
                              'Lost Pet Settings',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 25.0,
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.01,),
                        Divider(thickness: 1.0,),
                        SizedBox(height: height * 0.01,),
                        Row(
                          children: [
                            Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: StyleConstants.red.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Icon(
                                Icons.exit_to_app,
                                color: StyleConstants.red,
                                size: 50.0,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Text(
                              'Log Out',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 25.0,
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.02,),
                        Row(
                          children: [
                            Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: StyleConstants.red.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Icon(
                                Icons.account_circle,
                                color: StyleConstants.red,
                                size: 50.0,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Text(
                              'Lost Pet',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 25.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
