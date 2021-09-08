import 'package:coding_challenge_2021/routes/routes.dart';
import 'package:coding_challenge_2021/screens/pizza_selection.dart';
import 'package:coding_challenge_2021/services/nav_service.dart';
import 'package:coding_challenge_2021/services/size_config.dart';
import 'package:coding_challenge_2021/view_models/ingridients_view_model.dart';
import 'package:coding_challenge_2021/view_models/pizza_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => IngridientsViewModel()),
        ChangeNotifierProvider(create: (ctx) => PizzaViewModel()),
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
        initialRoute: SetupRoutes.pizzaSelection,
        routes: SetupRoutes.routes,
        navigatorKey: NavService.navKey,
        home: PizzaSelection(),
      ),
    ),
  );
}
