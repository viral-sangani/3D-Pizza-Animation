import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coding_challenge_2021/model/user_data.dart';
import 'package:coding_challenge_2021/services/firebase_service.dart';

class FirestoreService {
  FirestoreService._();
  static FirestoreService _instance = FirestoreService._();
  factory FirestoreService() => _instance;

  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('userData');

  final usersRef =
      FirebaseFirestore.instance.collection('userData').withConverter<UserData>(
            fromFirestore: (snapshot, _) => UserData.fromJson(snapshot.data()!),
            toFirestore: (movie, _) => movie.toJson(),
          );

  Future<UserData?> getUserDetails() async {
    if (FirebaseService().firebaseAuth.currentUser == null) {
      return null;
    }

    print('uid ${FirebaseService().firebaseAuth.currentUser!.uid}');

    UserData? _userData = await usersRef
        .doc(FirebaseService().firebaseAuth.currentUser!.uid)
        .get()
        .then((snapshot) => snapshot.data());

    print('getUserDetails() ========> _userData: $_userData');

    return _userData;
  }

  Future<bool> setUserDetails(UserData _userData) {
    return usersRef
        .doc(FirebaseService().firebaseAuth.currentUser!.uid)
        .set(_userData)
        .then((value) => true)
        .catchError((error) {
      print("Failed to add user: $error");
      return false;
    });
  }
}
