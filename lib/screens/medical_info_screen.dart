import 'package:flutter/material.dart';
import 'package:petcode_app/utils/style_constants.dart';

class MedicalInfoScreen extends StatefulWidget {
  @override
  _MedicalInfoScreenState createState() => _MedicalInfoScreenState();
}

class _MedicalInfoScreenState extends State<MedicalInfoScreen> {

  String _value = 'dog1';


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: StyleConstants.blue,
      appBar: AppBar(
        backgroundColor: StyleConstants.blue,
        centerTitle: true,
        title: new Theme(
          child: new DropdownButtonHideUnderline(
            child: new DropdownButton(
              dropdownColor: StyleConstants.blue,
              value: _value,
              items: [
                new DropdownMenuItem(
                    child: new Text('Reggie',style: TextStyle(color: Colors.white),),
                    value: 'dog1',
                )
              ],
              onChanged: (String value){
                setState(() {
                  _value = value;
                });
              },
            ),
          ),
          data: ThemeData.light(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  'Clinic Info:',
                  style: StyleConstants.whiteTitleText,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Container(
                  height: 150.0,
                  width: width - 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Pet Clinic',
                          style: StyleConstants.blackTitleText,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Phone: ' + '123456789',
                          style:
                          StyleConstants.blackThinDescriptionText,
                        ),
                        Text(
                          'Email: ' + 'l@l.com',
                          style:
                          StyleConstants.blackThinDescriptionText,
                        ),
                        Text(
                          'Address: ' + '123 four five street',
                          style:
                          StyleConstants.blackThinDescriptionText,
                        ),
                      ],
                    ),

                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                GestureDetector(
                  onTap: () => print('Pressed contact'),
                  child: Container(
                    height: 50.0,
                    width: width - 50,
                    decoration: StyleConstants.lightBlueItemBoxDeco,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.settings,
                            color: StyleConstants.yellow,
                            size: 30.0,
                          ),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          Text(
                            'Current Vaccines',
                            style: StyleConstants.whiteTitleText,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                GestureDetector(
                  onTap: () => print('Pressed contact'),
                  child: Container(
                    height: 50.0,
                    width: width - 50,
                    decoration: StyleConstants.lightBlueItemBoxDeco,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.settings,
                            color: StyleConstants.yellow,
                            size: 30.0,
                          ),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          Text(
                            'Documents',
                            style: StyleConstants.whiteTitleText,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                GestureDetector(
                  onTap: () => print('Pressed contact'),
                  child: Container(
                    height: 50.0,
                    width: width - 50,
                    decoration: StyleConstants.lightBlueItemBoxDeco,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.settings,
                            color: StyleConstants.yellow,
                            size: 30.0,
                          ),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          Text(
                            'Share Records',
                            style: StyleConstants.whiteTitleText,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                GestureDetector(
                  onTap: () => print('Pressed contact'),
                  child: Container(
                    height: 50.0,
                    width: width - 50,
                    decoration: StyleConstants.lightBlueItemBoxDeco,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.settings,
                            color: StyleConstants.yellow,
                            size: 30.0,
                          ),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          Text(
                            'Weight Tracker',
                            style: StyleConstants.whiteTitleText,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
