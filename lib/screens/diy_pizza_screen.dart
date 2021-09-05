import 'dart:async';

import 'package:coding_challenge_2021/components/ingridient.dart';
import 'package:coding_challenge_2021/components/pizza.dart';
import 'package:coding_challenge_2021/utils/constants.dart';
import 'package:coding_challenge_2021/utils/text_styles.dart';
import 'package:coding_challenge_2021/view_models/pizza_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DIYPizzaScreen extends StatefulWidget {
  DIYPizzaScreen({Key? key}) : super(key: key);

  @override
  _DIYPizzaScreenState createState() => _DIYPizzaScreenState();
}

class _DIYPizzaScreenState extends State<DIYPizzaScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> pizzaScale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    pizzaScale = Tween<double>(
      begin: 1,
      end: 1.04,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '🍕 Home Screen 🍕',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          left: Constants.PIZZAPADDING,
          right: Constants.PIZZAPADDING,
          top: 20,
        ),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [],
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Pizza(
                scale: pizzaScale,
                controller: _controller,
              ),
              SizedBox(height: 40),
              Text(
                "Choose Sauce Type",
                style: CustomTextStyles.chooseSauceTypeTextStyle(size: 18),
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 5,
                  runSpacing: 8,
                  children: [
                    buildSauceType(
                      "Plain",
                      SauceType.Plain,
                    ),
                    buildSauceType(
                      "Peppery Red",
                      SauceType.PepperyRed,
                    ),
                    buildSauceType(
                      "Traditional Tomato",
                      SauceType.TraditionalTomato,
                    ),
                    buildSauceType(
                      "Spicy Red",
                      SauceType.SpicyRed,
                    ),
                    buildSauceType(
                      "None 🤯",
                      SauceType.None,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 20),
                        buildIngridientContainer(Ingridients.SAUSAGE),
                        buildIngridientContainer(Ingridients.MASHROOM),
                        buildIngridientContainer(Ingridients.ONION),
                        buildIngridientContainer(Ingridients.BASIL),
                        buildIngridientContainer(Ingridients.BROCCOLI),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSauceType(String text, SauceType sauceType) {
    return GestureDetector(
      onTap: () {
        PizzaViewModel pizzaViewModel = Provider.of<PizzaViewModel>(
          context,
          listen: false,
        );
        pizzaViewModel.animateRev();
        Timer(Duration(milliseconds: 800), () {
          pizzaViewModel.pizzaAnimationController.reverse();
        });
        Timer(Duration(milliseconds: 1400), () {
          pizzaViewModel.setSauceType(sauceType);
          pizzaViewModel.pizzaAnimationController.forward();
        });
        Timer(Duration(milliseconds: 2000), () {
          pizzaViewModel.animateForward();
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 7,
          horizontal: 17,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.brown,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          text,
          style: CustomTextStyles.pizzaSauceTextStyle(size: 18),
        ),
      ),
    );
  }

  Container buildIngridientContainer(Ingridients ingridient) {
    return Container(
      height: 70,
      width: 70,
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.yellow[100],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        shape: BoxShape.circle,
      ),
      child: Ingridient(path: ingridient),
    );
  }
}

enum Ingridients {
  BASIL,
  BROCCOLI,
  MASHROOM,
  ONION,
  SAUSAGE,
}
