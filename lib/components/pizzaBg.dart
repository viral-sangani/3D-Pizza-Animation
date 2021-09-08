import 'dart:math' as math;

import 'package:coding_challenge_2021/utils/constants.dart';
import 'package:flutter/material.dart';

class PizzaBg extends StatefulWidget {
  PizzaBg({Key? key}) : super(key: key);

  @override
  _PizzaBgState createState() => _PizzaBgState();
}

class _PizzaBgState extends State<PizzaBg> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        height: 400,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: [
            for (int i = 0; i < Constants.EXTRA.length; i++)
              PizzaBgTopping(
                  width: MediaQuery.of(context).size.width, index: i),
          ],
        ),
      ),
    );
  }
}

class PizzaBgTopping extends StatefulWidget {
  final double width;
  final int index;
  const PizzaBgTopping({
    Key? key,
    required this.index,
    required this.width,
  }) : super(key: key);

  @override
  _PizzaBgToppingState createState() => _PizzaBgToppingState();
}

class _PizzaBgToppingState extends State<PizzaBgTopping> {
  late double radius, x, y, theta;

  @override
  void initState() {
    super.initState();
    math.Random random = math.Random();
    radius = random.nextInt(10) + 170;
    theta = (2 * math.pi * widget.index) / Constants.EXTRA.length;
    x = (widget.width - 80) / 2 + radius * math.cos(theta);
    y = (widget.width - 80) / 2 + radius * math.sin(theta);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: x,
      left: y,
      child: Container(
        child: Image(
          image: AssetImage(
            Constants.EXTRA[widget.index]['path'],
          ),
          height: Constants.EXTRA[widget.index]['size'],
          width: Constants.EXTRA[widget.index]['size'],
        ),
      ),
    );
  }
}
