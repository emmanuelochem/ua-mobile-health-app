import 'package:flutter/material.dart';

class UIColors {
  UIColors._();

  static Color transparent = const Color(0x00000000);
  static Color white = const Color(0xFFFFFFFF);
  static Color black = const Color(0xFF000000);

  //Primary (Purple variant)
  static Color primary = const Color(0xFF339557);
  static Color primary100 = const Color.fromRGBO(10, 176, 123, 1);
  static Color primary200 = const Color.fromRGBO(10, 176, 123, .8);
  static Color primary300 = const Color.fromRGBO(10, 176, 123, .6);
  static Color primary400 = const Color.fromRGBO(10, 176, 123, .4);
  static Color primary500 = const Color.fromRGBO(10, 176, 123, .2);
  static Color primaryDarkest = const Color(0xFF0e8b63);
  //#0e8b63
  //static Color primaryDarkest = const Color(0xFF05643E);

  //Neutral (Grey variant)
  static Color secondary = const Color(0xFF322F2f);
  static Color secondary100 = const Color(0xFF322F2f);
  static Color secondary200 = const Color(0xFF505060);
  static Color secondary300 = const Color(0xFF9292A0);
  static Color secondary400 = const Color(0xFFC8C8D7);
  static Color secondary500 = const Color(0xFFEDEDF3);
  static Color secondary600 = const Color(0xFFF5F5FF);
}
