import 'package:coding_challenge_2021/services/size_config.dart';
import 'package:coding_challenge_2021/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTextStyles {
  static TextStyle white({int size = 16}) => TextStyle(
      color: ColorConstants.white,
      fontSize: size.toFont,
      letterSpacing: 0.1,
      fontWeight: FontWeight.normal);

  static TextStyle whiteBold({int size = 16}) => TextStyle(
      color: ColorConstants.white,
      fontSize: size.toFont,
      letterSpacing: 0.1,
      fontWeight: FontWeight.bold);

  static TextStyle black({int size = 16}) => TextStyle(
      color: ColorConstants.black,
      fontSize: size.toFont,
      letterSpacing: 0.1,
      fontWeight: FontWeight.normal);

  static TextStyle blackBold({int size = 16}) => TextStyle(
      color: ColorConstants.black,
      fontSize: size.toFont,
      letterSpacing: 0.1,
      fontWeight: FontWeight.bold);

  static TextStyle customTextStyle(Color color, {int size = 16}) => TextStyle(
      color: color,
      fontSize: size.toFont,
      letterSpacing: 0.1,
      fontWeight: FontWeight.normal);

  static TextStyle customBoldTextStyle(Color color, {int size = 16}) =>
      TextStyle(
          color: color,
          fontSize: size.toFont,
          letterSpacing: 0.1,
          fontWeight: FontWeight.bold);
}
