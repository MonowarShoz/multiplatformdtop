import 'package:flutter/material.dart';

class MenuModel {
  String? menuName;
  Widget? routeName;
  Color? imgColor;
  Color? color;
  IconData? iconData;
  String? icon;
  MenuModel({
    this.routeName,
    this.iconData,
    this.color,
    this.imgColor,
    this.icon,
    required this.menuName,
  });
}
