import 'package:coding_challenge_2021/routes/routes.dart';
import 'package:coding_challenge_2021/screens/pizza_selection.dart';
import 'package:coding_challenge_2021/services/nav_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      builder: (BuildContext context, Widget? child) {
        final data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(textScaleFactor: 1),
          child: child!,
        );
      },
      title: 'DIY Pizza',
      debugShowCheckedModeBanner: false,
      initialRoute: SetupRoutes.initialRoute,
      routes: SetupRoutes.routes,
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      navigatorKey: NavService.navKey,
      // home: PizzaSelection(),
    ),
  );
}
