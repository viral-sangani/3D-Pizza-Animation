import 'dart:async';

import 'package:coding_challenge_2021/common_components/end_animation.dart';
import 'package:coding_challenge_2021/components/card_details.dart';
import 'package:coding_challenge_2021/components/cards_container.dart';
import 'package:coding_challenge_2021/components/topbar.dart';
import 'package:coding_challenge_2021/routes/route_names.dart';
import 'package:coding_challenge_2021/utils/constants.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  CheckoutPage({Key? key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  late Animation<dynamic> containerHeightAnimation;
  late Animation<dynamic> cardHeightAnimation;
  late Animation<dynamic> cardXAnimation;
  late Animation<double> cardSize;
  late Animation<double> cardTransform;
  late Animation<double> spendContainerOpacity;

  bool showEndLottie = false;

  int? selectedCard;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    containerHeightAnimation = Tween(
      begin: Constants.cardContainerHeightBegin,
      end: Constants.cardContainerHeightEnd,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOutQuad,
        reverseCurve: Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    cardHeightAnimation = Tween(
      begin: 0.0,
      end: 0.5,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 0.2, curve: Curves.easeInOutQuint),
        reverseCurve: Interval(0.9, 1.0, curve: Curves.fastLinearToSlowEaseIn),
      ),
    );

    cardXAnimation = Tween(begin: 0.00, end: 0.42).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeIn,
      ),
    );

    cardSize = Tween(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInExpo,
      ),
    );

    cardTransform = Tween<double>(begin: 0, end: 0.1).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(0.0, 0.2, curve: Curves.easeIn),
      reverseCurve: Interval(0.95, 1, curve: Curves.easeOut),
    ));

    spendContainerOpacity = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );
  }

  void updateIsDetailOpen(bool value, int? index) {
    setState(() {
      selectedCard = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showEndLottie
        ? EndAnimation()
        : Scaffold(
            backgroundColor: Colors.grey[100],
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TopBar(
                    selectedCard: selectedCard,
                  ),
                  CardsContainer(
                    animationController: animationController,
                    containerHeightAnimation: containerHeightAnimation,
                    cardXAnimation: cardXAnimation,
                    cardSize: cardSize,
                    cardTransform: cardTransform,
                    cardHeightAnimation: cardHeightAnimation,
                    updateIsDetailOpen: updateIsDetailOpen,
                  ),
                  CardDetails(
                    spendContainerOpacity: spendContainerOpacity,
                    selectedCard: selectedCard,
                    onPayNow: () {
                      setState(() {
                        showEndLottie = true;
                      });
                      Timer(Duration(seconds: 4), () {
                        Navigator.popAndPushNamed(context, Routes.HOME);
                      });
                    },
                  ),
                ],
              ),
            ),
          );
  }
}
