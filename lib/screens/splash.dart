import 'package:coding_challenge_2021/routes/route_names.dart';
import 'package:coding_challenge_2021/routes/routes.dart';
import 'package:coding_challenge_2021/services/firebase_service.dart';
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
    Future.delayed(Duration(seconds: 3), () {
      if (FirebaseService().checkState()) {
        SetupRoutes.pushAndRemoveAll(context, Routes.HOME);
      } else {
        SetupRoutes.pushAndRemoveAll(context, Routes.ONBOARDING);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Lottie.asset(Constants.PIZZA_SLICE_ANIMATION),
      ),
    );
  }
}
