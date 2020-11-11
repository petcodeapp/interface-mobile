import 'package:flutter/material.dart';
import 'package:petcode_app/models/Reminder.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/screens/dashboard/reminders/add_reminder_widget.dart';
import 'package:petcode_app/screens/dashboard/reminders/reminder_widget.dart';
import 'package:petcode_app/utils/hero_icons2.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/change_pet_dropdown.dart';
import 'package:provider/provider.dart';

class RemindersScreen extends StatelessWidget {
  void _addReminder(BuildContext context, double height) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        builder: (BuildContext context) {
          return Container(
            height: height * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
            ),
            child: AddReminderWidget(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;

    CurrentPetProvider currentPetProvider =
        Provider.of<CurrentPetProvider>(context);
    List<Reminder> allReminders = currentPetProvider.currentPet.reminders;

    allReminders.sort((Reminder reminderA, Reminder reminderB) {
      if (reminderA.startDate == null) {
        return -1;
      } else if (reminderB.startDate == null) {
        return 1;
      } else {
        return reminderA.startDate.compareTo(reminderB.startDate);
      }
    });

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: StyleConstants.blue,
        onPressed: () => _addReminder(context, height),
      ),
      backgroundColor: StyleConstants.blue,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              //end: Alignment(0.01, 0.01),
              end: Alignment.bottomLeft,
              stops: [0.01, 0.4, 0.6],
              colors: [
                const Color(0xffABDEED),
                const Color(0xff51BFDA),
                StyleConstants.blue
              ], // whitish to gray
              //tileMode: TileMode.repeated,
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: StyleConstants.bgGradient,
              ),
              height: height * 0.15,
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.1, vertical: height * 0.02),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ChangePetDropdown(),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 25.0,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      )
                    ],
                  )),
            ),
            Expanded(
              child: Container(
                height: height * 0.5,
                width: width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                  child: ListView.builder(
                    itemCount: allReminders.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          ReminderWidget(
                            currentReminder: allReminders[index],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
