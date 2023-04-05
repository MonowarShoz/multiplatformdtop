// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

List<Color> colorList = [
  const Color(0xff003f5c),
  const Color(0xff374c80),
  const Color(0xff7a5195),
  const Color(0xffbc5090),
  const Color(0xffef5675),
  const Color(0xffff764a),
  const Color(0xffffa600),
];

class ColorResources {
  // static Color getBlue(BuildContext context) {
  //   return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF007ca3) : const Color(0xFF00ADE3);
  // }

  // static Color getColombiaBlue(BuildContext context) {
  //   return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF678cb5) : const Color(0xFF92C6FF);
  // }

  // static Color getLightSkyBlue(BuildContext context) {
  //   return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFc7c7c7) : const Color(0xFF8DBFF6);
  // }

  // static Color getHarlequin(BuildContext context) {
  //   return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF257800) : const Color(0xFF3FCC01);
  // }

  // static Color getCheris(BuildContext context) {
  //   return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF941546) : const Color(0xFFE2206B);
  // }

  // static Color getGrey(BuildContext context) {
  //   return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF8B8484) : const Color(0xFFF1F1F1);
  // }

  // static Color getRed(BuildContext context) {
  //   return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF7a1c1c) : const Color(0xFFD32F2F);
  // }

  // static Color getYellow(BuildContext context) {
  //   return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF916129) : const Color(0xFFFFAA47);
  // }

  // static Color getHint(BuildContext context) {
  //   return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFc7c7c7) : const Color(0xFF9E9E9E);
  // }

  // static Color getGainsBoro(BuildContext context) {
  //   return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF999999) : const Color(0xFFE6E6E6);
  // }

  // static Color getTextBg(BuildContext context) {
  //   return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF414345) : const Color(0x00ffffff);
  // }

  // static Color getIconBg(BuildContext context) {
  //   return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF2e2e2e) : const Color(0xFFF9F9F9);
  // }

  // static Color getHomeBg(BuildContext context) {
  //   return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF3d3d3d) : const Color(0xFFF0F0F0);
  // }

  // static Color getImageBg(BuildContext context) {
  //   return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF3f4347) : const Color(0xFFE2F0FF);
  // }

  // static Color getSellerTxt(BuildContext context) {
  //   return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF517091) : const Color(0xFF92C6FF);
  // }

  // static Color getChatIcon(BuildContext context) {
  //   return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFebebeb) : const Color(0xFFD4D4D4);
  // }

  // static Color getLowGreen(BuildContext context) {
  //   return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF7d8085) : const Color(0xFFEFF6FE);
  // }

  // static Color getGreen(BuildContext context) {
  //   return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF167d3c) : const Color(0xFF23CB60);
  // }

  // static Color getFloatingBtn(BuildContext context) {
  //   return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF49698c) : const Color(0xFF7DB6F5);
  // }

  // static Color getPrimary(BuildContext context) {
  //   return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFf0f0f0) : const Color.fromARGB(255, 59, 74, 206);
  // }

  static const Color background = Color(0XFFfefefe);

  static const Color titleTextColor = Color(0xff1b1718);
  static const Color subTitleTextColor = Color(0xffb9bfcd);

  static const Color skyBlue = Color(0xff71b4fb);
  static const Color lightBlue = Color(0xff7fbcfb);
  static const Color extraLightBlue = Color(0xffd9eeff);

  static const Color orange = Color(0xfffa8c73);
  static const Color lightOrange = Color(0xfffa9881);

  static const Color purple = Color(0xff8873f4);
  static const Color purpleLight = Color(0xff9489f4);
  static const Color purpleExtraLight = Color(0xffb1a5f6);

  static const Color grey = Color(0xffb8bfce);

  static const Color iconColor = Color(0xffcbd0db);
  static const Color green = Color(0xff4cd1bc);
  static const Color lightGreen = Color(0xff5ed6c3);

  static const Color black = Color(0xff20262C);
  static const Color lightblack = Color(0xff5F5F60);

  static const Color jam = Color(0xff900C3F);
  static const Color jamLight = Color(0xff8E3356);

  static const Color red = Color(0xffC70039);
  static const Color redLight = Color(0xffC6315B);

  static const Color pumpkin = Color(0xffFF8D1A);
  static const Color pumpkinLight = Color(0xffFF9730);

  static const Color poppy = Color(0xffFFC300);
  static const Color poppyLight = Color(0xffE5B524);

  static const Color emerald = Color(0xff57C785);
  static const Color emeraldLight = Color(0xff5DBA82);

  static const Color lochmara = Color(0xff2A7B9B);
  static const Color lochmaraLight = Color(0xff4F899E);

  static const Color pompadour = Color(0xff511849);
  static const Color pompadourLight = Color(0xff4F2048);

  static const Map<int, Color> colorMap = {
    50: Color(0x10192D6B),
    100: Color(0x20192D6B),
    200: Color(0x30192D6B),
    300: Color(0x40192D6B),
    400: Color(0x50192D6B),
    500: Color(0x60192D6B),
    600: Color(0x70192D6B),
    700: Color(0x80192D6B),
    800: Color(0x90192D6B),
    900: Color(0xff192D6B),
  };

  static const MaterialColor PRIMARY_MATERIAL = MaterialColor(0xFF192D6B, colorMap);

  static const List<Color> zoneColorList = [
    skyBlue,
    orange,
    purple,
    green,
    jam,
    red,
    pumpkin,
    poppy,
    emerald,
    lochmara,
    pompadour,
    skyBlue,
    orange,
    purple,
    green,
    jam,
    red,
    pumpkin,
    poppy,
    emerald,
    lochmara,
    pompadour
  ];
  static const List<Color> zoneColorListLight = [
    lightBlue,
    lightOrange,
    purpleLight,
    lightGreen,
    jamLight,
    redLight,
    pumpkinLight,
    poppyLight,
    emeraldLight,
    lochmaraLight,
    pompadourLight,
    lightBlue,
    lightOrange,
    purpleLight,
    lightGreen,
    jamLight,
    redLight,
    pumpkinLight,
    poppyLight,
    emeraldLight,
    lochmaraLight,
    pompadourLight
  ];
}
