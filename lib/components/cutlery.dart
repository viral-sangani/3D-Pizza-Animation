import 'package:coding_challenge_2021/services/size_config.dart';
import 'package:coding_challenge_2021/utils/text_styles.dart';
import 'package:flutter/material.dart';

class Cutlery extends StatefulWidget {
  const Cutlery({
    Key? key,
  }) : super(key: key);

  @override
  _CutleryState createState() => _CutleryState();
}

class _CutleryState extends State<Cutlery> {
  int cutlery = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.toHeight,
      width: double.infinity,
      child: Row(
        children: [
          SizedBox(width: 40.toWidth),
          Icon(Icons.restaurant),
          Expanded(
            child: Center(
              child: Text(
                "Cutlery",
                style: CustomTextStyles.commonMontserrat(size: 19),
              ),
            ),
          ),
          Row(children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  cutlery--;
                });
              },
              child: Container(
                width: 40.toWidth,
                height: 40.toHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[300],
                ),
                child: Center(
                  child: Text(
                    "-",
                    style: CustomTextStyles.commonMontserrat(size: 20),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.toWidth),
            Text(
              cutlery.toString(),
              style: CustomTextStyles.commonMontserrat(size: 20),
            ),
            SizedBox(width: 10.toWidth),
            GestureDetector(
              onTap: () {
                setState(() {
                  cutlery++;
                });
              },
              child: Container(
                width: 40.toWidth,
                height: 40.toHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[300],
                ),
                child: Center(
                  child: Text(
                    "+",
                    style: CustomTextStyles.commonMontserrat(size: 20),
                  ),
                ),
              ),
            )
          ]),
        ],
      ),
    );
  }
}
