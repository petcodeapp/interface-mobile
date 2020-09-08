import 'package:flutter/material.dart';
import 'package:petcode_app/screens/login_screen.dart';
import 'package:petcode_app/screens/signup_screen.dart';
import 'package:petcode_app/utils/style_constants.dart';

class EntryScreen extends StatefulWidget {
  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {

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
              Container(
                width: width * 0.8,
                height: height * 0.2,
                child: Image.asset('assets/images/logoyellow.png', fit: BoxFit.cover,),
              ),
              Positioned(
                bottom: height * 0.25,
                child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen())),

                  child: Container(
                    decoration: StyleConstants.roundYellowButtonDeco,
                    width: 220.0,
                    height: 60.0,
                    child: Center(
                      child: Text('Login',
                        style: StyleConstants.whiteTitleText,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: height * 0.15,
                child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SignupScreen())),
                  child: Container(
                    decoration: StyleConstants.roundWhiteButtonDeco.copyWith(color: StyleConstants.blue),
                    width: 220.0,
                    height: 60.0,
                    child: Center(
                      child: Text('Activate',
                        style: StyleConstants.whiteTitleText,
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
