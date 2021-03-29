import 'package:flutter/material.dart';

const Color KPrimaryColor = Color(0xFFF5F6F8);
const Color KScandaryColor = Color(0xFF445969);
const Color KAccentColor = Color(0xFFFFCC30);
const String KFontFamily = 'Tajawal';

ThemeData themeData = ThemeData(
  primaryColor: KPrimaryColor,
  accentColor: KAccentColor,
  backgroundColor: KScandaryColor,
  fontFamily: KFontFamily,
  textTheme: TextTheme(
    headline1: headline1,
    headline2: headline2,
    headline3: headline3,
    headline4: headline4,
    subtitle1: subtitle1,
  ),
  buttonTheme: ButtonThemeData(minWidth: double.maxFinite),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(KAccentColor),
      elevation: MaterialStateProperty.all<double>(2),
      textStyle: MaterialStateProperty.all<TextStyle>(headline3),
      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(70),
        ),
      ),
    ),
  ),
);


extension H on String{
  Widget get h1 => Text(this,style: headline1,);
}



TextStyle headline1 = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.bold,
  fontStyle: FontStyle.normal,
);
TextStyle headline2 = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  fontStyle: FontStyle.normal,
);
TextStyle headline3 = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    fontFamily: KFontFamily);
TextStyle headline4 = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
    fontFamily: KFontFamily);
TextStyle headline5 = TextStyle(
  
);
TextStyle headline6 = TextStyle();

TextStyle subtitle1 = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.normal,
);
