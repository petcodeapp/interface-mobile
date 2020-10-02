import 'package:flutter/material.dart';
import 'package:petcode_app/models/UpcomingEvent.dart';
import 'package:petcode_app/providers/all_pets_provider.dart';
import 'package:petcode_app/providers/notifications_provider.dart';
import 'package:petcode_app/screens/dashboard/dashboard_screen/glowing_reminder_widget.dart';
import 'package:petcode_app/screens/dashboard/dashboard_screen/reminder_widget.dart';
import 'package:petcode_app/services/pet_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class UpcomingEventsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    AllPetsProvider allPetsProvider = Provider.of<AllPetsProvider>(context);
    List<UpcomingEvent> allPetUpcomingEvents = allPetsProvider.getAllPetReminders();

    NotificationsProvider notificationsProvider =
        Provider.of<NotificationsProvider>(context);

    int reminderIndex = -1;
    if (notificationsProvider.currentPayload == 'reminder expired') {
      reminderIndex = notificationsProvider.index;
      // if (notificationsProvider.index != null &&
      //     notificationsProvider.index > 0 && _scrollController.hasClients) {
      //   _scrollController.animateTo(
      //       height * 0.02 + 200 + height * 0.1 * reminderIndex,
      //       duration: Duration(seconds: 1),
      //       curve: Curves.easeOut);
      // }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height * 0.01,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'Upcoming',
            style: StyleConstants.blackThinTitleTextMedium,
          ),
        ),
        Container(

          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: allPetUpcomingEvents.length,
            itemBuilder: (context, index) {
              if (index == reminderIndex) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: GlowingReminderWidget(
                    completed: false,
                    name: allPetUpcomingEvents[index].name,
                    date: allPetUpcomingEvents[index].date.toDate(),
                  ),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: ReminderWidget(
                    completed: false,
                    name: allPetUpcomingEvents[index].name,
                    date: allPetUpcomingEvents[index].date.toDate(),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
