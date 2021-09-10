import 'package:coding_challenge_2021/routes/route_names.dart';
import 'package:coding_challenge_2021/screens/checkout_page.dart';
import 'package:coding_challenge_2021/screens/diy_pizza_screen.dart';
import 'package:coding_challenge_2021/screens/pizza_selection.dart';
import 'package:flutter/material.dart';

class SetupRoutes {
  static String initialRoute = Routes.HOME;
  static String dIYPizza = Routes.DIYPIZZA;
  static String pizzaSelection = Routes.PIZZASELECTION;
  static String checkoutPage = Routes.CHECKOUT;

  static Map<String, WidgetBuilder> get routes {
    return {
      Routes.HOME: (context) {
        return SizedBox();
      },
      Routes.DIYPIZZA: (context) {
        return DIYPizzaScreen();
      },
      Routes.PIZZASELECTION: (context) {
        return PizzaSelection();
      },
      Routes.CHECKOUT: (context) {
        return CheckoutPage();
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
