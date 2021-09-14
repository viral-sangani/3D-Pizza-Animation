import 'package:coding_challenge_2021/routes/routes.dart';
import 'package:coding_challenge_2021/services/nav_service.dart';
import 'package:coding_challenge_2021/services/size_config.dart';
import 'package:coding_challenge_2021/view_models/ingridients_view_model.dart';
import 'package:coding_challenge_2021/view_models/pizza_view_model.dart';
import 'package:coding_challenge_2021/view_models/user_data_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => IngridientsViewModel()),
        ChangeNotifierProvider(create: (ctx) => PizzaViewModel()),
        ChangeNotifierProvider<UserDataProvider>(
            create: (context) => UserDataProvider()),
      ],
      child: MaterialApp(
        builder: (BuildContext context, Widget? child) {
          SizeConfig().init(context);
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
        navigatorKey: NavService.navKey,
        theme: ThemeData(
          fontFamily: 'Montserrat',
        ),
      ),
    ),
  );
}
