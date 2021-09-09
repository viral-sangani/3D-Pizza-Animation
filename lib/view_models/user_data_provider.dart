import 'package:coding_challenge_2021/model/user_data.dart';
import 'package:coding_challenge_2021/services/firestore_service.dart';
import 'package:flutter/material.dart';

class UserDataProvider extends ChangeNotifier {
  UserDataProvider();

  UserData? userData;

  getUserDetails() async {
    userData = await FirestoreService().getUserDetails();
  }

  // var _demoData = UserData(
  //     name: 'Avinash',
  //     phoneNumber: '9999999991',
  //     address: 'B/4');

  // await _userDataProvider
  //     .setUserDetails(_demoData);
  setUserDetails(UserData _userData) async {
    var _result = await FirestoreService().setUserDetails(_userData);
    if (_result) {
      userData = _userData;
    }
  }
}
