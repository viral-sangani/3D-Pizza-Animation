import 'dart:ui';

import 'package:coding_challenge_2021/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:coding_challenge_2021/common_components/loading_widget.dart';
import 'package:coding_challenge_2021/routes/route_names.dart';
import 'package:coding_challenge_2021/routes/routes.dart';
import 'package:coding_challenge_2021/services/firebase_service.dart';
import 'package:coding_challenge_2021/utils/text_styles.dart';

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

    LoadingDialog().show(text: 'Verifying Phone Number');

    /// To move phone number and bring otp
    if (!isReverse) {
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
      SetupRoutes.pushAndRemoveAll(context, Routes.HOME);
    } else {
      setState(() {
        _errorText = 'OTP verification failed';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 15.0, top: 30.0),
          decoration: BoxDecoration(
              border: Border(), borderRadius: BorderRadius.circular(30)),
          height: 80,
          child: _isPhoneNumberScreen
              ? SizedBox()
              : IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_left_rounded,
                    color: Colors.white,
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
            child: Container(
              alignment: Alignment.center,
              width: 140,
              height: 50,
              child: Text(
                _isPhoneNumberScreen ? 'Next' : 'Submit',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  border: Border(),
                  borderRadius: BorderRadius.circular(30)),
            ))
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
                color: Colors.white,
                fontSize: 20,
              )),
        ),
        Container(
          padding: EdgeInsets.only(
              left: 30.0,
              // right: 30.0,
              top: 10.0),
          child: TextFormField(
            autofocus: false,
            textInputAction: TextInputAction.next,
            controller: _phoneNumberController,
            // textDirection: TextDirection.rtl,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            decoration: InputDecoration(
              // hintTextDirection: TextDirection.rtl,
              hintText: "Enter Phone Number",
              hintStyle: TextStyle(
                color: Colors.white,
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
        SizedBox(
          height: 30,
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 30.0, top: 30.0),
          child: Text("Otp",
              style: TextStyle(
                color: Colors.white,
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
              color: Colors.white,
              fontSize: 20,
            ),
            decoration: InputDecoration(
              hintText: "Enter OTP",
              hintStyle: TextStyle(
                color: Colors.white,
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
