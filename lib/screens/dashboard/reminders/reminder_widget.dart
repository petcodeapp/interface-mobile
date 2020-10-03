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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.02),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentReminder.name,
                      style: StyleConstants.blackThinTitleTextSmall,
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      'Recurring ' + (currentReminder.frequency ?? 'none'),
                      style: StyleConstants.blackThinDescriptionTextSmall,
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Spacer(),
              Expanded(
                flex: 3,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        currentReminder.startDate != null ? StringHelper.getDateString(currentReminder.startDate.toDate()) : 'No Start Date',
                        style: StyleConstants.blueDescriptionText,
                        maxLines: 10,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        currentReminder.startDate != null ? StringHelper.getTimeString(currentReminder.startDate.toDate()) : 'No Time',
                        style: StyleConstants.yellowDescriptionText,
                        maxLines: 10,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
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
                height: height * 0.72,
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
