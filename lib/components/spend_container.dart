import 'package:flutter/material.dart';

class SpendsContainer extends StatelessWidget {
  final Animation<double> spendContainerOpacity;
  const SpendsContainer({
    Key? key,
    required this.spendContainerOpacity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            // color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 30,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          "Spends",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          height: 2,
                          color: Colors.grey[300],
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(child: Image.asset("assets/limit.png"), flex: 2),
                    Expanded(
                        child: Image.asset("assets/this-week.png"), flex: 2),
                  ],
                ),
                Image.asset("assets/peek.png")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
