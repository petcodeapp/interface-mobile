import 'package:flutter/material.dart';

class StyleConstants {
  static MediaQueryData _mediaQueryData;

  //for iPhone SE2 - 647.0 and 375.0
  static double height;
  static double width;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    height = _mediaQueryData.size.height -
        (_mediaQueryData.padding.top + _mediaQueryData.padding.bottom);
    width = _mediaQueryData.size.width -
        (_mediaQueryData.padding.left + _mediaQueryData.padding.right);

    print('height: ' + height.toString() + ' width: ' + width.toString());
  }

  //colors

  static Color lightBlue = new Color(0xff51CBCE);

  static Color blue = new Color(0xff52BCDA);

  static Color green = new Color(0xff6BD098);

  static Color red = new Color(0xffF5593D);

  static Color white = new Color(0xffFFFFFF);

  static Color yellow = new Color(0xffFBC658);

  static Color lightGrey = new Color(0xffB4C1CF);

  static Color veryLightGrey = new Color(0xffEEF2F7);

  static Color purpleGrey = new Color(0xffEDF2F7);

  static Color darkPurpleGrey = new Color(0xffA0AEC0);

  static Color grey = new Color(0xff9098A5);

  static Color darkGrey = new Color(0xff575B5F);

  static Color lightBlack = new Color(0xff2D3748);

  static Color pageBackgroundColor = new Color(0xffEEF2F6);

