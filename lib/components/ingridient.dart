import 'package:coding_challenge_2021/screens/diy_pizza_screen.dart';
import 'package:coding_challenge_2021/services/size_config.dart';
import 'package:coding_challenge_2021/utils/constants.dart';
import 'package:flutter/material.dart';

class Ingridient extends StatelessWidget {
  final Ingridients path;
  const Ingridient({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable<Ingridients>(
      data: path,
      child: Image(
        image: AssetImage(getIngridientsPath(path)),
        height: 50.toHeight,
        width: 50.toWidth,
      ),
      feedback: Image(
        image: AssetImage(getIngridientsPath(path)),
        height: 50.toHeight,
        width: 50.toWidth,
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
