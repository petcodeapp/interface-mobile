import 'package:flutter/material.dart';

class StyleConstants{
  //colors
  static Color darkGrey = new Color(0xff66615B);

  static Color lightBlue = new Color(0xff51CBCE);

  static Color blue = new Color(0xff51BCDA);

  static Color green = new Color(0xff6BD098);

  static Color red = new Color(0xffF5593D);

  static Color white = new Color(0xffFFFFFF);

  static Color yellow = new Color(0xffFBC658);

  //text styles
  static TextStyle whiteButtonText =  new TextStyle(
    color: white,
    fontSize: 25.0,
    fontFamily: 'Lilita',
  );

  static TextStyle yellowButtonText =  new TextStyle(
    color: yellow,
    fontSize: 25.0,
    fontFamily: 'Lilita',
  );

  static TextStyle whiteTitleText =  new TextStyle(
    color: Colors.white,
    fontSize: 30.0,
    fontFamily: 'Lilita',
  );

  static TextStyle whiteTitleTextLarge =  new TextStyle(
    color: Colors.white,
    fontSize: 40.0,
    fontFamily: 'Lilita',
  );

  static TextStyle whiteTitleTextSmall =  new TextStyle(
    color: Colors.white,
    fontSize: 25.0,
    fontFamily: 'Lilita',
  );

  static TextStyle whiteTitleTextXS =  new TextStyle(
    color: Colors.white,
    fontSize: 20.0,
    fontFamily: 'Lilita',
  );

  static TextStyle whiteTitleTextXL =  new TextStyle(
    color: Colors.white,
    fontSize: 50.0,
    fontFamily: 'Lilita',
  );

  static TextStyle whiteDescriptionText = new TextStyle(
    color: Colors.white,
    fontSize: 20.0,
    fontWeight: FontWeight.w400,
  );
  
  static TextStyle blackTitleText =  new TextStyle(
    color: Colors.black,
    fontSize: 30.0,
    fontFamily: 'Lilita',
  );

  static TextStyle blackTitleTextLarge =  new TextStyle(
    color: Colors.black,
    fontSize: 40.0,
    fontFamily: 'Lilita',
  );

  static TextStyle blackTitleTextSmall =  new TextStyle(
    color: Colors.black,
    fontSize: 25.0,
    fontFamily: 'Lilita',
  );

  static TextStyle blackTitleTextXS =  new TextStyle(
    color: Colors.black,
    fontSize: 20.0,
    fontFamily: 'Lilita',
  );

  static TextStyle blackTitleTextXL =  new TextStyle(
    color: Colors.black,
    fontSize: 50.0,
    fontFamily: 'Lilita',
  );

  static TextStyle blackDescriptionText = new TextStyle(
    color: Colors.black,
    fontSize: 20.0,
    fontWeight: FontWeight.w400,
  );

  static TextStyle blackThinDescriptionText = new TextStyle(
    color: Colors.black,
    fontSize: 20.0,
    fontWeight: FontWeight.w300,
  );

  //box decorations
  static BoxDecoration roundYellowButtonDeco = new BoxDecoration(
      color: yellow,
      borderRadius: BorderRadius.circular(30.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 5.0,
          spreadRadius: 2,
          offset: Offset(0,2),
        ),
      ]
  );
  static BoxDecoration roundWhiteButtonDeco = new BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(30.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 5.0,
          spreadRadius: 2,
          offset: Offset(0,2),
        ),
      ]
  );

  static BoxDecoration roundRedButtonDeco = new BoxDecoration(
    color: StyleConstants.red,
    borderRadius: BorderRadius.circular(50.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 6.0,
        //spreadRadius: 2,
        offset: Offset(0,3),
      ),
    ],
  );

  static BoxDecoration infoEntryBoxDeco = new BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 6.0,
          offset: Offset(0, 3),
        ),
      ]
  );

  static BoxDecoration lightBlueItemBoxDeco = new BoxDecoration(
      color: StyleConstants.lightBlue,
      borderRadius: BorderRadius.circular(5.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 6.0,
          //spreadRadius: 2,
          offset: Offset(0,3),
        ),
      ],
  );
}