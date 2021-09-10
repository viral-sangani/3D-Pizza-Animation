import 'package:firebase_auth/firebase_auth.dart';
// import 'package:provider/provider.dart';
// import 'package:coding_challenge_2021/routes/route_names.dart';
// import 'package:coding_challenge_2021/routes/routes.dart';
// import 'package:coding_challenge_2021/services/nav_service.dart';

class FirebaseService {
  FirebaseService._();
  static FirebaseService _instance = FirebaseService._();
  factory FirebaseService() => _instance;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  late String _verificationId;

  checkState() {
    if ((firebaseAuth.currentUser != null) &&
        (firebaseAuth.currentUser?.getIdToken() != null)) {
      return true;
    }

    return false;
  }

  signOut() {
    firebaseAuth.signOut();

    // Provider.of<UserProvider>(NavService.navKey.currentContext, listen: false)
    //     .resetUserProvider();
    // Provider.of<ChallengesProvider>(NavService.navKey.currentContext,
    //         listen: false)
    //     .resetChallengeProvider();

    // SetupRoutes.pushAndRemoveAll(
    //     NavService.navKey.currentContext, Routes.SPLASH);
  }

  verifyPhoneNumber(String phoneNumber) async {
    bool? _result;
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91 $phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) {
        print('verificationFailed $e');
        _result = false;
      },
      codeSent: (String verificationId, int? resendToken) async {
        _verificationId = verificationId;
        _result = true;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );

    /// wait until we have a result
    while (_result == null) {
      await Future.delayed(Duration(seconds: 2));
    }
    return _result;
  }

  verifyOTP(String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: otp);

    var _result = await firebaseAuth
        .signInWithCredential(credential)
        .then((newUser) async {
      return newUser.user;
    }).catchError((e) => print('$e'));

    return _result;
  }
}
