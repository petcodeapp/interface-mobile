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

class EditReminderWidget extends StatefulWidget {
  EditReminderWidget({Key key, this.currentReminder}) : super(key: key);
  final Reminder currentReminder;

  @override
  _EditReminderWidgetState createState() => _EditReminderWidgetState();
}

class _EditReminderWidgetState extends State<EditReminderWidget> {
  TextEditingController _reminderNameController;
  TextEditingController _reminderStartDateController;
  TextEditingController _reminderEndDateController;

  DateTime _reminderStartDate;
  DateTime _reminderEndDate;

  String _repeatValue;

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  bool _showEndDate;

  @override
  void initState() {
    _reminderNameController =
        new TextEditingController(text: widget.currentReminder.name);
    _reminderStartDateController = new TextEditingController();
    _reminderEndDateController = new TextEditingController();
    if (widget.currentReminder.startDate != null) {
      _reminderStartDateController
        ..text = StringHelper.getDateStringNoYear(
                widget.currentReminder.startDate.toDate()) +
            ', ' +
            StringHelper.getTimeString(
                widget.currentReminder.startDate.toDate());
      _reminderStartDate = widget.currentReminder.startDate.toDate();
    }
    if (widget.currentReminder.endDate != null) {
      _reminderEndDateController
        ..text = StringHelper.getDateStringNoYear(
                widget.currentReminder.endDate.toDate()) +
            ', ' +
            StringHelper.getTimeString(widget.currentReminder.endDate.toDate());
      _reminderEndDate = widget.currentReminder.endDate.toDate();
    }
    _repeatValue = widget.currentReminder.frequency;

    if (_repeatValue == 'Never') {
      _showEndDate = false;
    } else {
      _showEndDate = true;
    }

    super.initState();
  }

  List frequencySelection = <String>[
    'Never',
    'Daily',
    'Weekly',
    'Monthly',
    'Yearly'
  ];

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
                          'Edit Reminder',
                          style: StyleConstants.blackThinTitleTextMedium
                              .copyWith(fontSize: 22.0),
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text('Name', style: StyleConstants.blackThinTitleTextXS),
                      SizedBox(
                        height: height * 0.07,
                        child: TextFormField(
                          controller: _reminderNameController,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: StyleConstants.lightBlack,
                              fontSize: 20.0),
                          decoration: InputDecoration(
                            hintText: 'Name',
                            hintStyle: TextStyle(fontSize: width * 0.04),
                          ),
                          validator: ValidatorHelper.reminderNameValidator,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Text('Date and Time',
                          style: StyleConstants.blackThinTitleTextXS),
                      SizedBox(
                        height: height * 0.07,
                        child: TextField(
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: StyleConstants.lightBlack,
                              fontSize: 20.0),
                          controller: _reminderStartDateController,
                          decoration: InputDecoration(
                            hintText: 'Start Date',
                            hintStyle: TextStyle(fontSize: width * 0.04),
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    firstDate: DateTime(2010),
                                    lastDate: DateTime(2050),
                                    initialDate: DateTime.now())
                                .then((DateTime selectedDate) {
                              if (selectedDate != null) {
                                setState(() {
                                  _reminderStartDateController =
                                      new TextEditingController(
                                          text:
                                              StringHelper.getDateStringNoYear(
                                                  selectedDate));
                                  _reminderStartDate = selectedDate;
                                });
                              }
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((TimeOfDay selectedTime) {
                                if (selectedTime != null) {
                                  setState(() {
                                    _reminderStartDateController =
                                        new TextEditingController(
                                            text: _reminderStartDateController
                                                    .text +
                                                ', ' +
                                                selectedTime.format(context));
                                    _reminderStartDate = _reminderStartDate.add(
                                        Duration(
                                            hours: selectedTime.hour,
                                            minutes: selectedTime.minute));
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
                      Text('Repeat',
                          style: StyleConstants.blackThinTitleTextXS),
                      DropdownButton<String>(
                          value: _repeatValue ?? 'Never',
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
                              if (value == 'Never') {
                                _showEndDate = false;
                              } else {
                                _showEndDate = true;
                              }
                              _repeatValue = value;
                            });
                          }),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      _repeatValue == 'Never'
                          ? SizedBox.shrink()
                          : Text('End Date/Time',
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
                                  hintStyle: TextStyle(
                                    fontSize: 14.0,
                                  ),
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
                                                          ', ' +
                                                          selectedTime
                                                              .format(context));
                                          _reminderEndDate =
                                              _reminderEndDate.add(Duration(
                                                  hours: selectedTime.hour,
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
                                startDate: _reminderStartDate != null
                                    ? Timestamp.fromDate(_reminderStartDate)
                                    : null,
                                endDate: _reminderEndDate != null
                                    ? Timestamp.fromDate(_reminderEndDate)
                                    : null,
                                index: widget.currentReminder.index,
                              );
                              Provider.of<DatabaseService>(context,
                                      listen: false)
                                  .updateReminder(newReminder, currentPet);
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: StyleConstants.blue,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            height: height * 0.06,
                            width: width * 0.8,
                            child: Center(
                                child: Text(
                              'Schedule Reminder',
                              style: StyleConstants.whiteBoldButtonTextSmall,
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<DatabaseService>(context, listen: false)
                                .deleteReminder(
                                    widget.currentReminder.index, currentPet);
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: StyleConstants.red,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            height: height * 0.06,
                            width: width * 0.8,
                            child: Center(
                                child: Text(
                              'Delete Reminder',
                              style: StyleConstants.whiteBoldButtonTextSmall,
                            )),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20.0,
                            ),
                          ],
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
