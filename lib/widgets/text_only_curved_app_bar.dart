import 'package:flutter/material.dart';
import 'package:petcode_app/providers/notifications_provider.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class TextOnlyCurvedAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  TextOnlyCurvedAppBar({Key key, this.customBack}) : super(key: key);
  final bool customBack;

  @override
  _TextOnlyCurvedAppBarState createState() => _TextOnlyCurvedAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TextOnlyCurvedAppBarState extends State<TextOnlyCurvedAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: StyleConstants.blue,
        centerTitle: true,
        elevation: 6.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: Text('Pet Perks'),
        leading: widget.customBack != null && widget.customBack
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  } else {
                    Provider.of<NotificationsProvider>(context, listen: false)
                        .clear();
                    Navigator.popAndPushNamed(context, '/');
                  }
                })
            : null);
  }
}
