import 'dart:async';

import 'package:coding_challenge_2021/components/ingridient.dart';
import 'package:coding_challenge_2021/components/pizza.dart';
import 'package:coding_challenge_2021/utils/colors.dart';
import 'package:coding_challenge_2021/utils/constants.dart';
import 'package:coding_challenge_2021/utils/text_styles.dart';
import 'package:coding_challenge_2021/view_models/ingridients_view_model.dart';
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
    PizzaViewModel pizzaViewModel = context.watch<PizzaViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: Constants.PIZZAPADDING,
                right: Constants.PIZZAPADDING,
              ),
              child: Pizza(
                scale: pizzaScale,
                controller: _controller,
              ),
            ),
            SizedBox(height: 8),
            Text("\$${pizzaViewModel.pizzaPrice.toInt().toString()}",
                style: CustomTextStyles.priceStyle()),
            SizedBox(height: 8),
            Text(
              "Choose Sauce Type",
              style: CustomTextStyles.chooseSauceTypeTextStyle(size: 18),
            ),
            SizedBox(height: 15),
            Container(
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 40),
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
            ),
            SizedBox(height: 20),
            Text(
              "Choose Toppings",
              style: CustomTextStyles.chooseSauceTypeTextStyle(size: 18),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 40),
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
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width - 80,
              decoration: BoxDecoration(
                  color: ColorConstants.purple,
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text(
                  "BUY NOW",
                  style: CustomTextStyles.buyNowTextStyle(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSauceType(String text, SauceType sauceType) {
    PizzaViewModel pizzaViewModel =
        Provider.of<PizzaViewModel>(context, listen: true);
    IngridientsViewModel ingridientsViewModel =
        Provider.of<IngridientsViewModel>(context);
    return GestureDetector(
      onTap: () {
        bool hasIngridients = ingridientsViewModel.ingridients.length > 0;
        if (hasIngridients) pizzaViewModel.animateRev();
        Timer(Duration(milliseconds: hasIngridients ? 800 : 100), () {
          pizzaViewModel.pizzaAnimationController.reverse();
        });
        Timer(Duration(milliseconds: hasIngridients ? 1400 : 700), () {
          pizzaViewModel.setSauceType(sauceType);
          pizzaViewModel.pizzaAnimationController.forward();
        });
        if (hasIngridients)
          Timer(Duration(milliseconds: 2000), () {
            pizzaViewModel.animateForward();
            pizzaViewModel.setSauceType(sauceType);
          });
        else
          Timer(Duration(milliseconds: 2000), () {
            pizzaViewModel.setSauceType(sauceType);
          });
      },
      child: Container(
        margin: EdgeInsets.only(right: 5),
        padding: EdgeInsets.symmetric(
          vertical: 7,
          horizontal: 17,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorConstants.purple,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
          color: pizzaViewModel.sauceType == sauceType
              ? ColorConstants.purple
              : Colors.white,
        ),
        child: Text(
          text,
          style: CustomTextStyles.pizzaSauceTextStyle(
            size: 14,
            color: pizzaViewModel.sauceType == sauceType
                ? Colors.white
                : ColorConstants.purple,
          ),
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
