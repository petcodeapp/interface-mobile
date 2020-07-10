import 'package:flutter/material.dart';

class StyleConstants{
  static Color darkGrey = new Color(0xff66615B);

  static Color lightBlue = new Color(0xff51CBCE);

  static Color blue = new Color(0xff51BCDA);

  static Color green = new Color(0xff6BD098);

  static Color red = new Color(0xffF5593D);

  static Color white = new Color(0xffFFFFFF);

  static Color yellow = new Color(0xffFBC658);

  static BoxDecoration roundYellowButtonDeco = new BoxDecoration(
      color: yellow,
      borderRadius: BorderRadius.circular(30.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 6.0,
          offset: Offset(0,2),
        )
      ]
  );
  static BoxDecoration roundWhiteButtonDeco = new BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(30.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 6.0,
          offset: Offset(0,2),
        )
      ]
  );
}