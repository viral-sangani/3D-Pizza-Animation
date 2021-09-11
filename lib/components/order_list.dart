import 'package:coding_challenge_2021/screens/diy_pizza_screen.dart';
import 'package:coding_challenge_2021/services/size_config.dart';
import 'package:coding_challenge_2021/utils/text_styles.dart';
import 'package:coding_challenge_2021/view_models/ingridients_view_model.dart';
import 'package:coding_challenge_2021/view_models/pizza_view_model.dart';
import 'package:flutter/material.dart';

class OrderList extends StatelessWidget {
  final PizzaViewModel pizzaViewModel;
  final IngridientsViewModel ingridientsViewModel;
  const OrderList({
    Key? key,
    required this.pizzaViewModel,
    required this.ingridientsViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          Container(
            width: 110.toWidth,
            height: 110.toHeight,
            padding: EdgeInsets.all(15),
            child: Image.memory(pizzaViewModel.pizzaImage),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pizzaViewModel.selectedPizzaObj['name'],
                  style: CustomTextStyles.commonMontserrat(),
                ),
                SizedBox(height: 8),
                Text(
                  "Extra Toppings",
                  style: CustomTextStyles.commonMontserrat(
                    color: Colors.grey[500],
                    size: 15,
                  ),
                ),
                Text(
                  getIngridients(ingridientsViewModel.ingridients),
                  maxLines: 3,
                  style: CustomTextStyles.commonMontserrat(size: 15),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Text(
              "\$${pizzaViewModel.pizzaPrice.toInt().toString()}.00",
              style: CustomTextStyles.commonMontserrat(size: 20),
            ),
          ),
        ],
      ),
    );
  }

  getIngridients(List<Ingridients> ingridients) {
    String ingridientsString = '';
    ingridients.forEach((ingridient) {
      if (ingridient == Ingridients.BASIL)
        ingridientsString += 'Basil, ';
      else if (ingridient == Ingridients.BROCCOLI)
        ingridientsString += 'Broccoli, ';
      else if (ingridient == Ingridients.MASHROOM)
        ingridientsString += 'Mashroom, ';
      else if (ingridient == Ingridients.ONION)
        ingridientsString += 'Onion, ';
      else if (ingridient == Ingridients.SAUSAGE)
        ingridientsString += 'Sausage, ';
    });
    return ingridientsString != ""
        ? ingridientsString.substring(0, ingridientsString.length - 2)
        : "";
  }
}
