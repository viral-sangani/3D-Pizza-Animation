import 'package:coding_challenge_2021/components/pizza_topping.dart';
import 'package:coding_challenge_2021/constants.dart';
import 'package:coding_challenge_2021/home_screen.dart';
import 'package:coding_challenge_2021/ingridients_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Pizza extends StatefulWidget {
  final Animation<double> scale;
  final AnimationController controller;
  final List<Ingridients> ingridientsList;
  final Function setIngridients;
  const Pizza({
    Key key,
    this.scale,
    this.controller,
    this.ingridientsList,
    this.setIngridients,
  }) : super(key: key);

  @override
  _PizzaState createState() => _PizzaState();
}

class _PizzaState extends State<Pizza> {
  bool hasMovedIn = false;
  @override
  Widget build(BuildContext context) {
    final ingridientsProvider =
        Provider.of<IngridientsController>(context, listen: true);
    var pizzaSize =
        MediaQuery.of(context).size.width / 2 - Constants.PIZZAPADDING - 25;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: DragTarget<Ingridients>(
        builder: (ctx, candidate, ejects) {
          return ScaleTransition(
            scale: widget.scale,
            child: Stack(children: [
              Image.asset(Constants.BREADS[0]),
              if (ingridientsProvider.ingridients != null &&
                  ingridientsProvider.ingridients.length > 0)
                for (int i = 0; i < ingridientsProvider.ingridients.length; i++)
                  for (int x = 0; x < 10; x++)
                    PizzaToppingItem(
                      index: x,
                      ingridentIndex: i,
                      path: getIngridientsBasePath(
                        ingridientsProvider.ingridients[i],
                        x,
                      ),
                      pizzaSize: pizzaSize,
                    )
            ]),
          );
        },
        onAccept: (ingridient) {
          setState(() {
            hasMovedIn = false;
          });
          ingridientsProvider.addIngridient(ingridient);
          widget.controller.reverse();
        },
        onMove: (ingridient) {
          if (!hasMovedIn) {
            widget.controller.forward();
            setState(() {
              hasMovedIn = true;
            });
          }
        },
        onLeave: (ingridient) {
          widget.controller.reverse();
          setState(() {
            hasMovedIn = false;
          });
        },
      ),
    );
  }

  String getIngridientsBasePath(Ingridients ingridient, int index) {
    if (ingridient == Ingridients.BASIL)
      return Constants.BASIL[index];
    else if (ingridient == Ingridients.BROCCOLI)
      return Constants.BROCCOLI[index];
    else if (ingridient == Ingridients.MASHROOM)
      return Constants.MASHROOM[index];
    else if (ingridient == Ingridients.ONION)
      return Constants.ONION[index];
    else if (ingridient == Ingridients.SAUSAGE) return Constants.SAUSAGE[index];
    return "";
  }
}
