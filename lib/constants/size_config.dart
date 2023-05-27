import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppConfig {
  BuildContext context;
  double height = 50;
  double width = 50;
  AppConfig(this.context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
  }
}

double kDefaultPadding = 5 * SizeConfig.widthMultiplier;
  double kBorderRadius = 12;
class SizeConfig {
  static double _screenWidth = 0;
  static double _screenHeight = 0;
  static double _blockWidth = 0;
  static double _blockHeight = 0;

  static double textMultiplier = 0;
  static double imageSizeMultiplier = 0;
  static double heightMultiplier = 0;
  static double widthMultiplier = 0;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  

  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      isPortrait = true;
      if (_screenWidth < 450) {
        isMobilePortrait = true;
      }
    } else {
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;
      isPortrait = false;
      isMobilePortrait = false;
    }

    _blockWidth = _screenWidth / 100;
    _blockHeight = _screenHeight / 100;

    textMultiplier = _blockHeight;
    imageSizeMultiplier = _blockWidth;
    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;
  }
}
// 'Pastries \u00B7 Phoenix,AZ'