import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Themes {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.blue,
      backgroundColor: Colors.grey.shade100,
      colorScheme: ColorScheme.light(
        primary: Colors.blue,
        onPrimary: Colors.white,
      ),
      textTheme: const TextTheme(
        headline1: TextStyle(
            fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white),
        headline2: TextStyle(
            fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.black),
        headline3: TextStyle(
            fontSize: 23.0, fontWeight: FontWeight.bold, color: Colors.black),
        headline6: TextStyle(
            fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
        bodyText1: TextStyle(color: Colors.black),
        bodyText2: TextStyle(color: Colors.white),
        subtitle1: TextStyle(color: Colors.black),
        subtitle2: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      iconTheme: IconThemeData(color: Colors.blue),
      cardColor: Colors.white,
      splashColor: Colors.cyan,
      shadowColor: Colors.grey,
      hintColor: Colors.grey,
      indicatorColor: Colors.red,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Color.fromRGBO(20, 21, 24, 1),
      backgroundColor: Color.fromRGBO(20, 21, 24, 1),
      colorScheme: ColorScheme.light(
        primary: Color.fromRGBO(20, 21, 24, 1),
        onPrimary: Colors.white,
      ),
      textTheme: const TextTheme(
        headline1: TextStyle(
            fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white),
        headline2: TextStyle(
            fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white),
        headline3: TextStyle(
            fontSize: 23.0, fontWeight: FontWeight.bold, color: Colors.white),
        headline6: TextStyle(
            fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold),
        bodyText1: TextStyle(color: Colors.white),
        bodyText2: TextStyle(color: Colors.white),
        subtitle1: TextStyle(color: Colors.white),
        subtitle2: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      iconTheme: IconThemeData(color: Colors.grey.shade400),
      cardColor: Color.fromRGBO(34, 35, 40, 1),
      splashColor: Color.fromRGBO(20, 21, 24, 1),
      shadowColor: Color.fromRGBO(20, 21, 24, 1),
      hintColor: Colors.grey,
      indicatorColor: Colors.red,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
    );
  }
}
