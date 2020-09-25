import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChooseImageSourceDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return SimpleDialog(
        title: Text('Add Photo'),
        children: <Widget>[
          SimpleDialogOption(
            child: Text('Take Photo'),
            onPressed: () => Navigator.pop(context, ImageSource.camera),
          ),
          SimpleDialogOption(
            child: Text('Choose From Gallery'),
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
          ),
          SimpleDialogOption(
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.redAccent,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );
    } else {
      return SimpleDialog(
        title: Text('Add Photo'),
        children: <Widget>[
          SimpleDialogOption(
            child: Text('Take Photo'),
            onPressed: () => Navigator.pop(context, ImageSource.camera),
          ),
          SimpleDialogOption(
            child: Text('Choose From Gallery'),
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
          ),
          SimpleDialogOption(
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.redAccent,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );
    }
  }
}
