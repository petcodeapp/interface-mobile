import 'package:flutter/material.dart';
import 'package:petcode_app/screens/login_screen.dart';
import 'package:petcode_app/screens/signup_screen.dart';
import 'package:petcode_app/utils/style_constants.dart';

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
                      Image.asset('assets/images/onboarding/pawlogo.png', fit: BoxFit.cover),
                      SizedBox(width: width * 0.05,),
                      Image.asset('assets/images/onboarding/textlogo.png', fit: BoxFit.cover),
                    ],
                  ),
                  //child: Image.asset('assets/images/logoyellow.png', fit: BoxFit.cover,),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: height * 0.3,
                  child: PageView(
                    controller: _controller,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        child: Center(
                            child: Image.asset('assets/images/onboarding/onboarding1.png')
                          //child: Text('Text Description of the app 1'),
                        ),
                      ),
                      Container(
                        child: Center(
                          //child: Text('Text Description of the app 2'),
                            child: Image.asset('assets/images/onboarding/onboarding2.png')
                        ),
                      ),
                      Container(
                        child: Center(
                          //child: Text('Text Description of the app 3'),
                            child: Image.asset('assets/images/onboarding/onboarding3.png')
                        ),
                      ),
                      Container(
                        child: Center(
                          //child: Text('Text Description of the app 3'),
                            child: Image.asset('assets/images/onboarding/onboarding4.png')
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: height * 0.22,
                child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen())),

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
