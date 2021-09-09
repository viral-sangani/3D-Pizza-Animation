import 'package:coding_challenge_2021/routes/route_names.dart';
import 'package:coding_challenge_2021/screens/Home.dart';
import 'package:coding_challenge_2021/screens/diy_pizza_screen.dart';
import 'package:coding_challenge_2021/screens/splash.dart';
import 'package:flutter/material.dart';

class SetupRoutes {
  static String initialRoute = Routes.SPLASH;
  static String dIYPizaa = Routes.DIYPIZZA;

  static Map<String, WidgetBuilder> get routes {
    return {
      Routes.HOME: (context) {
        return Home();
      },
      Routes.DIYPIZZA: (context) {
        return DIYPizzaScreen();
      },
      Routes.SPLASH: (context) {
        return Splash();
      },
    };
  }

  static Future push(BuildContext context, String value,
      {Object? arguments, Function? callbackAfterNavigation}) {
    return Navigator.of(context)
        .pushNamed(value, arguments: arguments)
        .then((response) {
      if (callbackAfterNavigation != null) {
        callbackAfterNavigation();
      }
    });
  }

  // ignore: always_declare_return_types
  static replace(BuildContext context, String value,
      {dynamic arguments, Function? callbackAfterNavigation}) {
    Navigator.of(context)
        .pushReplacementNamed(value, arguments: arguments)
        .then((response) {
      if (callbackAfterNavigation != null) {
        callbackAfterNavigation();
      }
    });
  }

  // ignore: always_declare_return_types
  static pushAndRemoveAll(BuildContext context, String value,
      {dynamic arguments, Function? callbackAfterNavigation}) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(
      value,
      (_) => false,
      arguments: arguments,
    )
        .then((response) {
      if (callbackAfterNavigation != null) {
        callbackAfterNavigation();
      }
    });
  }
}
