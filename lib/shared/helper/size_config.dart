import 'package:flutter/material.dart';

class SizeConfig {
  late MediaQueryData mediaQueryData;
  static late double screenWidth;
  late double statusBarHeight;
  late double appBarHeight;
  static late double bodyHeight;

  /*static double? defaultSize;
  static Orientation? orientation;*/

  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    statusBarHeight = mediaQueryData.padding.top;
    appBarHeight = AppBar().preferredSize.height;
    bodyHeight = mediaQueryData.size.height - statusBarHeight - appBarHeight;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.bodyHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}
