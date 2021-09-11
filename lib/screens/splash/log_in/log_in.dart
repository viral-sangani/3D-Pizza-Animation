import 'dart:ui';

import 'package:coding_challenge_2021/services/size_config.dart';
import 'package:coding_challenge_2021/utils/colors.dart';
import 'package:coding_challenge_2021/view_models/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:coding_challenge_2021/common_components/loading_widget.dart';
import 'package:coding_challenge_2021/routes/route_names.dart';
import 'package:coding_challenge_2021/routes/routes.dart';
import 'package:coding_challenge_2021/services/firebase_service.dart';
import 'package:coding_challenge_2021/utils/text_styles.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  late AnimationController _phoneNoController, _otpController;
  late bool _isPhoneNumberScreen;
  late TextEditingController _phoneNumberController, _otpNumberController;
  String _errorText = '';
  @override
  void initState() {
    _isPhoneNumberScreen = true;
    _phoneNoController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _otpController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    _phoneNumberController = TextEditingController();
    _otpNumberController = TextEditingController();

    super.initState();
  }

  _animateToPhoneNumber({bool isReverse = false}) async {
    if (!isReverse) {
      _phoneNoController.forward();
      return;
    }
    _phoneNoController.reverse();
  }

  _animateToOtp({bool isReverse = false}) async {
    if (_phoneNumberController.text.isEmpty) {
      setState(() {
        _errorText = 'Phone number cannot be empty';
      });
      return;
    }

    /// To move phone number and bring otp
    if (!isReverse) {
      LoadingDialog().show(text: 'Verifying Phone Number');

      var _isValid = await _verifyPhoneNumber();

      LoadingDialog().hide();

      if (_isValid) {
        _animateToPhoneNumber();
        _otpController.forward();
        setState(() {
          _isPhoneNumberScreen = false;
        });
      } else {
        setState(() {
          _errorText = 'Phone number not valid';
        });
      }
      return;
    }

    setState(() {
      _isPhoneNumberScreen = true;
    });
    _animateToPhoneNumber(isReverse: isReverse);
    _otpController.reverse();
  }

  Future<bool> _verifyPhoneNumber() async {
    var _result =
        await FirebaseService().verifyPhoneNumber(_phoneNumberController.text);

    return _result;
  }

  _verifyOTPNumber() async {
    if (_otpNumberController.text.isEmpty) {
      setState(() {
        _errorText = 'OTP cannot be empty';
      });
      return;
    }

    LoadingDialog().show(text: 'Verifying OTP');

    var _result = await FirebaseService().verifyOTP(_otpNumberController.text);

    LoadingDialog().hide();

    if (_result != null) {
      LoadingDialog().show(text: 'Fetching user details');
      var _userDataProvider =
          Provider.of<UserDataProvider>(context, listen: false);
      await _userDataProvider.getUserDetails();

      LoadingDialog().hide();
      if (_userDataProvider.userData == null) {
        SetupRoutes.pushAndRemoveAll(context, Routes.USER_FORM);
      } else {
        SetupRoutes.pushAndRemoveAll(context, Routes.HOME);
      }
    } else {
      setState(() {
        _errorText = 'OTP verification failed';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 15.0, top: 30.0),
          decoration: BoxDecoration(
              border: Border(), borderRadius: BorderRadius.circular(30)),
          height: _isPhoneNumberScreen ? 0 : 80,
          child: _isPhoneNumberScreen
              ? SizedBox()
              : IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_left_rounded,
                    color: ColorConstants.black,
                  ),
                  iconSize: 40,
                  padding: EdgeInsets.all(0),
                  onPressed: () => _animateToOtp(isReverse: true)),
        ),
        _isPhoneNumberScreen
            ? SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0),
                  end: const Offset(-1, 0),
                ).animate(_phoneNoController),
                child: phoneNumberScreen(),
              )
            : SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(_otpController),
                child: otpScreen(),
              ),
        _errorText.length != 0
            ? Text(
                '$_errorText',
                style: CustomTextStyles.customTextStyle(ColorConstants.red,
                    size: 16),
              )
            : SizedBox(),
        _errorText.length != 0 ? SizedBox(height: 7) : SizedBox(),
        TextButton(
          onPressed: () async {
            if (_isPhoneNumberScreen) {
              /// Check mobile no is valid & send an OTP, then
              await _animateToOtp();
            } else {
              /// verify otp entered is correct, then
              await _verifyOTPNumber();
            }
          },
          child:
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: Container(
              //     padding: EdgeInsets.symmetric(horizontal: 40.toHeight),
              //     alignment: Alignment.center,
              //     width: SizeConfig().screenWidth - 50.toWidth,
              //     height: 70.toHeight,
              //     decoration: BoxDecoration(
              //       color: ColorConstants.purple,
              //       border: Border(),
              //       borderRadius: BorderRadius.only(
              //         topLeft: Radius.circular(20.toWidth),
              //         bottomLeft: Radius.circular(20.toWidth),
              //       ),
              //       boxShadow: [
              //         BoxShadow(
              //           color: ColorConstants.purple,
              //           blurRadius: 5,
              //           // spreadRadius: 8,
              //           offset: Offset(-3.0, -0.2),
              //         )
              //       ],
              //     ),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           _isPhoneNumberScreen ? 'Next' : 'Submit',
              //           style: TextStyle(
              //             color: ColorConstants.white,
              //             fontSize: 26.toWidth,
              //           ),
              //         ),
              //         RichText(
              //           text: TextSpan(
              //             text: '>',
              //             style: CustomTextStyles.customTextStyle(
              //               ColorConstants.white.withOpacity(0.2),
              //               size: 25,
              //             ),
              //             children: [
              //               TextSpan(
              //                 text: '>',
              //                 style: CustomTextStyles.customTextStyle(
              //                   ColorConstants.white.withOpacity(0.4),
              //                   size: 25,
              //                 ),
              //               ),
              //               TextSpan(
              //                 text: '>',
              //                 style: CustomTextStyles.customTextStyle(
              //                   ColorConstants.white,
              //                   size: 25,
              //                 ),
              //               )
              //             ],
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // )
              //////////
              Container(
            alignment: Alignment.center,
            width: 140,
            height: 50,
            child: Text(
              _isPhoneNumberScreen ? 'Next' : 'Submit',
              style: TextStyle(
                color: ColorConstants.white,
                fontSize: 20,
              ),
            ),
            decoration: BoxDecoration(
                color: ColorConstants.purple,
                border: Border(),
                borderRadius: BorderRadius.circular(30)),
          ),
        )
      ],
    );
  }

  phoneNumberScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          height: 30,
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 30.0, top: 30.0),
          child: Text("Phone Number",
              style: TextStyle(
                color: ColorConstants.DARK_GREY,
                fontSize: 20,
              )),
        ),
        Container(
          padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
          child: TextFormField(
            autofocus: false,
            textInputAction: TextInputAction.next,
            controller: _phoneNumberController,
            // textDirection: TextDirection.rtl,
            style: TextStyle(
              color: ColorConstants.black,
              fontSize: 20,
            ),
            decoration: InputDecoration(
              // hintTextDirection: TextDirection.rtl,
              prefixText: '+91 ',
              // floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: "Enter Phone Number",
              hintStyle: TextStyle(
                color: ColorConstants.LIGHT_GREY,
                fontSize: 16,
              ),
              contentPadding:
                  EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: Colors.blueAccent, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: Color(0xFFEBEBEB), width: 2)),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Can't leave this empty";
              }
              return null;
            },
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  otpScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // SizedBox(
        //   height: 30,
        // ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 30.0, top: 30.0),
          child: Text("Otp",
              style: TextStyle(
                color: ColorConstants.DARK_GREY,
                fontSize: 20,
              )),
        ),
        Container(
          padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
          child: TextFormField(
            autofocus: false,
            textInputAction: TextInputAction.next,
            controller: _otpNumberController,
            style: TextStyle(
              color: ColorConstants.black,
              fontSize: 20,
            ),
            decoration: InputDecoration(
              hintText: "Enter OTP",
              hintStyle: TextStyle(
                color: ColorConstants.LIGHT_GREY,
                fontSize: 16,
              ),
              contentPadding:
                  EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: Color(0xFFEBEBEB), width: 2)),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Can't leave this empty";
              }
              return null;
            },
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
