import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/screens/auth/login_screen.dart';
import 'package:petcode_app/screens/auth/signup_screen.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/painters/bottom_right_circles_painter.dart';
import 'package:petcode_app/widgets/painters/top_left_circles_painter.dart';
import 'package:provider/provider.dart';

class EntryScreen extends StatefulWidget {
  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  static PageController _controller;

  @override
  void initState() {
    _controller = PageController(
      initialPage: 0,
    );
    super.initState();
  }

  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              painter: TopLeftCirclesPainter(),
              child: Container(),
            ),
            CustomPaint(
              painter: BottomRightCirclesPainter(),
              child: Container(),
            ),
            Positioned(
              top: height * 0.1,
              child: Container(
                width: width * 0.7,
                height: height * 0.15,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/onboarding/pawlogohighres.png',
                      fit: BoxFit.cover,
                      width: width * 0.15,
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Image.asset('assets/images/onboarding/textlogo.png',
                        fit: BoxFit.cover),
                  ],
                ),
                //child: Image.asset('assets/images/logoyellow.png', fit: BoxFit.cover,),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: height * 0.4,
                      child: PageView(
                        controller: _controller,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (int page) {
                          setState(() {
                            pageIndex = page;
                          });
                        },
                        children: <Widget>[
                          Container(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: height * 0.25,
                                    child: Image.asset(
                                        'assets/images/onboarding/onboarding3.png',
                                        fit: BoxFit.cover),
                                  ),
                                  Text('One Code',
                                      style: TextStyle(
                                        color: StyleConstants.blue,
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  Text(
                                    'An endless suite of',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Text(
                                    'features for pet owners',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                              //child: Text('Text Description of the app 1'),
                            ),
                          ),
                          Container(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: height * 0.25,
                                    child: Image.asset(
                                        'assets/images/onboarding/onboarding2.png',
                                        fit: BoxFit.cover),
                                  ),
                                  Text('Peace of Mind',
                                      style: TextStyle(
                                        color: StyleConstants.blue,
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  Text(
                                    'Keep your pet safe and secure',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Text(
                                    'with PetCode\'s QR tag system',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Center(
                              //child: Text('Text Description of the app 3'),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: height * 0.25,
                                    child: Image.asset(
                                        'assets/images/onboarding/onboarding1.png',
                                        fit: BoxFit.cover),
                                  ),
                                  Text('Stay Up to Date',
                                      style: TextStyle(
                                        color: StyleConstants.blue,
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  Text(
                                    'PetCode\'s storage and reminder system',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Text(
                                    'keeps you updated with your pet\'s health',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: height * 0.25,
                                  child: Image.asset(
                                      'assets/images/onboarding/onboarding4.png',
                                      fit: BoxFit.cover),
                                ),
                                Text('Discover Fun',
                                    style: TextStyle(
                                      color: StyleConstants.blue,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w600,
                                    )),
                                Text(
                                  'Explore nearby pet parks, events, and pet',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                  ),
                                ),
                                Text(
                                  'perks with PetCode\'s discover system',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    DotsIndicator(
                      dotsCount: 4,
                      decorator: DotsDecorator(
                        size: Size.square(7.0),
                        activeSize: Size.square(9.0),
                      ),
                      position: 0.0 + pageIndex,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: height * 0.1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    //onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen())),
                    onTap: () => Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation){
                      return ListenableProvider(
                        create: (context) => animation,
                        child: LoginScreen(),
                      );
                    },
                      transitionDuration: Duration(seconds:1),
                    )),
                    child: Container(
                      decoration: BoxDecoration(
                        color: StyleConstants.yellow,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset(0, 3),
                            blurRadius: 6.0,
                          ),
                        ]
                      ),
                      width: width * 0.55,
                      height: height * 0.055,
                      child: Center(
                        child: Text('Login',
                          style: StyleConstants.whiteThinTitleText.copyWith(fontSize: 20.0, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.04,),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SignupScreen())),
                    /*
                onTap: () => Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation){
                  return ListenableProvider(
                    create: (context) => animation,
                    child: SignupScreen2(),
                  );
                },
                  transitionDuration: Duration(seconds:1),
                )),*/
                    child: Container(

                      decoration: BoxDecoration(
                          color: StyleConstants.blue,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: Offset(0, 3),
                              blurRadius: 8.0,
                            ),
                          ]
                      ),
                      width: width * 0.55,
                      height: height * 0.055,
                      child: Center(
                        child: Text('Activate',
                          style: StyleConstants.whiteThinTitleText.copyWith(fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