//  static LinearGradient bgGradient = new LinearGradient(
//    begin: Alignment.topRight,
//    //end: Alignment(0.01, 0.01),
//    end: Alignment.centerLeft,
//    stops: [0.05, 0.25, 0.7],
//    colors: [
//      const Color(0xffB3E1EE),
//      const Color(0xff7cdcf7),
//      StyleConstants.blue
//    ], // whitish to gray
//    //tileMode: TileMode.repeated,
//  );

  static LinearGradient bgGradient = new LinearGradient(
    begin: Alignment.topRight,
    //end: Alignment(0.01, 0.01),
    end: Alignment.bottomLeft,
    stops: [0.01, 0.3, 0.7],
    colors: [
      const Color(0xffABDEED),
      const Color(0xff51BFDA),
      StyleConstants.blue
    ], // whitish to gray
    //tileMode: TileMode.repeated,
  );

  //text styles
  static TextStyle whiteButtonText = TextStyle(
    fontFamily: 'OpenSans',
    color: white,
    fontSize: width * 0.06,
  );

  static TextStyle yellowButtonText = TextStyle(
    fontFamily: 'OpenSans',
    color: yellow,
    fontSize: width * 0.06,
  );

  static TextStyle pageTitleText = TextStyle(
      color: Colors.white,
      fontFamily: 'Open Sans',
      fontSize: width * 0.055,
      fontWeight: FontWeight.bold
  );

  static TextStyle whiteTitleText = TextStyle(
    fontFamily: 'OpenSans',
    color: Colors.white,
    fontSize: width * 0.07,
  );

  static TextStyle whiteBoldTitleText = TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 30.0,
      color: Colors.white,
      fontWeight: FontWeight.w600);

  static TextStyle whiteTitleTextLarge = TextStyle(
    fontFamily: 'OpenSans',
    color: Colors.white,
    fontSize: width * 0.1,
  );

  static TextStyle whiteTitleTextSmall = TextStyle(
    fontFamily: 'OpenSans',
    color: Colors.white,
    fontSize: width * 0.06,
  );

  static TextStyle whiteTitleTextXS = TextStyle(
    fontFamily: 'OpenSans',
    color: Colors.white,
    fontSize: width * 0.05,
  );

  static TextStyle whiteTitleTextXL = TextStyle(
    fontFamily: 'OpenSans',
    color: Colors.white,
    fontSize: width * 0.12,
  );

  static TextStyle whiteDescriptionText = new TextStyle(
    fontFamily: 'OpenSans',
    color: Colors.white,
    fontSize: width * 0.05,
    fontWeight: FontWeight.w400,
  );

  static TextStyle whiteDescriptionTextSmall = new TextStyle(
    fontFamily: 'OpenSans',
    color: Colors.white,
    fontSize: width * 0.035,
    fontWeight: FontWeight.w400,
  );

  static TextStyle whiteDescriptionTextXS = new TextStyle(
    fontFamily: 'OpenSans',
    color: Colors.white,
    fontSize: width * 0.021,
    fontWeight: FontWeight.w400,
  );

  static TextStyle whiteThinTitleTextLarge = new TextStyle(
    color: Colors.white,
    fontFamily: 'OpenSans',
    fontSize: width * 0.1,
    fontWeight: FontWeight.w400,
  );

  static TextStyle blackTitleText = TextStyle(
    fontFamily: 'OpenSans',
    color: Colors.black,
    fontSize: width * 0.06,
    fontWeight: FontWeight.w800,
  );

  static TextStyle blackTitleTextLarge = TextStyle(
    fontFamily: 'OpenSans',
    color: Colors.black,
    fontSize: width * 0.1,
  );

  static TextStyle blackTitleTextSmall = TextStyle(
    fontFamily: 'OpenSans',
    color: Colors.black,
    fontSize: width * 0.06,
  );

  static TextStyle blackTitleTextXS = TextStyle(
    fontFamily: 'OpenSans',
    color: Colors.black,
    fontSize: width * 0.05,
  );

  static TextStyle blackTitleTextXL = TextStyle(
    fontFamily: 'OpenSans',
    color: Colors.black,
    fontSize: width * 0.12,
  );

  static TextStyle blackThinTitleText = TextStyle(
    fontFamily: 'OpenSans',
    color: Colors.black,
    fontSize: width * 0.07,
    fontWeight: FontWeight.w600,
  );

  static TextStyle blackThinTitleTextMedium = TextStyle(
    color: Colors.black,
    fontSize: width * 0.06,
    fontWeight: FontWeight.w600,
    fontFamily: 'OpenSans',
  );

  static TextStyle blackThinTitleTextXS = TextStyle(
    color: Colors.black,
    fontFamily: 'OpenSans',
    fontSize: width * 0.04,
    fontWeight: FontWeight.w400,
  );

  static TextStyle darkBlackDescriptionText = TextStyle(
    fontSize: width * 0.041,
    fontWeight: FontWeight.w500,
    color: Colors.black.withOpacity(0.8),
    fontFamily: 'OpenSans',
  );

  static TextStyle tinyGreyDescriptionText = TextStyle(
    fontSize: width * 0.035,
    fontWeight: FontWeight.w400,
    color: darkPurpleGrey,
    fontFamily: 'OpenSans',
  );

  static TextStyle lightBlackThinTitleText = TextStyle(
    color: lightBlack,
    fontSize: width * 0.07,
    fontWeight: FontWeight.w600,
    fontFamily: 'OpenSans',
  );

  static TextStyle blackThinTitleTextLarge = TextStyle(
    color: Colors.black87.withOpacity(0.8),
    fontSize: width * 0.1,
    fontWeight: FontWeight.w400,
    fontFamily: 'OpenSans',
  );

  static TextStyle blackThinTitleTextSmall = TextStyle(
    color: Colors.black,
    fontSize: width * 0.052,
    fontWeight: FontWeight.w400,
    fontFamily: 'OpenSans',
  );

  static TextStyle lightBlackThinTitleTextSmall = TextStyle(
    color: lightBlack,
    fontSize: width * 0.052,
    fontWeight: FontWeight.w400,
    fontFamily: 'OpenSans',
  );

  static TextStyle blackDescriptionText = TextStyle(
    fontFamily: 'OpenSans',
    color: Colors.black,
    fontSize: width * 0.05,
    fontWeight: FontWeight.w400,
  );

  static TextStyle blackThinDescriptionText = TextStyle(
    fontFamily: 'OpenSans',
    color: Colors.black,
    fontSize: width * 0.05,
    fontWeight: FontWeight.w300,
  );

  static TextStyle greyThinTitleText = TextStyle(
    fontFamily: 'OpenSans',
    color: darkPurpleGrey,
    fontSize: width * 0.07,
    fontWeight: FontWeight.w400,
  );

  static TextStyle greyThinDescriptionText = TextStyle(
    fontFamily: 'OpenSans',
    color: lightGrey,
    fontSize: width * 0.05,
    fontWeight: FontWeight.w400,
  );

  static TextStyle blackThinDescriptionTextSmall = TextStyle(
    color: Colors.black,
    fontSize: width * 0.035,
    fontWeight: FontWeight.w300,
    fontFamily: 'OpenSans',
  );

  static TextStyle darkGreyThinDescriptionTextSmall = TextStyle(
    color: lightBlack,
    fontSize: width * 0.035,
    fontWeight: FontWeight.w400,
    fontFamily: 'OpenSans',
  );

  static TextStyle whiteThinTitleText = TextStyle(
    color: Colors.white,
    fontSize: width * 0.07,
    fontWeight: FontWeight.w600,
    fontFamily: 'OpenSans',
  );

  static TextStyle whiteThinTitleTextSmall = TextStyle(
    color: Colors.white,
    fontSize: width * 0.052,
    fontWeight: FontWeight.w400,
    fontFamily: 'OpenSans',
  );

  static TextStyle greyedOutText =
      new TextStyle(fontWeight: FontWeight.w400, color: Colors.grey);

  static TextStyle greyThinTitleTextSmall = new TextStyle(
    fontFamily: 'OpenSans',
    color: darkPurpleGrey,
    fontSize: width * 0.05,
    fontWeight: FontWeight.w500,
  );

  static TextStyle greyThinDescriptionTextSmall = new TextStyle(
    fontFamily: 'OpenSans',
    color: darkPurpleGrey,
    fontSize: width * 0.035,
    fontWeight: FontWeight.w400,
  );

  static TextStyle lightBlackDescriptionTextSmall = new TextStyle(
    fontFamily: 'OpenSans',
    color: lightBlack,
    fontSize: width * 0.035,
    fontWeight: FontWeight.w400,
  );

  static TextStyle greySubText = new TextStyle(
      fontFamily: 'OpenSans',
      color: lightGrey,
      fontSize: width * 0.03,
      fontWeight: FontWeight.w300);

  static TextStyle blueTitleText = new TextStyle(
    fontFamily: 'OpenSans',
    color: blue,
    fontSize: width * 0.05,
    fontWeight: FontWeight.w600,
  );

  static TextStyle blueTitleTextLarge = new TextStyle(
    fontFamily: 'OpenSans',
    color: blue,
    fontSize: width * 0.06,
    fontWeight: FontWeight.w700,
  );

  static TextStyle blueDescriptionText = new TextStyle(
    fontFamily: 'OpenSans',
    color: blue,
    fontSize: width * 0.04,
    fontWeight: FontWeight.w600,
  );

  static TextStyle yellowDescriptionText = new TextStyle(
    fontFamily: 'OpenSans',
    color: yellow,
    fontSize: width * 0.04,
    fontWeight: FontWeight.w600,
  );

  static TextStyle lightBlackListText = new TextStyle(
      fontSize: width * 0.041,
      color: StyleConstants.lightBlack,
      fontWeight: FontWeight.w600,
      fontFamily: 'OpenSans');

  static TextStyle editTextFieldText = new TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: 'Open Sans',
    fontSize: 18.0,
    color: StyleConstants.lightBlack,
  );

  static TextStyle editTextFieldDescription = new TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: width * 0.04,
      color: StyleConstants.darkGrey
  );

  static TextStyle editTextFieldDescriptionSmall = new TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: width * 0.03,
      color: StyleConstants.darkGrey
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
          offset: Offset(0, 2),
        ),
      ]);

  static BoxDecoration roundWhiteButtonDeco = new BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(30.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 5.0,
          spreadRadius: 2,
          offset: Offset(0, 2),
        ),
      ]);

  static BoxDecoration roundRedButtonDeco = new BoxDecoration(
    color: StyleConstants.red,
    borderRadius: BorderRadius.circular(50.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 6.0,
        //spreadRadius: 2,
        offset: Offset(0, 3),
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
      ]);

  static BoxDecoration lightBlueItemBoxDeco = new BoxDecoration(
    color: StyleConstants.lightBlue,
    borderRadius: BorderRadius.circular(5.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 6.0,
        //spreadRadius: 2,
        offset: Offset(0, 3),
      ),
    ],
  );

  static Color getReminderColor(DateTime date) {
    if (date != null) {
      int difference = date.difference(DateTime.now()).inDays;
      if (difference < 1) {
        return red;
      } else if (difference <= 3) {
        return yellow;
      } else {
        return green;
      }
    } else {
      return green;
    }
  }
}
