import 'dart:async';
import 'dart:typed_data';

import 'package:coding_challenge_2021/components/ingridient.dart';
import 'package:coding_challenge_2021/components/pizza.dart';
import 'package:coding_challenge_2021/routes/route_names.dart';
import 'package:coding_challenge_2021/services/size_config.dart';
import 'package:coding_challenge_2021/utils/colors.dart';
import 'package:coding_challenge_2021/utils/constants.dart';
import 'package:coding_challenge_2021/utils/text_styles.dart';
import 'package:coding_challenge_2021/view_models/ingridients_view_model.dart';
import 'package:coding_challenge_2021/view_models/pizza_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class DIYPizzaScreen extends StatefulWidget {
  DIYPizzaScreen({
    Key? key,
  }) : super(key: key);

  @override
  _DIYPizzaScreenState createState() => _DIYPizzaScreenState();
}

class _DIYPizzaScreenState extends State<DIYPizzaScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> pizzaScale;
  late Map<String, dynamic> selectedPizza;
  String? pizzaPath;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    selectedPizza =
        Provider.of<PizzaViewModel>(context, listen: false).selectedPizzaObj;
    pizzaPath = selectedPizza['path'] ?? "";
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 40.toHeight,
                  padding: EdgeInsets.symmetric(horizontal: 20.toWidth),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Provider.of<IngridientsViewModel>(context,
                                  listen: false)
                              .ingridients = [];
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.chevron_left,
                          size: 40.toFont,
                          color: ColorConstants.purple,
                        ),
                      ),
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 35.toFont,
                        color: ColorConstants.purple,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: Constants.PIZZAPADDING,
                    right: Constants.PIZZAPADDING,
                  ),
                  child: Pizza(
                    screenshotController: screenshotController,
                    scale: pizzaScale,
                    controller: _controller,
                    pizzaPath: pizzaPath ?? null,
                  ),
                ),
                SizedBox(height: 8.toHeight),
                Text("\$${pizzaViewModel.pizzaPrice.toInt().toString()}",
                    style: CustomTextStyles.priceStyle()),
                SizedBox(height: 8.toHeight),
                if (pizzaPath == null)
                  Text(
                    "Choose Sauce Type",
                    style: CustomTextStyles.chooseSauceTypeTextStyle(size: 18),
                  ),
                if (pizzaPath == null) SizedBox(height: 15.toHeight),
                if (pizzaPath == null)
                  Container(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(width: 40.toWidth),
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
                SizedBox(height: 20.toHeight),
                Text(
                  "Choose Toppings",
                  style: CustomTextStyles.chooseSauceTypeTextStyle(size: 18),
                ),
                SizedBox(height: 10.toHeight),
                Container(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0.toHeight),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 40.toWidth),
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
                SizedBox(height: 20.toHeight),
                GestureDetector(
                  onTap: () async {
                    Uint8List? image = await screenshotController.capture();
                    if (image != null) {
                      context.read<PizzaViewModel>().pizzaImage = image;
                    }
                    Navigator.pushNamed(context, Routes.CHECKOUT);
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 80).toWidth,
                    decoration: BoxDecoration(
                        color: ColorConstants.purple,
                        borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.symmetric(vertical: 16.toHeight),
                    child: Center(
                      child: Text(
                        "BUY NOW",
                        style: CustomTextStyles.buyNowTextStyle(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
        margin: EdgeInsets.only(right: 5.toWidth),
        padding: EdgeInsets.symmetric(
          vertical: 7.toHeight,
          horizontal: 17.toWidth,
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
      height: 70.toHeight,
      width: 70.toWidth,
      margin: EdgeInsets.only(right: 20.toWidth),
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
