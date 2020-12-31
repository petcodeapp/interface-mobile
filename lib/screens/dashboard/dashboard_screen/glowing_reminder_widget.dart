import 'package:flutter/material.dart';
import 'package:petcode_app/providers/notifications_provider.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/screens/dashboard/dashboard_screen/reminder_widget.dart';
import 'package:provider/provider.dart';

class GlowingReminderWidget extends StatefulWidget {
  GlowingReminderWidget({Key key, this.completed, this.name, this.date})
      : super(key: key);

  final bool completed;
  final String name;
  final DateTime date;

  @override
  _GlowingReminderWidgetState createState() => _GlowingReminderWidgetState();
}

class _GlowingReminderWidgetState extends State<GlowingReminderWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animationController.repeat(reverse: true);
    _animation = Tween(begin: 2.0, end: 6.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<NotificationsProvider>(context, listen: false).clear();
      },
      child: Container(
        child: ReminderWidget(
          completed: widget.completed,
          name: widget.name,
          date: widget.date,
        ),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: StyleConstants.yellow,
            blurRadius: _animation.value,
            spreadRadius: _animation.value,
          ),
        ], borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
