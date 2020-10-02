import 'package:flutter/material.dart';
import 'package:petcode_app/models/Reminder.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/screens/dashboard/reminders/add_reminder_widget.dart';
import 'package:petcode_app/screens/dashboard/reminders/reminder_widget.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/custom_app_bars/change_pet_app_bar.dart';
import 'package:provider/provider.dart';

class RemindersScreen extends StatelessWidget {
  void _addReminder(BuildContext context, double height) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        ),
        builder: (BuildContext context) {
          return Container(
            height: height * 0.72,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0)),
            ),
            child: AddReminderWidget(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
      appBar: ChangePetAppBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: StyleConstants.blue,
        onPressed: () => _addReminder(context, height),
      ),
      backgroundColor: StyleConstants.pageBackgroundColor,
      body: Container(
        height: height,
        width: width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.02),
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
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
