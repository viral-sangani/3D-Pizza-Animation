import 'dart:async';
import 'dart:math' as math;

import 'package:coding_challenge_2021/ingridients_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PizzaToppingItem extends StatefulWidget {
  final String path;
  final double pizzaSize;
  final int index;
  final int ingridentIndex;
  PizzaToppingItem({
    Key? key,
    required this.path,
    required this.pizzaSize,
    required this.index,
    required this.ingridentIndex,
  }) : super(key: key);

  @override
  _PizzaToppingItemState createState() => _PizzaToppingItemState();
}

class _PizzaToppingItemState extends State<PizzaToppingItem>
    with TickerProviderStateMixin {
  late double radius, x, y, theta;
  List<double> randomPizzaRadius = [];

  removeIngridient(BuildContext context) {
    context
        .read<IngridientsController>()
        .removeIngridient(widget.ingridentIndex);
  }

  @override
  void initState() {
    super.initState();
    theta = (2 * math.pi * widget.index) / 10;
    y = 0;
    if (theta > math.pi / 2 && theta < (math.pi + math.pi / 2))
      x = -500;
    else
      x = 500;
    setState(() {});
    Timer(Duration(milliseconds: 1), () {
      math.Random random = new math.Random();
      radius = [
        widget.pizzaSize * 0.4,
        widget.pizzaSize * 0.65,
        widget.pizzaSize * 0.9
      ][random.nextInt(3)];
      x = widget.pizzaSize + radius * math.cos(theta);
      y = widget.pizzaSize + radius * math.sin(theta);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 400),
      curve: Curves.bounceIn,
      top: y,
      left: x,
      child: GestureDetector(
        onTap: () => removeIngridient(context),
        child: Image(
          image: AssetImage(widget.path),
          height: 50,
          width: 50,
        ),
      ),
    );
  }
}
