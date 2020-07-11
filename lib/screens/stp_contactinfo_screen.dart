import 'package:flutter/material.dart';
import 'package:petcode_app/screens/stp_connecttag_screen.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:slimy_card/slimy_card.dart';

class StpContactScreen extends StatefulWidget {
  @override
  _StpContactScreenState createState() => _StpContactScreenState();
}

class _StpContactScreenState extends State<StpContactScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Widget contactWidget1(){
      return Container(
        height: 400.0,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Contact 1', style: StyleConstants.whiteTitleTextSmall,),
            SizedBox(height: height * 0.02,),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      offset: Offset(0, 2),
                    ),
                  ]),
              height: 50.0,
              width: 250.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0),
                child: Center(
                  child: TextFormField(
                    //controller: _emailInputController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Full Name',
                        hintStyle:
                        TextStyle(fontSize: 15.0)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              height: 50.0,
              width: 250.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0),
                child: Center(
                  child: TextFormField(
                    //controller: _passwordInputController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Phone Number',
                        hintStyle:
                        TextStyle(fontSize: 15.0)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              height: 50.0,
              width: 250.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0),
                child: Center(
                  child: TextFormField(
                    //controller: _passwordInputController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                        hintStyle:
                        TextStyle(fontSize: 15.0)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              height: 50.0,
              width: 250.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0),
                child: Center(
                  child: TextFormField(
                    //controller: _passwordInputController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Address',
                        hintStyle:
                        TextStyle(fontSize: 15.0)),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    Widget contactWidget2(){
      return Container(
        height: 400.0,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Contact 2', style: StyleConstants.whiteTitleTextSmall,),
            SizedBox(height: height * 0.02,),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      offset: Offset(0, 2),
                    ),
                  ]),
              height: 50.0,
              width: 250.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0),
                child: Center(
                  child: TextFormField(
                    //controller: _emailInputController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Full Name',
                        hintStyle:
                        TextStyle(fontSize: 15.0)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              height: 50.0,
              width: 250.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0),
                child: Center(
                  child: TextFormField(
                    //controller: _passwordInputController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Phone Number',
                        hintStyle:
                        TextStyle(fontSize: 15.0)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              height: 50.0,
              width: 250.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0),
                child: Center(
                  child: TextFormField(
                    //controller: _passwordInputController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                        hintStyle:
                        TextStyle(fontSize: 15.0)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              height: 50.0,
              width: 250.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0),
                child: Center(
                  child: TextFormField(
                    //controller: _passwordInputController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Address',
                        hintStyle:
                        TextStyle(fontSize: 15.0)),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: StyleConstants.blue,
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.05,),
              Container(
                height: 70.0,
                width: 200.0,
                child: Image.asset('assets/images/logoyellow.png', fit: BoxFit.cover,),
              ),
              SizedBox(height: height * 0.05,),
              Text('Step 2: Contact Information', style: StyleConstants.whiteTitleText,),
              SizedBox(height: height * 0.01,),

              Expanded(
                child: ListView(
                  children: [
                    SlimyCard(
                      color: StyleConstants.yellow,
                      width: 300,
                      topCardHeight: 350,
                      bottomCardHeight: 350,
                      borderRadius: 15,
                      topCardWidget: contactWidget1(),
                      bottomCardWidget: contactWidget2(),
                      slimeEnabled: true,
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.02,),
              GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => StpConnectTagScreen())),
                child: Container(
                  height: 55.0,
                  width: 250.0,
                  decoration: StyleConstants.roundYellowButtonDeco,
                  child: Center(
                    child: Text(
                      'Next Step',
                      style: StyleConstants.whiteButtonText,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
