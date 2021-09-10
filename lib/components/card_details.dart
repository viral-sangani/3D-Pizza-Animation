import 'package:coding_challenge_2021/screens/diy_pizza_screen.dart';
import 'package:coding_challenge_2021/utils/colors.dart';
import 'package:coding_challenge_2021/utils/text_styles.dart';
import 'package:coding_challenge_2021/view_models/ingridients_view_model.dart';
import 'package:coding_challenge_2021/view_models/pizza_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardDetails extends StatelessWidget {
  final Animation<double> spendContainerOpacity;
  final int? selectedCard;
  const CardDetails({
    Key? key,
    required this.spendContainerOpacity,
    this.selectedCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pizzaViewModel = context.watch<PizzaViewModel>();
    final ingridientsViewModel = context.watch<IngridientsViewModel>();
    return Expanded(
      child: FadeTransition(
        opacity: spendContainerOpacity,
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  "We will deliver in\n24 minutes to this address:",
                  style: CustomTextStyles.delivery(),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Text(
                      "100 Earling Rd. NY",
                      style: CustomTextStyles.delivery(size: 18),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Change Address",
                      style: CustomTextStyles.changeAddress(),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Divider(color: Colors.black.withOpacity(0.2)),
                Container(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        padding: EdgeInsets.all(15),
                        child: Image.memory(pizzaViewModel.pizzaImage),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pizzaViewModel.selectedPizzaObj['name'],
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Extra Toppings",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 15,
                                color: Colors.grey[500],
                              ),
                            ),
                            Text(
                              getIngridients(ingridientsViewModel.ingridients),
                              maxLines: 3,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "\$${pizzaViewModel.pizzaPrice.toInt().toString()}.00",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Divider(color: Colors.black.withOpacity(0.2)),
                Container(
                  height: 80,
                  width: double.infinity,
                  child: Row(
                    children: [
                      SizedBox(width: 40),
                      Icon(Icons.restaurant),
                      Expanded(
                        child: Center(
                          child: Text(
                            "Cutlery",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Row(children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[300],
                          ),
                          child: Center(
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text("1", style: TextStyle(fontSize: 20)),
                        SizedBox(width: 10),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[300],
                          ),
                          child: Center(
                            child: Text(
                              "+",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      ]),
                    ],
                  ),
                ),
                Divider(color: Colors.black.withOpacity(0.2)),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Delivery",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Free delivery from \$15",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "\$0.00",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ColorConstants.purple,
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                      Text(
                        "Pay Now",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "24 min ",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text:
                                  "• \$${pizzaViewModel.pizzaPrice.toInt().toString()}.00",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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
    return ingridientsString.substring(0, ingridientsString.length - 2);
  }
}
