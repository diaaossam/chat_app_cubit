import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../helper/size_config.dart';
import 'colors.dart';

ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      color: darkThemeColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: darkThemeColor,
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.white,
      ),
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        backgroundColor: darkThemeColor),
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: darkThemeColor,
    textTheme: TextTheme(
      bodyText1: TextStyle(
          fontFamily: 'Muli',
          color: Colors.white),
    ));
ThemeData lightTheme = ThemeData(
  appBarTheme: AppBarTheme(
    elevation: 0.0,
    color: kPrimaryColor,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: kPrimaryColor,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.white,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  colorScheme:ColorScheme.fromSwatch().copyWith(
    secondary: kPrimaryColor,
    primary: kPrimaryColor
  ),
  scaffoldBackgroundColor: Colors.white,
);

const kAnimationDuration = Duration(milliseconds: 200);
final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);
const defaultDuration = Duration(milliseconds: 250);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}