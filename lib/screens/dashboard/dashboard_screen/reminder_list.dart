import 'package:flutter/material.dart';
import 'package:indexed_list_view/indexed_list_view.dart';
import 'package:petcode_app/models/UpcomingEvent.dart';
import 'package:petcode_app/providers/notifications_provider.dart';
import 'package:petcode_app/screens/dashboard/dashboard_screen/glowing_reminder_widget.dart';
import 'package:petcode_app/screens/dashboard/dashboard_screen/reminder_widget.dart';
import 'package:petcode_app/utils/map_constants.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ReminderList extends StatefulWidget {
  final List<UpcomingEvent> allPetUpcomingEvents;

  ReminderList({Key key, this.allPetUpcomingEvents}) : super(key: key);

  @override
  _ReminderListState createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList> {
  AutoScrollController _scrollController;

  @override
  void initState() {
    _scrollController = new AutoScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;
    NotificationsProvider notificationsProvider =
        Provider.of<NotificationsProvider>(context);

    int reminderIndex = -1;
    if (notificationsProvider.currentAction == 'reminder expired') {
      reminderIndex = int.tryParse(notificationsProvider.params);
      if (reminderIndex != null &&
          reminderIndex > 0 &&
          _scrollController.hasClients) {
        _scrollController.scrollToIndex(reminderIndex,
            duration: Duration(seconds: 1));
      }
    }

    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      //physics: AlwaysScrollableScrollPhysics(),
      controller: _scrollController,
      itemCount: widget.allPetUpcomingEvents.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (index == reminderIndex) {
          return AutoScrollTag(
            key: ValueKey(index),
            controller: _scrollController,
            index: index,
            highlightColor: MapConstants.markerColors[index],
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  width * 0.012, 0, width * 0.012, height * 0.024),
              child: GlowingReminderWidget(
                completed: false,
                name: widget.allPetUpcomingEvents[index].name,
                date: widget.allPetUpcomingEvents[index].date != null
                    ? widget.allPetUpcomingEvents[index].date.toDate()
                    : null,
              ),
            ),
          );
        } else {
          return AutoScrollTag(
            key: ValueKey(index),
            controller: _scrollController,
            index: index,
            highlightColor: MapConstants.markerColors[index],
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  width * 0.012, 0, width * 0.012, height * 0.024),
              child: ReminderWidget(
                completed: false,
                name: widget.allPetUpcomingEvents[index].name,
                date: widget.allPetUpcomingEvents[index].date != null
                    ? widget.allPetUpcomingEvents[index].date.toDate()
                    : null,
              ),
            ),
          );
        }
      },
    );
  }
}
