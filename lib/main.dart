import 'package:coding_challenge_2021/ingridients_controller.dart';
import 'package:coding_challenge_2021/routes/routes.dart';
import 'package:coding_challenge_2021/screens/pizza_selection.dart';
import 'package:coding_challenge_2021/services/nav_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => IngridientsController())
      ],
      child: MaterialApp(
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
        navigatorKey: NavService.navKey,
        home: PizzaSelection(),
      ),
    ),
  );
}
