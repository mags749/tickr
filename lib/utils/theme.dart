import 'package:flutter/material.dart';

import 'hex_color.dart';

var darkTextStyle = TextStyle(color: HexColor('#EEEEEE'));

ThemeData darkTheme = ThemeData(
  accentColor: HexColor('#FB6563'),
  appBarTheme: AppBarTheme(elevation: 0),
  backgroundColor: HexColor('#70D1ED'),
  brightness: Brightness.dark,
  errorColor: HexColor('#e76f51'),
  // fontFamily: GoogleFonts.play().fontFamily,
  primaryColor: HexColor('#26372F'),
  scaffoldBackgroundColor: HexColor("#26372F"),
  textTheme: TextTheme(
    bodyText1: darkTextStyle,
    bodyText2: darkTextStyle,
    button: darkTextStyle,
    caption: darkTextStyle,
    headline4: darkTextStyle,
  ),
);
