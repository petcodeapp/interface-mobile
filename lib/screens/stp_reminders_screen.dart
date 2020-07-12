import 'package:flutter/material.dart';
import 'package:petcode_app/screens/stp_addphoto_screen.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:slimy_card/slimy_card.dart';

class StpRemindersScreen extends StatefulWidget {
  @override
  _StpRemindersScreenState createState() => _StpRemindersScreenState();
}

class _StpRemindersScreenState extends State<StpRemindersScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Widget medWidget1(){
      return Container(
          height: 250.0,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Medication 1', style: StyleConstants.whiteTitleTextSmall,),
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
                            hintText: 'Name',
                            hintStyle:
                            TextStyle(fontSize: 15.0,)),
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
                            hintText: 'Frequency',
                            hintStyle:
                            TextStyle(fontSize: 15.0)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Next Date', style: StyleConstants.whiteTitleTextXS,),
                    Icon(Icons.calendar_today, color: Colors.white,),
                  ],
                )
              ]
          )
      );
    }

    Widget medWidget2(){
      return Container(
        //height: 250.0,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Medication 2', style: StyleConstants.whiteTitleTextSmall,),
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
                            hintText: 'Name',
                            hintStyle:
                            TextStyle(fontSize: 15.0,)),
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
                            hintText: 'Frequency',
                            hintStyle:
                            TextStyle(fontSize: 15.0)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Next Date', style: StyleConstants.whiteTitleTextXS,),
                    Icon(Icons.calendar_today, color: Colors.white,),
                  ],
                )
              ]
          )
      );
    }

    Widget vaccineWidgetTest(){
      return Expanded(
        child: ListView(
          children: [
            SlimyCard(
              color: StyleConstants.yellow,
              width: 300,
              topCardHeight: 250,
              bottomCardHeight: 250,
              borderRadius: 15,
              topCardWidget: medWidget1(),
              bottomCardWidget: medWidget2(),
              slimeEnabled: true,
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
              Text('Step 7: Reminders', style: StyleConstants.whiteTitleText,),
              SizedBox(height: height * 0.01,),

              Expanded(
                child: ListView(
                  children: [
                    SlimyCard(
                      color: StyleConstants.yellow,
                      width: 300,
                      topCardHeight: 300,
                      bottomCardHeight: 300,
                      borderRadius: 15,
                      topCardWidget: medWidget1(),
                      bottomCardWidget: medWidget2(),
                      slimeEnabled: true,
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.02,),
              GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => StpAddPhotoScreen())),
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
