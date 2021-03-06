import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';

class ReminderWidget extends StatefulWidget {
  ReminderWidget({Key key, this.completed, this.name, this.date})
      : super(key: key);

  final bool completed;
  final String name;
  final DateTime date;
  @override
  _ReminderWidgetState createState() => _ReminderWidgetState();
}

class _ReminderWidgetState extends State<ReminderWidget> {
  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(10.0)),
      height: height * 0.1,
      width: width * 0.9,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: width * 0.1,
              child: Center(
                child: Container(
                  height: width * 0.03,
                  width: width * 0.03,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    //need to add something to get difference between dates
                    color: StyleConstants.getReminderColor(widget.date),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width * 0.03,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.date != null
                    ? Text(
                        StringHelper.getDateString(widget.date) +
                            ' - ' +
                            DateFormat.jm().format(widget.date),
                        overflow: TextOverflow.ellipsis,
                        style: StyleConstants.darkGreyThinDescriptionTextSmall
                            .copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey),
                        //style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400, color: StyleConstants.darkPurpleGrey),
                      )
                    : Text(
                        'No date given',
                        overflow: TextOverflow.ellipsis,
                        style: StyleConstants.darkGreyThinDescriptionTextSmall
                            .copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey),
                      ),
                Text(
                  widget.name,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  maxLines: 1,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
