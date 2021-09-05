import 'dart:async';
import 'dart:math' as math;

import 'package:coding_challenge_2021/view_models/ingridients_view_model.dart';
import 'package:coding_challenge_2021/view_models/pizza_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PizzaToppingItem extends StatefulWidget {
  final String path;
  final double pizzaSize;
  final int index;
  final int ingridentIndex;
  final double toppingSize;
  PizzaToppingItem({
    Key? key,
    required this.path,
    required this.pizzaSize,
    required this.index,
    required this.ingridentIndex,
    required this.toppingSize,
  }) : super(key: key);

  @override
  _PizzaToppingItemState createState() => _PizzaToppingItemState();
}

class _PizzaToppingItemState extends State<PizzaToppingItem>
    with TickerProviderStateMixin {
  late double radius, x, y, theta;
  List<double> randomPizzaRadius = [];
  late Animation<double> scaleAnimation;
  late AnimationController controller;

  removeIngridient(BuildContext context) {
    context
        .read<IngridientsViewModel>()
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
    math.Random random = new math.Random();
    controller = AnimationController(
      duration: Duration(milliseconds: random.nextInt(300) + 100),
      vsync: this,
    );
    scaleAnimation = Tween<double>(
      begin: 1.6,
      end: 1,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeOut,
    ));
    Timer(Duration(milliseconds: 1), () {
      double radius = [
        widget.pizzaSize * 0.3,
        widget.pizzaSize * 0.5,
        widget.pizzaSize * 0.7
      ][random.nextInt(3)];
      x = widget.pizzaSize - 10 + radius * math.cos(theta);
      y = widget.pizzaSize - 10 + radius * math.sin(theta);
      controller.forward();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final pizzaViewModel = context.watch<PizzaViewModel>();
    if (pizzaViewModel.scaleAnimateForward) {
      controller.forward();
    }

    if (pizzaViewModel.scaleAnimateReverse) {
      controller.reverse();
    }
    math.Random random = new math.Random();
    return AnimatedPositioned(
      duration: Duration(milliseconds: random.nextInt(800) + 100),
      curve: Curves.bounceIn,
      top: y,
      left: x,
      child: GestureDetector(
        onTap: () => removeIngridient(context),
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Image(
            image: AssetImage(widget.path),
            height: widget.toppingSize,
            width: widget.toppingSize,
          ),
        ),
      ),
    );
  }
}
