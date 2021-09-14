import 'package:coding_challenge_2021/services/size_config.dart';
import 'package:coding_challenge_2021/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EndAnimation extends StatefulWidget {
  const EndAnimation({
    Key? key,
  }) : super(key: key);

  @override
  _EndAnimationState createState() => _EndAnimationState();
}

class _EndAnimationState extends State<EndAnimation> {
  bool showSuccess = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 2500), () {
      setState(() {
        showSuccess = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 300.toHeight,
            width: 400.toWidth,
            child: LottieBuilder.asset("assets/end-animation.json"),
          ),
          SizedBox(height: 10.toHeight),
          if (!showSuccess)
            Text(
              "Processing...",
              style: CustomTextStyles.commonMontserrat(size: 28),
            ),
          if (showSuccess)
            Text(
              "Order Placed Successfully..",
              style: CustomTextStyles.commonMontserrat(size: 22),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
