import 'package:coding_challenge_2021/common_components/loading_widget.dart';
import 'package:coding_challenge_2021/model/user_data.dart';
import 'package:coding_challenge_2021/utils/colors.dart';
import 'package:coding_challenge_2021/utils/images.dart';
import 'package:coding_challenge_2021/utils/text_styles.dart';
import 'package:coding_challenge_2021/view_models/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:coding_challenge_2021/routes/route_names.dart';
import 'package:coding_challenge_2021/routes/routes.dart';
import 'package:coding_challenge_2021/screens/splash/log_in/log_in.dart';
import 'package:coding_challenge_2021/services/firebase_service.dart';
import 'package:coding_challenge_2021/services/size_config.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> with TickerProviderStateMixin {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  late AnimationController _textController, _inputBoxController;
  late Animation _textAnimation;
  late Tween<double> _textHeight;
  late String text;
  late bool isLogin, isPhoneNumberScreen, isSignedIn;

  @override
  void initState() {
    // FirebaseService().signOut();
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
          backgroundColor: ColorConstants.lightGrey,
          body: Row(
            children: [
              Container(
                width: 10.toWidth,
                height: SizeConfig().screenHeight,
                color: ColorConstants.amber,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.toWidth),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 60.toHeight),
                          Text(
                            "Make your own Pizza, it's great !!",
                            style: TextStyle(
                              color: ColorConstants.black,
                              fontSize: 38.toFont,
                              fontWeight: FontWeight.w700,
                              // fontFamily: 'Montserrat',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: isLogin ? 25.toHeight : 0),
                    isLogin
                        ? Padding(
                            padding: EdgeInsets.only(left: 40.toHeight),
                            child: Divider(),
                          )
                        : SizedBox(),
                    SizedBox(height: isLogin ? 25.toHeight : 0),
                    isLogin
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: isSignedIn
                                  ? () async {
                                      // SetupRoutes.pushAndRemoveAll(
                                      //     context, Routes.USER_FORM);
                                      LoadingDialog()
                                          .show(text: 'Fetching user details');
                                      var _userDataProvider =
                                          Provider.of<UserDataProvider>(context,
                                              listen: false);

                                      await _userDataProvider.getUserDetails();

                                      LoadingDialog().hide();

                                      if (_userDataProvider.userData == null) {
                                        SetupRoutes.pushAndRemoveAll(
                                            context, Routes.USER_FORM);
                                      } else {
                                        SetupRoutes.pushAndRemoveAll(
                                            context, Routes.HOME);
                                      }
                                    }
                                  : _animate,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40.toHeight),
                                alignment: Alignment.center,
                                width: SizeConfig().screenWidth - 50.toWidth,
                                height: 70.toHeight,
                                decoration: BoxDecoration(
                                  color: ColorConstants.amber,
                                  border: Border(),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.toWidth),
                                    bottomLeft: Radius.circular(20.toWidth),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorConstants.amber,
                                      blurRadius: 5,
                                      // spreadRadius: 8,
                                      offset: Offset(-3.0, -0.2),
                                    )
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      text,
                                      style: TextStyle(
                                        color: ColorConstants.white,
                                        fontSize: 26.toWidth,
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: '>',
                                        style: CustomTextStyles.customTextStyle(
                                          ColorConstants.white.withOpacity(0.2),
                                          size: 25,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: '>',
                                            style: CustomTextStyles
                                                .customTextStyle(
                                              ColorConstants.white
                                                  .withOpacity(0.4),
                                              size: 25,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '>',
                                            style: CustomTextStyles
                                                .customTextStyle(
                                              ColorConstants.white,
                                              size: 25,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 0,
                          ),
                    isLogin
                        ? SizedBox(
                            // height: 200.toHeight,
                            )
                        : SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(1, 0),
                              end: Offset.zero,
                            ).animate(_inputBoxController),
                            child: Login(),
                          ),
                    Container(
                      child: Image.asset(
                        ImageAssets.SPLASH_BG,
                        height: 400.toHeight,
                      ),
                    )
                  ]),
                ),
              ),
            ],
          )),
    );
  }
}
