import 'package:flutter/material.dart';

Color appColor = Colors.blue[900]!;

ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        titleSpacing: 20.0,
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          // fontFamily: appFont,
        ),
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        textTheme: TextTheme(
            bodyText1: TextStyle(
                // fontFamily: appFont
            )
        )
    ),
    // fontFamily: appFont
);