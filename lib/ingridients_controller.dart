import 'package:coding_challenge_2021/home_screen.dart';
import 'package:flutter/material.dart';

class IngridientsController extends ChangeNotifier {
  List<Ingridients> ingridients = [];

  addIngridient(Ingridients ingridient) {
    if (ingridients.indexOf(ingridient) == -1) {
      ingridients.add(ingridient);
      notifyListeners();
    }
  }

  removeIngridient(int index) {
    ingridients.removeAt(index);
    notifyListeners();
  }
}
