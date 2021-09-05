import 'package:flutter/material.dart';
import 'package:coding_challenge_2021/routes/route_names.dart';
import 'package:coding_challenge_2021/routes/routes.dart';
import 'package:coding_challenge_2021/screens/splash/log_in/log_in.dart';
import 'package:coding_challenge_2021/services/firebase_service.dart';
import 'package:coding_challenge_2021/services/size_config.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  late AnimationController _textController, _inputBoxController;
  late Animation _textAnimation;
  late Tween<double> _textHeight;
  late String text;
  late bool isLogin, isPhoneNumberScreen, isSignedIn;

  @override
  void initState() {
    text = 'Start';
    isLogin = true;
    _textController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _inputBoxController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _textHeight = Tween<double>(begin: 400, end: 150);
    _textAnimation = _textHeight.animate(_textController);

    // isSignedIn = true;
    isSignedIn = FirebaseService().checkState();

    print('isSignedIn $isSignedIn');

    ///TODO: remove this
    // FirebaseService().firebaseAuth.signOut();
    // isSignedIn = false;

    super.initState();
  }

  _animate() {
    print('animate called');
    setState(() {
      isLogin = false;
    });
    _textController.forward().then((value) => _inputBoxController.forward());
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(alignment: Alignment.center, children: [
            Container(
              height: SizeConfig().screenHeight,
              width: SizeConfig().screenWidth,
              color: Colors.black,
            ),
            AnimatedBuilder(
                animation: _textController,
                builder: (BuildContext context, Widget? child) {
                  return Positioned(
                    top: _textAnimation.value,
                    left: 50.toWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Make',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 30.toFont,
                          ),
                        ),
                        SizedBox(height: 7.toHeight),
                        Text(
                          'your own',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 30.toFont,
                          ),
                        ),
                        SizedBox(height: 7.toHeight),
                        Text(
                          'Pizza',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 30.toFont,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            isLogin
                ? Positioned(
                    top: SizeConfig().screenHeight / 2 +
                        (10.toHeight + 100.toHeight + 16),
                    right: 40.toWidth,
                    child: TextButton(
                        onPressed: isSignedIn
                            ? () {
                                SetupRoutes.pushAndRemoveAll(
                                    context, Routes.HOME);
                              }
                            : _animate,
                        child: Container(
                          alignment: Alignment.center,
                          width: 140.toWidth,
                          height: 50.toHeight,
                          child: Text(
                            text,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.toWidth,
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              border: Border(),
                              borderRadius: BorderRadius.circular(30.toWidth)),
                        )),
                  )
                : SizedBox(),
            isSignedIn
                ? SizedBox()
                : SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: Offset.zero,
                    ).animate(_inputBoxController),
                    child: Login(),
                  ),
            Positioned(
              bottom: 10.toHeight,
              child: Text(
                'A GamersMate Product',
                style: TextStyle(
                  color: Color(0xFFFF4C4C),
                  fontSize: 16,
                ),
              ),
            ),
          ])),
    );
  }
}
