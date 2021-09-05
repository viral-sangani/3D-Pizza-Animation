import 'dart:async';

import 'package:coding_challenge_2021/utils/constants.dart';
import 'package:flutter/material.dart';

class PizzaViewModel extends ChangeNotifier {
  double pizzaPrice = 15;
  late AnimationController pizzaAnimationController;
  late Animation<double> pizzaXVal;
  late bool scaleAnimateForward = false;
  late bool scaleAnimateReverse = false;

  SauceType sauceType = SauceType.Plain;

  incPizzaPrice() {
    pizzaPrice++;
    notifyListeners();
  }

  decPizzaPrice() {
    pizzaPrice--;
    notifyListeners();
  }

  setSauceType(SauceType type) {
    sauceType = type;
    notifyListeners();
  }

  getSauceType() {
    if (sauceType == SauceType.Plain)
      return Constants.BREADS[0];
    else if (sauceType == SauceType.PepperyRed)
      return Constants.BREADS[2];
    else if (sauceType == SauceType.TraditionalTomato)
      return Constants.BREADS[1];
    else if (sauceType == SauceType.SpicyRed)
      return Constants.BREADS[3];
    else if (sauceType == SauceType.None) return Constants.BREADS[4];
  }

  animateForward() {
    scaleAnimateForward = true;
    notifyListeners();
    Timer(Duration(milliseconds: 500), () {
      scaleAnimateForward = false;
    });
  }

  animateRev() {
    scaleAnimateReverse = true;
    notifyListeners();
    Timer(Duration(milliseconds: 500), () {
      scaleAnimateReverse = false;
    });
  }
}

enum SauceType {
  Plain,
  PepperyRed,
  TraditionalTomato,
  SpicyRed,
  None,
}
