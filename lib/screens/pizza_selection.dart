import 'dart:math' as math;

import 'package:coding_challenge_2021/components/pizzaBg.dart';
import 'package:coding_challenge_2021/components/pizza_details.dart';
import 'package:coding_challenge_2021/screens/diy_pizza_screen.dart';
import 'package:coding_challenge_2021/utils/colors.dart';
import 'package:coding_challenge_2021/utils/constants.dart';
import 'package:coding_challenge_2021/utils/text_styles.dart';
import 'package:flutter/material.dart';

class PizzaSelection extends StatefulWidget {
  @override
  _PizzaSelectionState createState() => _PizzaSelectionState();
}

class _PizzaSelectionState extends State<PizzaSelection>
    with TickerProviderStateMixin {
  PageController _pageController =
      PageController(initialPage: 1, viewportFraction: 0.6);
  int _currentPageIndex = 1;
  late AnimationController _pizzaTransformController;

  var images = [
    'assets/Bread/Bread_1.png',
    'assets/Bread/Bread_2.png',
    'assets/Bread/Bread_3.png'
  ];

  var _tweenPizzaTransform = Tween<double>(
    begin: 0.6,
    end: 1.15,
  );

  late Animation<double> curve;
  late Animation<double> rotate;
  late Animation<double> rotateBg;
  late double rotateVal = 0;

  late Map<String, dynamic> pizzaObj = pizzas[1];

  @override
  void initState() {
    _pizzaTransformController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    curve = _tweenPizzaTransform.animate(CurvedAnimation(
        parent: _pizzaTransformController, curve: Curves.easeOut));

    rotate = Tween<double>(
      begin: 0,
      end: 0.5,
    ).animate(
      CurvedAnimation(
        parent: _pizzaTransformController,
        curve: Curves.easeOut,
      ),
    );

    rotateBg = Tween<double>(
      begin: 0,
      end: math.pi / 4,
    ).animate(
      CurvedAnimation(
        parent: _pizzaTransformController,
        curve: Interval(0, 1, curve: Curves.easeOut),
      ),
    );

    _pageController.addListener(() {
      pizzaObj = pizzas[_pageController.page!.round()];
      setState(() {});
    });

    animate();
    super.initState();
  }

  animate() {
    if (_pizzaTransformController.isCompleted) {
      _pizzaTransformController.reverse();
      _pizzaTransformController.reset();
    }
    _pizzaTransformController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Order Manually",
                        style: CustomTextStyles.orderPizza(),
                      ),
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: ColorConstants.purple,
                        size: 35,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstants.purple,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Pizza",
                      style: CustomTextStyles.pizza(),
                    ),
                  ),
                ),
                // SizedBox(height: 60),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned(
                        left: 70,
                        top: 50,
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width - 140,
                          height: 400,
                          child: Column(
                            children: [Image.asset("assets/Plate.png")],
                            mainAxisAlignment: MainAxisAlignment.start,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 100,
                        left: MediaQuery.of(context).size.width / 2 - 125,
                        child: PizzaDetails(pizzaObj: pizzaObj),
                      ),
                      Positioned(
                        left: 10,
                        child: Transform.rotate(
                          angle: rotateVal + rotateBg.value,
                          child: PizzaBg(),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 50),
                        height: 650,
                        child: PageView.builder(
                          itemCount: Constants.PIZZAS.length,
                          controller: _pageController,
                          onPageChanged: (i) {
                            setState(() {
                              _currentPageIndex = i;
                              animate();
                              rotateVal += math.pi / 4;
                            });
                          },
                          itemBuilder: (context, i) {
                            return Container(
                              padding: EdgeInsets.only(top: 16),
                              child: AnimatedBuilder(
                                  animation: _pizzaTransformController,
                                  builder: (content, _) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        // this is used to move unselected pizza pallete down
                                        AnimatedContainer(
                                          duration: Duration(milliseconds: 200),
                                          height: _currentPageIndex != i
                                              ? curve.value * 220
                                              : 0,
                                        ),
                                        Transform.rotate(
                                          angle: rotate.value,
                                          child: Transform.scale(
                                            scale: _currentPageIndex == i
                                                ? curve.value
                                                : (_tweenPizzaTransform.begin! +
                                                    _tweenPizzaTransform.end! -
                                                    curve.value),
                                            child: GestureDetector(
                                              onTap: () {
                                                // Navigator.of(context)
                                                //     .pushNamed(Routes.DIYPIZZA);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) {
                                                      return DIYPizzaScreen();
                                                    },
                                                  ),
                                                );
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.all(15),
                                                child: Hero(
                                                  tag: Text("Pizza123"),
                                                  child: Image.asset(
                                                      Constants.PIZZAS[i]),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // this is used to move selected pizza pallete up
                                        AnimatedContainer(
                                          duration: Duration(milliseconds: 200),
                                          height: _currentPageIndex == i
                                              ? curve.value * 100
                                              : 0,
                                        )
                                      ],
                                    );
                                  }),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> pizzas = [
  {
    "name": "Tomato Pizza",
    "rating": 4,
    "price": "13",
  },
  {
    "name": "Pepperoni Pizza",
    "rating": 3,
    "price": "15",
  },
  {
    "name": "Pineapple Pizza",
    "rating": 2,
    "price": "14",
  },
  {
    "name": "Veg. Pizza",
    "rating": 4,
    "price": "12",
  },
  {
    "name": "Cheeze Burst",
    "rating": 5,
    "price": "18",
  }
];
