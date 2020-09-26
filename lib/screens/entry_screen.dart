import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/screens/login_screen.dart';
import 'package:petcode_app/screens/signup_screen.dart';
import 'package:petcode_app/utils/style_constants.dart';
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                    'assets/images/onboarding/topleftcircles.png',
                  width:  width,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  'assets/images/onboarding/bottomrightcircles.png',
                  width:  width,
                ),
              ),
              Positioned(
                top: height * 0.1,
                child: Container(
                  width: width * 0.7,
                  height: height * 0.15,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/onboarding/pawlogohighres.png', fit: BoxFit.cover, width: width * 0.15,),
                      SizedBox(width: width * 0.02,),
                      Image.asset('assets/images/onboarding/textlogo.png', fit: BoxFit.cover),
                    ],
                  ),
                  //child: Image.asset('assets/images/logoyellow.png', fit: BoxFit.cover,),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: height * 0.38,
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: height * 0.34,
                        child: PageView(
                          controller: _controller,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (int page){
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
                                          child: Image.asset('assets/images/onboarding/onboarding3.png', fit: BoxFit.cover),
                                      ),
                                      Text('One Code', style: TextStyle(
                                        color: StyleConstants.blue,
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.w600,
                                      )),
                                      Text('An endless suite of', style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.0,
                                      ),),
                                      Text('features for pet owners', style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.0,
                                      ),),
                                    ],
                                  ),
                                //child: Text('Text Description of the app 1'),
                              ),
                            ),
                            Container(
                              child: Center(
                                //child: Text('Text Description of the app 2'),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: height * 0.25,
                                      child: Image.asset('assets/images/onboarding/onboarding2.png', fit: BoxFit.cover),
                                    ),
                                    Text('Peace of Mind', style: TextStyle(
                                      color: StyleConstants.blue,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w600,
                                    )),
                                    Text('Keep your pet safe and secure', style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                    ),),
                                    Text('with PetCode\'s QR tag system', style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                    ),),
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
                                      child: Image.asset('assets/images/onboarding/onboarding1.png', fit: BoxFit.cover),
                                    ),
                                    Text('Stay Up to Date', style: TextStyle(
                                      color: StyleConstants.blue,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w600,
                                    )),
                                    Text('PetCode\'s storage and reminder system', style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                    ),),
                                    Text('keeps you updated with your pet\'s health', style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                    ),),
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
                                  child: Image.asset('assets/images/onboarding/onboarding4.png', fit: BoxFit.cover),
                                ),
                                Text('Discover Fun', style: TextStyle(
                                  color: StyleConstants.blue,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w600,
                                )),
                                Text('Explore nearby pet parks, events, and pet', style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                ),),
                                Text('perks with PetCode\'s discover system', style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                ),),
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
                bottom: height * 0.22,
                child: GestureDetector(
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
                    decoration: StyleConstants.roundYellowButtonDeco,
                    width: width * 0.55,
                    height: height * 0.07,
                    child: Center(
                      child: Text('Login',
                        style: StyleConstants.whiteThinTitleText,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: height * 0.12,
                child: GestureDetector(
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

                    decoration: StyleConstants.roundWhiteButtonDeco.copyWith(color: StyleConstants.blue),
                    width: width * 0.55,
                    height: height * 0.07,
                    child: Center(
                      child: Text('Activate',
                        style: StyleConstants.whiteThinTitleText,
                      ),
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
