import 'package:flutter/material.dart';
import 'package:petcode_app/utils/style_constants.dart';

class TextOnlyCurvedAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  TextOnlyCurvedAppBar({Key key}) : super(key: key);

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
        title: Text('Pet Perks'),);
  }
}
