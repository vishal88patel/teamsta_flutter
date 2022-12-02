import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teamsta/constants/colors.dart';


final ThemeData appThemeData = ThemeData(
  fontFamily: GoogleFonts.baloo2().fontFamily,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme(
    primary: customPurple,
    error: Colors.red,
    onPrimary: Colors.white,
    secondary: Colors.white,
    onSecondary: Colors.white,
    brightness: Brightness.light,
    onError: Colors.red,
    background: Colors.white,
    onBackground: Colors.white,
    surface: Colors.amber,
    onSurface: Colors.amber,
  ),
  //* AppBar
  appBarTheme: AppBarTheme(
      color: customOrange,
      elevation: 0,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData()),
  textTheme: TextTheme(
    //* Large Blue
    headline1: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w900,
      color: customPurple,
    ),
    //* Medium Blue
    headline2: TextStyle(
        fontSize: 18, fontWeight: FontWeight.bold, color: customPurple),
    //* Small Blue
    headline3: TextStyle(
        fontSize: 15, fontWeight: FontWeight.normal, color: customPurple),
    //* Large White
    headline4: TextStyle(
        color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
    //* Medium White
    headline5: TextStyle(
        color: Colors.white, fontSize: 18, fontWeight: FontWeight.normal),
  ),
  iconTheme: IconThemeData(color: customPurple),

  //* Elevated buttons
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: customPurple,
      minimumSize: Size(double.infinity, 40),
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
  //* text form field
  inputDecorationTheme: InputDecorationTheme(
      border: InputBorder.none,
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      errorStyle: TextStyle(color: customPurple)),
  //* text button theme
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: Colors.white,
    ),
  ),
  //* checkbox theme
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
    side: BorderSide(color: Colors.white),
    fillColor: MaterialStateProperty.all(Colors.white),
    checkColor: MaterialStateProperty.all(customPurple),
  ),
  //* tab bar theme
  tabBarTheme: TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    labelColor: Colors.white,
    unselectedLabelColor: customPurple,
    labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    unselectedLabelStyle:
        TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
  ),
);



