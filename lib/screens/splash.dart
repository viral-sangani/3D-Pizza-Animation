import 'package:coding_challenge_2021/routes/route_names.dart';
import 'package:coding_challenge_2021/routes/routes.dart';
import 'package:coding_challenge_2021/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5), () {
      SetupRoutes.pushAndRemoveAll(context, Routes.HOME);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(Constants.PIZZA_SLICE_ANIMATION),
      ),
    );
  }
}
