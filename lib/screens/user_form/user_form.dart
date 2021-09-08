import 'package:coding_challenge_2021/services/firestore_service.dart';
import 'package:coding_challenge_2021/services/size_config.dart';
import 'package:coding_challenge_2021/utils/colors.dart';
import 'package:coding_challenge_2021/utils/images.dart';
import 'package:coding_challenge_2021/utils/text_styles.dart';
import 'package:flutter/material.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  var formFields = [];
  late TextEditingController _phoneController = TextEditingController(),
      _nameController = TextEditingController(),
      _emailController = TextEditingController(),
      _addressController = TextEditingController();

  @override
  void initState() {
    FirestoreService().getUserDetails();

    _phoneController = TextEditingController(text: '+ 91 99999 99999');
    formFields = [
      {
        'label': 'Phone Number',
        'hintText': 'Enter Phone Number',
        'controller': _phoneController,
        'readOnly': true,
      },
      {
        'label': 'Name',
        'hintText': 'Enter your name',
        'controller': _nameController,
        'readOnly': false,
      },
      {
        'label': 'Email',
        'hintText': 'Enter Email',
        'controller': _emailController,
        'readOnly': false,
      },
      {
        'label': 'Address',
        'hintText': 'Enter your delivery address',
        'controller': _addressController,
        'readOnly': false,
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorConstants.lightGrey,
        body: Row(
          children: [
            Container(
              width: 10.toWidth,
              height: SizeConfig().screenHeight,
              color: ColorConstants.purple,
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
                        return _textField(_field['label'], _field['hintText'],
                            _field['controller'], _field['readOnly']);
                      }).toList(),
                    ),
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

  Widget _textField(String label, String hintText,
      TextEditingController controller, bool readOnly) {
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
            readOnly: readOnly,
            autofocus: false,
            textInputAction: TextInputAction.next,
            // initialValue: '+91 99999 99999',
            controller: controller,
            // textDirection: TextDirection.rtl,
            style: TextStyle(
              color: ColorConstants.black,
              fontSize: 20,
            ),
            decoration: InputDecoration(
              // hintTextDirection: TextDirection.rtl,
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
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Can't leave this empty";
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
        onTap: () {
          // SetupRoutes.pushAndRemoveAll(context, Routes.USER_FORM);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40.toHeight),
          alignment: Alignment.center,
          width: double.infinity,
          height: 60.toHeight,
          decoration: BoxDecoration(
            color: ColorConstants.purple,
            border: Border(),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.toWidth),
              bottomLeft: Radius.circular(20.toWidth),
            ),
            boxShadow: [
              BoxShadow(
                color: ColorConstants.purple,
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
}
