import 'package:flutter/material.dart';
import 'package:petcode_app/screens/stp_connecttag_screen.dart';
import 'package:petcode_app/utils/style_constants.dart';

class StpPetInfoScreen extends StatefulWidget {
  @override
  _StpPetInfoScreenState createState() => _StpPetInfoScreenState();
}

bool checkedValue = false;

class _StpPetInfoScreenState extends State<StpPetInfoScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;



    return Scaffold(
      backgroundColor: StyleConstants.blue,
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              Container(
                height: 70.0,
                width: 200.0,
                child: Image.asset(
                  'assets/images/logoyellow.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Text(
                'Step 4: Pet Information',
                style: StyleConstants.whiteTitleText,
              ),
              SizedBox(
                height: height * 0.06,
              ),

          Container(
            //height: 300.0,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                            hintText: 'Pet Name',
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
                            hintText: 'Breed',
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
                            hintText: 'Age',
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
                            hintText: 'Temperament',
                            hintStyle:
                            TextStyle(fontSize: 15.0)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02,),
                Text('Service Animal?', style: StyleConstants.whiteTitleTextSmall,),
                Checkbox(
                  //title: Text("title text"),
                  checkColor: Colors.white,
                  activeColor: StyleConstants.yellow,
                  value: checkedValue,
                  onChanged: (newValue) {
                    setState(() {
                      checkedValue = newValue;
                    });
                  },
                  //controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                )
              ],
            ),
          ),


              SizedBox(
                height: height * 0.05,
              ),
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
