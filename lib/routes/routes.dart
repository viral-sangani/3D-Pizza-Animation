import 'package:coding_challenge_2021/routes/route_names.dart';
import 'package:coding_challenge_2021/screens/checkout_screen.dart';
import 'package:coding_challenge_2021/screens/diy_pizza_screen.dart';
import 'package:coding_challenge_2021/screens/home_screen.dart';
import 'package:coding_challenge_2021/screens/pizza_selection_screen.dart';
import 'package:coding_challenge_2021/screens/splash/splash.dart';
import 'package:coding_challenge_2021/screens/splash_screen.dart';
import 'package:coding_challenge_2021/screens/user_form/user_form.dart';
import 'package:flutter/material.dart';

class SetupRoutes {
  static String initialRoute = Routes.SPLASH;
  static String dIYPizza = Routes.DIYPIZZA;
  static String pizzaSelection = Routes.PIZZASELECTION;
  static String checkoutPage = Routes.CHECKOUT;

  // static String initialRoute = Routes.ADD_LINK;
  static Map<String, WidgetBuilder> get routes {
    return {
      Routes.SPLASH: (context) => Splash(),
      Routes.USER_FORM: (context) => UserForm(),
      Routes.DIYPIZZA: (context) {
        return DIYPizzaScreen();
      },
      Routes.PIZZASELECTION: (context) {
        return PizzaSelection();
      },
      Routes.CHECKOUT: (context) {
        return CheckoutPage();
      },
      Routes.HOME: (context) {
        return Home();
      },
      Routes.ONBOARDING: (context) {
        return Onboarding();
      }
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
