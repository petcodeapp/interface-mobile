import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyleConstants {
  //colors
  static Color darkGrey = new Color(0xff66615B);

  static Color lightBlue = new Color(0xff51CBCE);

  static Color blue = new Color(0xff51BCDA);

  static Color green = new Color(0xff6BD098);

  static Color red = new Color(0xffF5593D);

  static Color white = new Color(0xffFFFFFF);

  static Color yellow = new Color(0xffFBC658);

  static Color lightGrey = new Color(0xffB4C1CF);

  static Color veryLightGrey = new Color(0xffEEF2F7);

  static Color purpleGrey = new Color(0xffEDF2F7);

  static Color darkPurpleGrey = new Color(0xffA0AEC0);

  static Color lightBlack = new Color(0xff718096);

  static Color pageBackgroundColor = new Color(0xffEEF2F6);

  static LinearGradient bgGradient = new LinearGradient(
    begin: Alignment.topRight,
    //end: Alignment(0.01, 0.01),
    end: Alignment.centerLeft,
    stops: [0.05, 0.25, 0.7],
    colors: [const Color(0xffB3E1EE), const Color(0xff7cdcf7), StyleConstants.blue], // whitish to gray
    //tileMode: TileMode.repeated,
  );

  //text styles
  static TextStyle whiteButtonText = GoogleFonts.getFont('Open Sans',
      textStyle: TextStyle(
        color: white,
        fontSize: 25.0,
      ));

  static TextStyle yellowButtonText = GoogleFonts.getFont('Open Sans',
      textStyle: TextStyle(
        color: yellow,
        fontSize: 25.0,
      ));

  static TextStyle whiteTitleText = GoogleFonts.getFont('Open Sans',
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: 30.0,
      ));

  static TextStyle whiteTitleTextLarge = GoogleFonts.getFont('Open Sans',
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: 40.0,
      ));

  static TextStyle whiteTitleTextSmall = GoogleFonts.getFont('Open Sans',
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: 25.0,
      ));

  static TextStyle whiteTitleTextXS = GoogleFonts.getFont('Open Sans',
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ));

  static TextStyle whiteTitleTextXL = GoogleFonts.getFont('Open Sans',
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: 50.0,
      ));

  static TextStyle whiteDescriptionText = new TextStyle(
    color: Colors.white,
    fontSize: 20.0,
    fontWeight: FontWeight.w400,
  );

  static TextStyle whiteDescriptionTextSmall = new TextStyle(
    color: Colors.white,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  );

  static TextStyle whiteDescriptionTextXS = new TextStyle(
    color: Colors.white,
    fontSize: 10.0,
    fontWeight: FontWeight.w400,
  );

  static TextStyle whiteThinTitleTextLarge = new TextStyle(
    color: Colors.white,
    fontSize: 40.0,
    fontWeight: FontWeight.w400,
  );

  static TextStyle blackTitleText = TextStyle(
    color: Colors.black,
    fontSize: 26.0,
    fontWeight: FontWeight.w800,
  );

  static TextStyle blackTitleTextLarge = GoogleFonts.getFont('Open Sans',
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: 40.0,
      ));

  static TextStyle blackTitleTextSmall = GoogleFonts.getFont('Open Sans',
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: 25.0,
      ));

  static TextStyle blackTitleTextXS = GoogleFonts.getFont('Open Sans',
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
      ));

  static TextStyle blackTitleTextXL = GoogleFonts.getFont('Open Sans',
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: 50.0,
      ));

  static TextStyle blackThinTitleText = GoogleFonts.getFont(
    'Open Sans',
    textStyle: TextStyle(
      color: Colors.black,
      fontSize: 30.0,
      fontWeight: FontWeight.w600,
    ));

  static TextStyle blackThinTitleTextMedium = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: 25.0,
        fontWeight: FontWeight.w600,
      ));



  static TextStyle blackThinTitleTextXS = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
      ));

  static TextStyle darkBlackDescriptionText = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: Colors.black.withOpacity(0.8)
      ));

  static TextStyle tinyGreyDescriptionText = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: darkPurpleGrey,
      ));

  static TextStyle lightBlackThinTitleText = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
        color: lightBlack,
        fontSize: 30.0,
        fontWeight: FontWeight.w600,
      ));


  static TextStyle blackThinTitleTextLarge = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
        color: Colors.black87.withOpacity(0.8),
        fontSize: 40.0,
        fontWeight: FontWeight.w400,
      ));


  static TextStyle blackThinTitleTextSmall = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: 22.0,
        fontWeight: FontWeight.w400,
      ));



  static TextStyle lightBlackThinTitleTextSmall = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
        color: lightBlack,
        fontSize: 22.0,
        fontWeight: FontWeight.w400,
      ));


  static TextStyle blackDescriptionText = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.w400,
      ));



  static TextStyle blackThinDescriptionText = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.w300,
      ));


  static TextStyle greyThinTitleText = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
        color: darkPurpleGrey,
        fontSize: 30.0,
        fontWeight: FontWeight.w400,
      ));



  static TextStyle greyThinDescriptionText = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
        color: lightGrey,
        fontSize: 20.0,
        fontWeight: FontWeight.w400,
      ));



  static TextStyle blackThinDescriptionTextSmall = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: 14.0,
        fontWeight: FontWeight.w300,
      ));



  static TextStyle darkGreyThinDescriptionTextSmall = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
        color: lightBlack,
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
      ));



  static TextStyle whiteThinTitleText = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: 30.0,
        fontWeight: FontWeight.w600,
      ));



  static TextStyle whiteThinTitleTextSmall = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: 22.0,
        fontWeight: FontWeight.w400,
      ));



  static TextStyle greyedOutText =
      new TextStyle(fontWeight: FontWeight.w400, color: Colors.grey);

  static TextStyle greyThinTitleTextSmall = new TextStyle(
    color: darkPurpleGrey,
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
  );

  static TextStyle greyThinDescriptionTextSmall = new TextStyle(
    color: darkPurpleGrey,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  );

  static TextStyle lightBlackDescriptionTextSmall = new TextStyle(
    color: lightBlack,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  );

  static TextStyle greySubText = new TextStyle(
    color: lightGrey,
    fontSize: 12.0,
    fontWeight: FontWeight.w300
  );

  static TextStyle blueTitleText = new TextStyle(
    color: blue,
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
  );

  static TextStyle yellowDescriptionText = new TextStyle(
    color: yellow,
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
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
}
