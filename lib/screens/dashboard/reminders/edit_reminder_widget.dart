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

  @override
  void initState() {
    _reminderNameController =
        new TextEditingController(text: widget.currentReminder.name);
    _reminderStartDateController = new TextEditingController();
    _reminderEndDateController = new TextEditingController();
    if (widget.currentReminder.startDate != null) {
      _reminderStartDateController
        ..text = StringHelper.getDateStringNoYear(
            widget.currentReminder.startDate.toDate());
      _reminderStartDate = widget.currentReminder.startDate.toDate();
    }
    if (widget.currentReminder.endDate != null) {
      _reminderEndDateController
        ..text = StringHelper.getDateStringNoYear(
            widget.currentReminder.endDate.toDate());
      _reminderEndDate = widget.currentReminder.endDate.toDate();
    }
    _repeatValue = widget.currentReminder.frequency;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    Pet currentPet = Provider.of<CurrentPetProvider>(context).currentPet;

    return Padding(
      padding: EdgeInsets.only(
        left: width * 0.1,
        right: width * 0.1,
        top: height * 0.03,
        bottom: height * 0.02,
      ),
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
                    Text(
                      'Edit Reminder',
                      style: StyleConstants.blackThinTitleTextMedium,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text('Name', style: StyleConstants.blackThinTitleTextXS),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      controller: _reminderNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Name',
                        hintStyle: TextStyle(fontSize: 14.0),
                      ),
                      validator: ValidatorHelper.reminderNameValidator,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text('When', style: StyleConstants.blackThinTitleTextXS),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      controller: _reminderStartDateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Start Date',
                        hintStyle: TextStyle(fontSize: 14.0),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      onTap: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2019),
                                lastDate: DateTime(2021))
                            .then((DateTime selectedDate) {
                          setState(() {
                            _reminderStartDateController
                              ..text = StringHelper.getDateStringNoYear(
                                  selectedDate);
                            _reminderStartDate = selectedDate;
                          });
                        });
                      },
                      readOnly: true,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text('Repeat', style: StyleConstants.blackThinTitleTextXS),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      height: height * 0.076,
                      width: width * 0.9 - 16,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
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
                    Text('Until', style: StyleConstants.blackThinTitleTextXS),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      controller: _reminderEndDateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'End Date',
                        hintStyle: TextStyle(fontSize: 14.0),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      onTap: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2019),
                                lastDate: DateTime(2050))
                            .then((DateTime selectedDate) {
                          setState(() {
                            _reminderEndDateController
                              ..text = StringHelper.getDateStringNoYear(
                                  selectedDate);
                            _reminderEndDate = selectedDate;
                          });
                        });
                      },
                      readOnly: true,
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Provider.of<DatabaseService>(context,
                                      listen: false)
                                  .deleteReminder(
                                      widget.currentReminder.index, currentPet);
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: StyleConstants.red,
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              height: height * 0.06,
                              width: width * 0.35,
                              child: Center(
                                  child: Text(
                                'Delete',
                                style: StyleConstants.whiteThinTitleTextSmall,
                              )),
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                Reminder newReminder = new Reminder(
                                  name: _reminderNameController.text,
                                  notificationMethod: 'email',
                                  frequency: _repeatValue,
                                  enabled: true,
                                  startDate:
                                      Timestamp.fromDate(_reminderStartDate),
                                  endDate: Timestamp.fromDate(_reminderEndDate),
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
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              height: height * 0.06,
                              width: width * 0.35,
                              child: Center(
                                  child: Text(
                                'Update',
                                style: StyleConstants.whiteThinTitleTextSmall,
                              )),
                            ),
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
    );
  }
}
