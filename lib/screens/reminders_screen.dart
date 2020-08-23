import 'package:flutter/material.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/circular_check_box.dart';

class RemindersScreen extends StatefulWidget {
  @override
  _RemindersScreenState createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  double _height;
  double _width;

  bool _value = false;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: StyleConstants.blue,
        title: Container(
          //color: Colors.white,
            height: 75,
            //width: 200,
            child: Image.asset(
              'assets/images/appbarlogoyellow.png',
              fit: BoxFit.cover,
            )),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: StyleConstants.blue,
      ),
      body: Container(
        height: _height,
        width: _width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _width * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: _height * 0.05,),
              Text('Reminders',
              style: StyleConstants.greyThinTitleText,),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: _height * 0.02),
                  child: ListView(
                    children: [
                      reminderItemWidget('Feed the Dog', '8/23/20', '9:00 am'),
                      SizedBox(height: _height * 0.02,),
                      reminderItemWidget('Feed the Cat', '8/27/20', '6:00 pm'),
                      SizedBox(height: _height * 0.02,),
                      reminderItemWidget('Reminder 1', '8/27/20', '6:00 pm'),
                      SizedBox(height: _height * 0.02,),
                      reminderItemWidget('Reminder 2', '8/31/20', '6:00 pm'),
                      SizedBox(height: _height * 0.02,),
                      reminderItemWidget('Reminder 3', '12/3/20', '6:00 pm'),
                      SizedBox(height: _height * 0.02,),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget reminderItemWidget(String reminderName, String date, String time){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: StyleConstants.purpleGrey,
      ),
      width: _width * 0.8,
      height: _height * 0.1,

      child: Row(
        children: [
          CircularCheckBox(
            value: _value,
            onChanged: (bool value) {
              setState(() {
                _value = value;
              });
            },
            activeColor: StyleConstants.yellow,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                reminderName,
                style: StyleConstants.lightBlackThinTitleTextSmall,
              ),
              Text('$date @ $time', style: StyleConstants.greySubText,),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }

}
