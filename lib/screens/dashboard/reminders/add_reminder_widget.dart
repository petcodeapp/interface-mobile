import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/models/Reminder.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/services/database_service.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/utils/validator_helper.dart';
import 'package:provider/provider.dart';

class AddReminderWidget extends StatefulWidget {
  @override
  _AddReminderWidgetState createState() => _AddReminderWidgetState();
}

class _AddReminderWidgetState extends State<AddReminderWidget> {
  TextEditingController _reminderNameController;
  TextEditingController _reminderStartDateController;
  TextEditingController _reminderEndDateController;

  String _repeatValue;

  DateTime _reminderStartDate;
  DateTime _reminderEndDate;

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    _reminderNameController = new TextEditingController();
    _reminderStartDateController = new TextEditingController();
    _reminderEndDateController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;

    Pet currentPet = Provider.of<CurrentPetProvider>(context).currentPet;

    return Padding(
      padding: EdgeInsets.only(
        left: width * 0.1,
        right: width * 0.1,
        top: height * 0.03,
        bottom: height * 0.02,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width * 0.9,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'New Reminder',
                          style: StyleConstants.blackThinTitleTextMedium
                              .copyWith(fontSize: 22.0),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Text('Name',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              color: Colors.black.withOpacity(0.8))),
                      Container(
                        //color: Colors.blue,
                        child: SizedBox(
                          height: height * 0.07,
                          child: TextFormField(
                            controller: _reminderNameController,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: StyleConstants.lightBlack,
                                fontSize: 20.0),
                            decoration: InputDecoration(
                              //border: OutlineInputBorder(),
                              //hintText: 'Name',
                              hintStyle: TextStyle(fontSize: 14.0),
                            ),
                            validator: ValidatorHelper.reminderNameValidator,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Text('Date', style: StyleConstants.blackThinTitleTextXS),
                      SizedBox(
                        height: height * 0.07,
                        child: TextField(
                            controller: _reminderStartDateController,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: StyleConstants.lightBlack,
                                fontSize: 20.0),
                            decoration: InputDecoration(
                              //border: OutlineInputBorder(),
                              hintText: 'Start Date',
                              hintStyle: TextStyle(fontSize: 14.0),
                              suffixIcon: Icon(
                                Icons.calendar_today,
                              ),
                            ),
                            onTap: () {
                              showDatePicker(
                                context: context,
                                firstDate: DateTime(2010),
                                lastDate: DateTime(2050),
                                initialDate: DateTime.now(),
                              ).then((DateTime selectedDate) {
                                if (selectedDate != null) {
                                  setState(() {
                                    _reminderStartDateController =
                                        new TextEditingController(
                                            text: StringHelper
                                                .getDateStringNoYear(
                                                    selectedDate));
                                    _reminderStartDate = selectedDate;
                                  });
                                  showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now())
                                      .then((TimeOfDay selectedTime) {
                                    setState(() {
                                      _reminderStartDateController =
                                          new TextEditingController(
                                              text: _reminderStartDateController
                                                      .text +
                                                  ', ' + selectedTime.format(context));
                                      _reminderStartDate =
                                          _reminderStartDate.add(Duration(
                                              hours: selectedTime.hour,
                                              minutes: selectedTime.minute));
                                    });
                                  });
                                }
                              });
                            }),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Text('Repeat',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              color: Colors.black.withOpacity(0.8))),
                      DropdownButton<String>(
                          value: _repeatValue ?? 'Monthly',
                          //underline: SizedBox.shrink(),
                          underline: Container(
                            color: Colors.grey,
                            height: 1.0,
                          ),
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
                              child: new Text(
                                value,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: StyleConstants.lightBlack,
                                    fontSize: 20.0),
                              ),
                            );
                          }).toList(),
                          onChanged: (String value) {
                            setState(() {
                              _repeatValue = value;
                            });
                          }),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      _repeatValue == 'Never'
                          ? SizedBox.shrink()
                          : Text('End Date',
                              style: StyleConstants.blackThinTitleTextXS),
                      _repeatValue == 'Never'
                          ? SizedBox.shrink()
                          : SizedBox(
                              height: height * 0.07,
                              child: TextField(
                                controller: _reminderEndDateController,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: StyleConstants.lightBlack,
                                    fontSize: 20.0),
                                decoration: InputDecoration(
                                  hintText: 'End Date',
                                  hintStyle: TextStyle(fontSize: 14.0),
                                  suffixIcon: Icon(Icons.calendar_today),
                                ),
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    firstDate: DateTime(2010),
                                    lastDate: DateTime(2050),
                                    initialDate: DateTime.now(),
                                  ).then((DateTime selectedDate) {
                                    if (selectedDate != null) {
                                      setState(() {
                                        _reminderEndDateController =
                                            new TextEditingController(
                                                text: StringHelper
                                                    .getDateStringNoYear(
                                                        selectedDate));
                                        _reminderEndDate = selectedDate;
                                      });
                                    }
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((TimeOfDay selectedTime) {
                                      if (selectedTime != null) {
                                        setState(() {
                                          _reminderEndDateController =
                                              new TextEditingController(
                                                  text:
                                                      _reminderEndDateController
                                                              .text +
                                                          ', ' + selectedTime.format(context));
                                          _reminderEndDate =
                                              _reminderEndDate.add(Duration(
                                                  hours: selectedDate.hour,
                                                  minutes:
                                                      selectedTime.minute));
                                        });
                                      }
                                    });
                                  });
                                },
                                readOnly: true,
                              ),
                            ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            if (_formKey.currentState.validate()) {
                              Reminder newReminder = new Reminder(
                                  name: _reminderNameController.text,
                                  notificationMethod: 'email',
                                  frequency: _repeatValue,
                                  enabled: true,
                                  startDate:
                                      Timestamp.fromDate(_reminderStartDate),
                                  endDate:
                                      Timestamp.fromDate(_reminderEndDate));
                              Provider.of<DatabaseService>(context,
                                      listen: false)
                                  .addReminder(newReminder, currentPet);
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: StyleConstants.blue,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 6.0,
                                    offset: Offset(0, 4),
                                  )
                                ]),
                            height: height * 0.06,
                            width: width * 0.8,
                            child: Center(
                                child: Text('Schedule Reminder',
                                    style: StyleConstants
                                        .whiteBoldButtonTextSmall)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
