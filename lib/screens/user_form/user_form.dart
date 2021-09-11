import 'package:coding_challenge_2021/common_components/loading_widget.dart';
import 'package:coding_challenge_2021/model/user_data.dart';
import 'package:coding_challenge_2021/routes/route_names.dart';
import 'package:coding_challenge_2021/routes/routes.dart';
import 'package:coding_challenge_2021/services/firebase_service.dart';
import 'package:coding_challenge_2021/services/firestore_service.dart';
import 'package:coding_challenge_2021/services/size_config.dart';
import 'package:coding_challenge_2021/utils/colors.dart';
import 'package:coding_challenge_2021/utils/images.dart';
import 'package:coding_challenge_2021/utils/text_styles.dart';
import 'package:coding_challenge_2021/view_models/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var formFields = [];
  String? _phoneController,
      _nameController,
      _emailController,
      _addressController;

  String? _errorText;
  late UserData _userData;

  @override
  void initState() {
    _userData = UserData(
      name: '',
      phoneNumber: '${FirebaseService().firebaseAuth.currentUser!.phoneNumber}',
      address: '',
    );

    _phoneController = FirebaseService().firebaseAuth.currentUser!.phoneNumber;
    formFields = [
      {
        'label': 'Phone Number',
        'hintText': 'Enter Phone Number',
        'controller': _phoneController,
        'readOnly': true,
        'function': (String value) {
          _phoneController = value;
        },
      },
      {
        'label': 'Name *',
        'hintText': 'Enter your name',
        'controller': _nameController,
        'readOnly': false,
        'function': (String value) {
          _nameController = value;
        },
      },
      {
        'label': 'Email',
        'hintText': 'Enter Email',
        'controller': _emailController,
        'readOnly': false,
        'function': (String value) {
          _emailController = value;
        },
      },
      {
        'label': 'Address *',
        'hintText': 'Enter your delivery address',
        'controller': _addressController,
        'readOnly': false,
        'function': (String value) {
          _addressController = value;
        },
      },
    ];
    super.initState();
  }

  String getField(String label) {
    switch (label) {
      case 'Phone Number':
        return _userData.phoneNumber;
      case 'Name *':
        return _userData.name;
      case 'Email':
        return _userData.email ?? '';
      case 'Address *':
        return _userData.address;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 60.toHeight),
                    Container(
                      height: 100,
                      width: 100,
                      child: Image.asset(ImageAssets.USER_FORM_IMAGE),
                    ),
                    Text(
                      "Welcome",
                      style: TextStyle(
                        color: ColorConstants.black,
                        fontSize: 28.toFont,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10.toHeight),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.toWidth),
                      child: Text(
                        "Set your details for easy access in the future",
                        style: TextStyle(
                          color: ColorConstants.DARK_GREY,
                          fontSize: 14.toFont,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 50.toHeight),
                    Column(
                      children: formFields.map((_field) {
                        return _textField(
                            _field['label'],
                            _field['hintText'],
                            _field['controller'],
                            _field['readOnly'],
                            _field['function']);
                      }).toList(),
                    ),
                    SizedBox(height: 30.toHeight),
                    _errorText != null
                        ? Text(
                            _errorText!,
                            style: TextStyle(
                              color: ColorConstants.red,
                              fontSize: 14.toFont,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          )
                        : SizedBox(),
                    SizedBox(height: 50.toHeight),
                    _saveButton(),
                    SizedBox(height: 20.toHeight),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _textField(String label, String hintText, String? controller,
      bool readOnly, Function(String)? onChanged) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 30.0, top: 30.0),
          child: Text(label,
              style: TextStyle(
                color: ColorConstants.DARK_GREY,
                fontSize: 16.toFont,
              )),
        ),
        Container(
          padding: EdgeInsets.only(
              left: 30.0.toWidth, right: 30.0.toWidth, top: 10.0.toHeight),
          width: double.infinity,
          child: TextFormField(
            autovalidateMode: (controller?.isNotEmpty ?? false)
                ? AutovalidateMode.always
                : AutovalidateMode.onUserInteraction,
            readOnly: readOnly,
            autofocus: false,
            textInputAction: TextInputAction.next,
            initialValue: getField(label),
            onChanged: onChanged,
            style: TextStyle(
              color: ColorConstants.black,
              fontSize: 20,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: ColorConstants.LIGHT_GREY,
                fontSize: 16.toFont,
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
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: ColorConstants.RED, width: 2)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: ColorConstants.RED, width: 2)),
            ),
            validator: (value) {
              if ((label.contains('*')) && (value == null || value.isEmpty)) {
                return "Cannot leave this empty";
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _saveButton() {
    return Padding(
      padding: EdgeInsets.only(left: 30.toWidth),
      child: InkWell(
        onTap: _onSaveCall,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40.toHeight),
          alignment: Alignment.center,
          width: double.infinity,
          height: 60.toHeight,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Save',
                style: TextStyle(
                  color: ColorConstants.white,
                  fontSize: 20.toWidth,
                ),
              ),
              RichText(
                text: TextSpan(
                  text: '>',
                  style: CustomTextStyles.customTextStyle(
                    ColorConstants.white.withOpacity(0.2),
                    size: 20,
                  ),
                  children: [
                    TextSpan(
                      text: '>',
                      style: CustomTextStyles.customTextStyle(
                        ColorConstants.white.withOpacity(0.4),
                        size: 20,
                      ),
                    ),
                    TextSpan(
                      text: '>',
                      style: CustomTextStyles.customTextStyle(
                        ColorConstants.white,
                        size: 20,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onSaveCall() async {
    if (_nameController?.isEmpty ?? true) {
      _errorText = 'Please enter fields marked with *';
      setState(() {});
      return;
    }

    if (_addressController?.isEmpty ?? true) {
      _errorText = 'Please enter fields marked with *';
      setState(() {});
      return;
    }

    var _userData = UserData(
      name: _nameController!,
      phoneNumber: _phoneController!,
      address: _addressController!,
      email: _emailController,
    );

    print('_userData $_userData');

    LoadingDialog().show(text: 'Setting user details');

    var _userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);

    await _userDataProvider.setUserDetails(_userData);

    LoadingDialog().hide();

    if (_userDataProvider.userData != null) {
      SetupRoutes.pushAndRemoveAll(context, Routes.HOME);
    } else {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(SnackBar(
        backgroundColor: ColorConstants.RED,
        content: Text(
          'Failed, Try again!',
          style: CustomTextStyles.customTextStyle(
            ColorConstants.white,
          ),
        ),
      ));
    }
  }
}
