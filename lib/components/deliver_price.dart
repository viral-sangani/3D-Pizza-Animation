import 'package:coding_challenge_2021/utils/text_styles.dart';
import 'package:flutter/material.dart';

class DeliveryPrice extends StatelessWidget {
  const DeliveryPrice({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Delivery",
              style: CustomTextStyles.commonMontserrat(
                fontWeight: FontWeight.bold,
                size: 15,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Free delivery from \$15",
              style: CustomTextStyles.commonMontserrat(size: 15),
            ),
          ],
        ),
        Text(
          "\$0.00",
          style: CustomTextStyles.commonMontserrat(
            fontWeight: FontWeight.bold,
            size: 18,
          ),
        ),
      ],
    );
  }
}
