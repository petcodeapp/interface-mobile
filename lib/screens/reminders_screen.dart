import 'package:flutter/material.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/change_pet_app_bar.dart';

class RemindersScreen extends StatefulWidget {
  @override
  _RemindersScreenState createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  double _height;
  double _width;

  DateTime _reminderDate = DateTime.now();

  bool _value = false;

  String _repeatValue = 'Never';
  String _untilValue = 'Forever';

  void _addReminder() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0)),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: _height * 0.7,
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.only(topLeft: Radius.circular(30.0)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: _width * 0.1,
                    right: _width * 0.1,
                    top: _height * 0.03,
                    bottom: _height * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: _width * 0.9,
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Add a New Reminder',
                                style:
                                StyleConstants.blackThinTitleTextMedium,
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text('Name',
                                  style: StyleConstants.blackThinTitleTextXS),
                              SizedBox(
                                height: 8.0,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Name',
                                  hintStyle: TextStyle(fontSize: 14.0),
                                ),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text('When',
                                  style: StyleConstants.blackThinTitleTextXS),
                              SizedBox(
                                height: 8.0,
                              ),
                              Container(
                                height: _height * 0.076,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: _width * 0.05),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            StringHelper.getDateStringNoYear(
                                                _reminderDate),
                                            style: StyleConstants
                                                .blackDescriptionText,
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.calendar_today),
                                            onPressed: () {
                                              showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2019),
                                                  lastDate: DateTime(2021))
                                                  .then((date) {
                                                setState(() {
                                                  _reminderDate = date;
                                                  print(_reminderDate.toString());
                                                });
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                ),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text('Repeat',
                                  style: StyleConstants.blackThinTitleTextXS),
                              SizedBox(
                                height: 8.0,
                              ),
                              Container(
                                height: _height * 0.076,
                                width: _width * 0.9 - 16,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: _width * 0.05),
                                  child: DropdownButton<String>(
                                      value: _repeatValue ?? 'Never',
                                      underline: SizedBox.shrink(),
                                      isExpanded: true,
                                      items: <String>[
                                        'Never',
                                        'Daily',
                                        'Weekly',
                                        'Monthly',
                                        'Yearly'
                                      ].map((String value) {
                                        return new DropdownMenuItem<String>(
                                          value: value,
                                          child: new Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String value) {
                                        setState(() {
                                          _repeatValue = value;
                                        });
                                      }),
                                ),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text('Until',
                                  style: StyleConstants.blackThinTitleTextXS),
                              SizedBox(
                                height: 8.0,
                              ),
                              Container(
                                height: _height * 0.076,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: _width * 0.05),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            StringHelper.getDateStringNoYear(
                                                _reminderDate),
                                            style: StyleConstants
                                                .blackDescriptionText,
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.calendar_today),
                                            onPressed: () {
                                              showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2019),
                                                  lastDate: DateTime(2021))
                                                  .then((date) {
                                                setState(() {
                                                  _reminderDate = date;
                                                  print(_reminderDate.toString());
                                                });
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                ),
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: StyleConstants.blue,
                                      borderRadius:
                                      BorderRadius.circular(40.0),
                                    ),
                                    height: _height * 0.06,
                                    width: _width * 0.5,
                                    child: Center(
                                        child: Text(
                                          'Set Reminder',
                                          style: StyleConstants
                                              .whiteThinTitleTextSmall,
                                        )),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  void _editReminder() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0)),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: _height * 0.7,
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.only(topLeft: Radius.circular(30.0)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: _width * 0.1,
                    right: _width * 0.1,
                    top: _height * 0.03,
                    bottom: _height * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: _width * 0.9,
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Edit Reminder',
                                style:
                                StyleConstants.blackThinTitleTextMedium,
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text('Name',
                                  style: StyleConstants.blackThinTitleTextXS),
                              SizedBox(
                                height: 8.0,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Name',
                                  hintStyle: TextStyle(fontSize: 14.0),
                                ),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text('When',
                                  style: StyleConstants.blackThinTitleTextXS),
                              SizedBox(
                                height: 8.0,
                              ),
                              Container(
                                height: _height * 0.076,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: _width * 0.05),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            StringHelper.getDateStringNoYear(
                                                _reminderDate),
                                            style: StyleConstants
                                                .blackDescriptionText,
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.calendar_today),
                                            onPressed: () {
                                              showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2019),
                                                  lastDate: DateTime(2021))
                                                  .then((date) {
                                                setState(() {
                                                  _reminderDate = date;
                                                  print(_reminderDate.toString());
                                                });
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                ),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text('Repeat',
                                  style: StyleConstants.blackThinTitleTextXS),
                              SizedBox(
                                height: 8.0,
                              ),
                              Container(
                                height: _height * 0.076,
                                width: _width * 0.9 - 16,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: _width * 0.05),
                                  child: DropdownButton<String>(
                                      value: _repeatValue ?? 'Never',
                                      underline: SizedBox.shrink(),
                                      isExpanded: true,
                                      items: <String>[
                                        'Never',
                                        'Daily',
                                        'Weekly',
                                        'Monthly',
                                        'Yearly'
                                      ].map((String value) {
                                        return new DropdownMenuItem<String>(
                                          value: value,
                                          child: new Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String value) {
                                        setState(() {
                                          _repeatValue = value;
                                        });
                                      }),
                                ),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text('Until',
                                  style: StyleConstants.blackThinTitleTextXS),
                              SizedBox(
                                height: 8.0,
                              ),
                              Container(
                                height: _height * 0.076,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: _width * 0.05),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            StringHelper.getDateStringNoYear(
                                                _reminderDate),
                                            style: StyleConstants
                                                .blackDescriptionText,
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.calendar_today),
                                            onPressed: () {
                                              showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2019),
                                                  lastDate: DateTime(2021))
                                                  .then((date) {
                                                setState(() {
                                                  _reminderDate = date;
                                                  print(_reminderDate.toString());
                                                });
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                ),
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: StyleConstants.red,
                                            borderRadius:
                                            BorderRadius.circular(40.0),
                                          ),
                                          height: _height * 0.06,
                                          width: _width * 0.35,
                                          child: Center(
                                              child: Text(
                                                'Delete',
                                                style: StyleConstants
                                                    .whiteThinTitleTextSmall,
                                              )),
                                        ),
                                        SizedBox(width: 20.0,),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: StyleConstants.blue,
                                            borderRadius:
                                            BorderRadius.circular(40.0),
                                          ),
                                          height: _height * 0.06,
                                          width: _width * 0.35,
                                          child: Center(
                                              child: Text(
                                                'Update',
                                                style: StyleConstants
                                                    .whiteThinTitleTextSmall,
                                              )),
                                        ),
                                      ],
                                    )
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;




    return Scaffold(
      appBar: ChangePetAppBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: StyleConstants.blue,
        onPressed: _addReminder,
      ),
      backgroundColor: StyleConstants.pageBackgroundColor,
      body: Container(
        height: _height,
        width: _width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _width * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: _height * 0.02),
                  child: ListView(
                    children: [
                      reminderItemWidget(
                          'Feed the Dog', '8/23/20', '9:00 am', 'Monthly'),
                      SizedBox(
                        height: _height * 0.02,
                      ),
                      reminderItemWidget(
                          'Feed the Cat', '8/27/20', '6:00 pm', 'Monthly'),
                      SizedBox(
                        height: _height * 0.02,
                      ),
                      reminderItemWidget(
                          'Reminder 1', '8/27/20', '6:00 pm', 'Monthly'),
                      SizedBox(
                        height: _height * 0.02,
                      ),
                      reminderItemWidget(
                          'Reminder 2', '8/31/20', '6:00 pm', 'Yearly'),
                      SizedBox(
                        height: _height * 0.02,
                      ),
                      reminderItemWidget(
                          'Reminder 3', '12/3/20', '6:00 pm', 'Monthly'),
                      SizedBox(
                        height: _height * 0.02,
                      ),
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

  Widget reminderItemWidget(
      String reminderName, String date, String time, String frequency) {
    return GestureDetector(
      onTap: _editReminder,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: StyleConstants.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 6.0,
                offset: Offset(0, 3),
              ),
            ]),
        width: _width * 0.8,
        height: _height * 0.12,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _width * 0.05),
          child: Row(
            children: [
              /*
              CircularCheckBox(
                value: _value,
                onChanged: (bool value) {
                  setState(() {
                    _value = value;
                  });
                },
                activeColor: StyleConstants.yellow,
              ),
              */
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reminderName,
                    style: StyleConstants.blackThinTitleTextSmall,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Recurring : $frequency',
                    style: StyleConstants.blackThinDescriptionTextSmall,
                  ),
                ],
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    date,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25.0,
                        color: StyleConstants.blue),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25.0,
                        color: StyleConstants.yellow),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
