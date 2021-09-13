import 'dart:math' as math;

import 'package:coding_challenge_2021/components/pizzaBg.dart';
import 'package:coding_challenge_2021/components/pizza_details.dart';
import 'package:coding_challenge_2021/screens/diy_pizza_screen.dart';
import 'package:coding_challenge_2021/services/size_config.dart';
import 'package:coding_challenge_2021/utils/colors.dart';
import 'package:coding_challenge_2021/utils/constants.dart';
import 'package:coding_challenge_2021/utils/text_styles.dart';
import 'package:coding_challenge_2021/view_models/pizza_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  late Map<String, dynamic> pizzaObj = Constants.pizzaList[1];

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
      pizzaObj = Constants.pizzaList[_pageController.page!.round()];
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.toWidth,
                  vertical: 20.toHeight,
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
                      size: 35.toFont,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.toWidth),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.toWidth,
                    vertical: 5.toHeight,
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
                      left: 65.toWidth,
                      top: 49.toHeight,
                      child: Container(
                        alignment: Alignment.center,
                        width:
                            (MediaQuery.of(context).size.width - 184).toWidth,
                        height: 400.toHeight,
                        child: Column(
                          children: [Image.asset("assets/Plate.png")],
                          mainAxisAlignment: MainAxisAlignment.start,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30.toHeight,
                      left:
                          (MediaQuery.of(context).size.width / 2 - 125.toWidth),
                      child: PizzaDetails(pizzaObj: pizzaObj),
                    ),
                    Positioned(
                      left: 0,
                      child: Transform.rotate(
                        angle: rotateVal + rotateBg.value,
                        child: PizzaBg(),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 42.toHeight),
                      height: 650.toHeight,
                      child: PageView.builder(
                        itemCount: Constants.pizzaList.length,
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
                            padding: EdgeInsets.only(top: 16.toHeight),
                            child: AnimatedBuilder(
                                animation: _pizzaTransformController,
                                builder: (content, _) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // this is used to move unselected pizza pallete down
                                      AnimatedContainer(
                                        duration: Duration(milliseconds: 200),
                                        height: _currentPageIndex != i
                                            ? (curve.value * 220).toHeight
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
                                              final pizzaViewModel =
                                                  Provider.of<PizzaViewModel>(
                                                      context,
                                                      listen: false);
                                              pizzaViewModel.selectedPizzaObj =
                                                  pizzaObj;
                                              pizzaViewModel.pizzaPrice =
                                                  double.parse(
                                                      pizzaObj['price']);
                                              Navigator.push(
                                                context,
                                                _createRoute(pizzaObj['name']),
                                              );
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(18),
                                              child: Image.asset(
                                                Constants.pizzaList[i]['path'],
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
    );
  }
}

Route _createRoute(String path) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return DIYPizzaScreen();
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      var tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: Curves.ease),
      );
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
