import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  static Color darkGrey = new Color(0xff66615B);

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

  static Color lightBlack = new Color(0xff2D3748);

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
        fontSize: width * 0.06,
      ));

  static TextStyle yellowButtonText = GoogleFonts.getFont('Open Sans',
      textStyle: TextStyle(
        color: yellow,
        fontSize: width * 0.06,
      ));

  static TextStyle whiteTitleText = GoogleFonts.getFont('Open Sans',
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: width * 0.07,
      ));

  static TextStyle whiteTitleTextLarge = GoogleFonts.getFont('Open Sans',
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: width * 0.1,
      ));

  static TextStyle whiteTitleTextSmall = GoogleFonts.getFont('Open Sans',
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: width * 0.06,
      ));

  static TextStyle whiteTitleTextXS = GoogleFonts.getFont('Open Sans',
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: width * 0.05,
      ));

  static TextStyle whiteTitleTextXL = GoogleFonts.getFont('Open Sans',
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: width * 0.12,
      ));

  static TextStyle whiteDescriptionText = new TextStyle(
    color: Colors.white,
    fontSize: width * 0.05,
    fontWeight: FontWeight.w400,
  );

  static TextStyle whiteDescriptionTextSmall = new TextStyle(
    color: Colors.white,
    fontSize: width * 0.035,
    fontWeight: FontWeight.w400,
  );

  static TextStyle whiteDescriptionTextXS = new TextStyle(
    color: Colors.white,
    fontSize: width * 0.021,
    fontWeight: FontWeight.w400,
  );

  static TextStyle whiteThinTitleTextLarge = new TextStyle(
    color: Colors.white,
    fontSize: width * 0.1,
    fontWeight: FontWeight.w400,
  );

  static TextStyle blackTitleText = TextStyle(
    color: Colors.black,
    fontSize: width * 0.06,
    fontWeight: FontWeight.w800,
  );

  static TextStyle blackTitleTextLarge = GoogleFonts.getFont('Open Sans',
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: width * 0.1,
      ));

  static TextStyle blackTitleTextSmall = GoogleFonts.getFont('Open Sans',
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: width * 0.06,
      ));

  static TextStyle blackTitleTextXS = GoogleFonts.getFont('Open Sans',
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: width * 0.05,
      ));

  static TextStyle blackTitleTextXL = GoogleFonts.getFont('Open Sans',
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: width * 0.12,
      ));

  static TextStyle blackThinTitleText = GoogleFonts.getFont(
    'Open Sans',
    textStyle: TextStyle(
      color: Colors.black,
      fontSize: width * 0.07,
      fontWeight: FontWeight.w600,
    ));

  static TextStyle blackThinTitleTextMedium = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: width * 0.06,
        fontWeight: FontWeight.w600,
      ));


  static TextStyle blackThinTitleTextXS = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: width * 0.04,
        fontWeight: FontWeight.w400,
      ));
  static TextStyle darkBlackDescriptionText = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
          fontSize: width * 0.041,
          fontWeight: FontWeight.w500,
          color: Colors.black.withOpacity(0.8)
      ));

  static TextStyle tinyGreyDescriptionText = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
        fontSize: width * 0.035,
        fontWeight: FontWeight.w400,
        color: darkPurpleGrey,
      ));

  static TextStyle lightBlackThinTitleText = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
        color: lightBlack,
        fontSize: width * 0.07,
        fontWeight: FontWeight.w600,
      ));


  static TextStyle blackThinTitleTextLarge = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
        color: Colors.black87.withOpacity(0.8),
        fontSize: width * 0.1,
        fontWeight: FontWeight.w400,
      ));


  static TextStyle blackThinTitleTextSmall = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: width * 0.052,
        fontWeight: FontWeight.w400,
      ));



  static TextStyle lightBlackThinTitleTextSmall = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
        color: lightBlack,
        fontSize: width * 0.052,
        fontWeight: FontWeight.w400,
      ));


  static TextStyle blackDescriptionText = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: width * 0.05,
        fontWeight: FontWeight.w400,
      ));



  static TextStyle blackThinDescriptionText = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: width * 0.05,
        fontWeight: FontWeight.w300,
      ));


  static TextStyle greyThinTitleText = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
        color: darkPurpleGrey,
        fontSize: width * 0.07,
        fontWeight: FontWeight.w400,
      ));



  static TextStyle greyThinDescriptionText = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
        color: lightGrey,
        fontSize: width * 0.05,
        fontWeight: FontWeight.w400,
      ));



  static TextStyle blackThinDescriptionTextSmall = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: width * 0.035,
        fontWeight: FontWeight.w300,
      ));



  static TextStyle darkGreyThinDescriptionTextSmall = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
        color: lightBlack,
        fontSize: width * 0.035,
        fontWeight: FontWeight.w400,
      ));


  static TextStyle whiteThinTitleText = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: width * 0.07,
        fontWeight: FontWeight.w600,
      ));



  static TextStyle whiteThinTitleTextSmall = GoogleFonts.getFont(
      'Open Sans',
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: width * 0.052,
        fontWeight: FontWeight.w400,
      ));



  static TextStyle greyedOutText =
      new TextStyle(fontWeight: FontWeight.w400, color: Colors.grey);

  static TextStyle greyThinTitleTextSmall = new TextStyle(
    color: darkPurpleGrey,
    fontSize: width * 0.05,
    fontWeight: FontWeight.w500,
  );

  static TextStyle greyThinDescriptionTextSmall = new TextStyle(
    color: darkPurpleGrey,
    fontSize: width * 0.035,
    fontWeight: FontWeight.w400,
  );

  static TextStyle lightBlackDescriptionTextSmall = new TextStyle(
    color: lightBlack,
    fontSize: width * 0.035,
    fontWeight: FontWeight.w400,
  );

  static TextStyle greySubText = new TextStyle(
      color: lightGrey, fontSize: width * 0.03, fontWeight: FontWeight.w300);

  static TextStyle blueTitleText = new TextStyle(
    color: blue,
    fontSize: width * 0.05,
    fontWeight: FontWeight.w600,
  );

  static TextStyle blueTitleTextLarge = new TextStyle(
    color: blue,
    fontSize: width * 0.06,
    fontWeight: FontWeight.w700,
  );

  static TextStyle blueDescriptionText = new TextStyle(
    color: blue,
    fontSize: width * 0.04,
    fontWeight: FontWeight.w600,
  );

  static TextStyle yellowDescriptionText = new TextStyle(
    color: yellow,
    fontSize: width * 0.04,
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
