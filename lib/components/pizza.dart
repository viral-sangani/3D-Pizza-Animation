import 'dart:async';

import 'package:coding_challenge_2021/components/pizza_topping.dart';
import 'package:coding_challenge_2021/screens/diy_pizza_screen.dart';
import 'package:coding_challenge_2021/services/size_config.dart';
import 'package:coding_challenge_2021/utils/constants.dart';
import 'package:coding_challenge_2021/view_models/ingridients_view_model.dart';
import 'package:coding_challenge_2021/view_models/pizza_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class Pizza extends StatefulWidget {
  final Animation<double> scale;
  final ScreenshotController screenshotController;
  final AnimationController controller;
  final String? pizzaPath;
  const Pizza({
    Key? key,
    required this.scale,
    required this.controller,
    required this.screenshotController,
    this.pizzaPath,
  }) : super(key: key);

  @override
  _PizzaState createState() => _PizzaState();
}

class _PizzaState extends State<Pizza> with TickerProviderStateMixin {
  late AnimationController fadePlateAnimationController;
  late Animation<double> fadePlateVal;
  bool hasMovedIn = false;

  @override
  void initState() {
    super.initState();
    fadePlateAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    PizzaViewModel pizzaViewModel = context.read<PizzaViewModel>();
    pizzaViewModel.pizzaAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    fadePlateVal =
        Tween<double>(begin: 0, end: 1).animate(fadePlateAnimationController);
    pizzaViewModel.pizzaXVal = Tween<double>(begin: 500, end: 0).animate(
      CurvedAnimation(
        parent: pizzaViewModel.pizzaAnimationController,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut,
      ),
    );
    fadePlateAnimationController.forward();
    Timer(Duration(milliseconds: 800), () {
      pizzaViewModel.pizzaAnimationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ingridientsProvider =
        Provider.of<IngridientsViewModel>(context, listen: true);
    final pizzaViewModel = Provider.of<PizzaViewModel>(context, listen: true);
    var pizzaSize =
        MediaQuery.of(context).size.width / 2 - Constants.PIZZAPADDING;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.toHeight),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 20,
            blurRadius: 20,
            offset: Offset(0, 14), // changes position of shadow
          ),
        ],
        shape: BoxShape.circle,
      ),
      child: Screenshot(
        controller: widget.screenshotController,
        child: DragTarget<Ingridients>(
          builder: (ctx, candidate, ejects) {
            return ScaleTransition(
              scale: widget.scale,
              child: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  height: (pizzaSize * 2 - 25).toHeight,
                  child: FadeTransition(
                    opacity: fadePlateVal,
                    child: Image.asset("assets/Plate.png"),
                  ),
                ),
                AnimatedBuilder(
                  animation: pizzaViewModel.pizzaAnimationController,
                  builder: (ctx, child) {
                    return Transform.translate(
                      offset: Offset(pizzaViewModel.pizzaXVal.value, 0),
                      child: child,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Image.asset(
                      widget.pizzaPath ?? pizzaViewModel.getSauceType(),
                    ),
                  ),
                ),
                if (ingridientsProvider.ingridients.length > 0)
                  for (int i = 0;
                      i < ingridientsProvider.ingridients.length;
                      i++)
                    for (int x = 0; x < 10; x++)
                      Builder(
                        builder: (ctx) {
                          var data = getIngridientsBasePath(
                            ingridientsProvider.ingridients[i],
                            x,
                          );
                          return PizzaToppingItem(
                            index: x,
                            ingridentIndex: i,
                            path: data['path'],
                            pizzaSize: pizzaSize,
                            toppingSize: data['size'],
                          );
                        },
                      )
              ]),
            );
          },
          onAccept: (ingridient) {
            setState(() {
              hasMovedIn = false;
            });
            ingridientsProvider.addIngridient(ingridient);
            pizzaViewModel.incPizzaPrice();
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
      ),
    );
  }

  Map<String, dynamic> getIngridientsBasePath(
      Ingridients ingridient, int index) {
    if (ingridient == Ingridients.BASIL)
      return {"path": Constants.BASIL[index], "size": 48.0};
    else if (ingridient == Ingridients.BROCCOLI)
      return {"path": Constants.BROCCOLI[index], "size": 37.0};
    else if (ingridient == Ingridients.MASHROOM)
      return {"path": Constants.MASHROOM[index], "size": 58.0};
    else if (ingridient == Ingridients.ONION)
      return {"path": Constants.ONION[index], "size": 46.0};
    else if (ingridient == Ingridients.SAUSAGE)
      return {"path": Constants.SAUSAGE[index], "size": 42.0};
    return {};
  }
}
