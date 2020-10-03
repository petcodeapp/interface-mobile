import 'package:flutter/material.dart';
import 'package:petcode_app/models/Reminder.dart';
import 'package:petcode_app/screens/dashboard/reminders/edit_reminder_widget.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';

class ReminderWidget extends StatelessWidget {
  ReminderWidget({Key key, this.currentReminder}) : super(key: key);
  
  final Reminder currentReminder;
  
  @override
  Widget build(BuildContext context) {

    print(currentReminder.frequency);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => _editReminder(context, height),
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
        width: width * 0.8,
        height: height * 0.12,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recurring ' + (currentReminder.frequency ?? 'none'),
                    style: StyleConstants.blackThinDescriptionTextSmall,
                  ),

                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    currentReminder.name,
                    style: StyleConstants.blackThinTitleTextSmall,
                  ),
                ],
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentReminder.startDate != null ? StringHelper.getDateString(currentReminder.startDate.toDate()) : 'No Start Date',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                        color: StyleConstants.blue),
                  ),
                  Text(
                    currentReminder.startDate != null ? StringHelper.getTimeString(currentReminder.startDate.toDate()) : 'No Time',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
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

  void _editReminder(BuildContext context, double height) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: height * 0.7,
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.only(topLeft: Radius.circular(30.0)),
                ),
                child: EditReminderWidget(currentReminder: currentReminder,),
              );
            },
          );
        });
  }
}
