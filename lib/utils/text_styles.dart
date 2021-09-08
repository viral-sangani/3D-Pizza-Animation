import 'package:coding_challenge_2021/services/size_config.dart';
import 'package:coding_challenge_2021/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTextStyles {
  static TextStyle orderPizza({int size = 40}) => TextStyle(
        fontFamily: "AllertaStencil",
        fontSize: 40,
        color: ColorConstants.purple,
        // fontWeight: FontWeight.w700,
      );

  static TextStyle pizza({int size = 40}) => TextStyle(
        fontFamily: "AllertaStencil",
        fontSize: 20,
        color: ColorConstants.white,
        // fontWeight: FontWeight.w700,
      );

  static TextStyle pizzaName({int size = 40}) => TextStyle(
        fontFamily: "AllertaStencil",
        fontSize: 30,
        color: ColorConstants.purple,
        // fontWeight: FontWeight.w700,
      );

  static TextStyle priceStyle({int size = 40}) => TextStyle(
        color: ColorConstants.purple,
        fontSize: size.toFont,
        letterSpacing: 3,
        fontWeight: FontWeight.bold,
        fontFamily: "AbrilFatface",
      );

  static TextStyle pizzaSauceTextStyle({
    int size = 16,
    color: Colors.brown,
  }) =>
      TextStyle(
        color: color,
        fontSize: size.toFont,
        letterSpacing: 0.1,
        fontWeight: FontWeight.bold,
      );

  static TextStyle buyNowTextStyle({int size = 16}) => TextStyle(
        color: ColorConstants.white,
        fontSize: size.toFont,
        letterSpacing: 0.1,
        fontWeight: FontWeight.bold,
      );

  static TextStyle chooseSauceTypeTextStyle({int size = 16}) => TextStyle(
        color: ColorConstants.black,
        fontSize: size.toFont,
        letterSpacing: 0.1,
        fontWeight: FontWeight.bold,
      );

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
