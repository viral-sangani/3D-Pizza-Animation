import 'package:coding_challenge_2021/constants.dart';
import 'package:coding_challenge_2021/home_screen.dart';
import 'package:flutter/material.dart';

class Ingridient extends StatelessWidget {
  final Ingridients path;
  const Ingridient({Key key, this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable<Ingridients>(
      data: path,
      child: Image(
        image: AssetImage(getIngridientsPath(path)),
        height: 50,
        width: 50,
      ),
      feedback: Image(
        image: AssetImage(getIngridientsPath(path)),
        height: 50,
        width: 50,
      ),
      childWhenDragging: Container(),
    );
  }

  getIngridientsPath(Ingridients ingridient) {
    if (ingridient == Ingridients.BASIL)
      return Constants.BASIL[0];
    else if (ingridient == Ingridients.BROCCOLI)
      return Constants.BROCCOLI[0];
    else if (ingridient == Ingridients.MASHROOM)
      return Constants.MASHROOM[5];
    else if (ingridient == Ingridients.ONION)
      return Constants.ONION[0];
    else if (ingridient == Ingridients.SAUSAGE) return Constants.SAUSAGE[0];
  }
}
