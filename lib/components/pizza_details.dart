import 'package:coding_challenge_2021/utils/colors.dart';
import 'package:coding_challenge_2021/utils/text_styles.dart';
import 'package:flutter/material.dart';

class PizzaDetails extends StatelessWidget {
  const PizzaDetails({
    Key? key,
    required this.pizzaObj,
  }) : super(key: key);

  final Map<String, dynamic> pizzaObj;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(125),
          bottomRight: Radius.circular(125),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 20,
            blurRadius: 50,
            offset: Offset(0, 50),
            // changes position of shadow
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          Text(
            // "Test",
            pizzaObj["name"],
            style: CustomTextStyles.pizzaName(),
          ),
          SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 1; i <= pizzaObj["rating"]; i++)
                Icon(
                  Icons.star,
                  color: ColorConstants.purple,
                  size: 25,
                ),
              for (int i = 1; i <= 5 - pizzaObj["rating"]; i++)
                Icon(
                  Icons.star_border,
                  color: ColorConstants.purple,
                  size: 25,
                ),
            ],
          ),
          SizedBox(height: 30),
          Text(
            "\$${pizzaObj['price']}",
            style: CustomTextStyles.priceStyle(size: 50),
          )
        ],
      ),
    );
  }
}
