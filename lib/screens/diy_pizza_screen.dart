import 'package:coding_challenge_2021/components/ingridient.dart';
import 'package:coding_challenge_2021/components/pizza.dart';
import 'package:coding_challenge_2021/constants.dart';
import 'package:flutter/material.dart';

class DIYPizzaScreen extends StatefulWidget {
  DIYPizzaScreen({Key? key}) : super(key: key);

  @override
  _DIYPizzaScreenState createState() => _DIYPizzaScreenState();
}

class _DIYPizzaScreenState extends State<DIYPizzaScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> pizzaScale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    pizzaScale = Tween<double>(
      begin: 1,
      end: 1.04,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '🍕 Home Screen 🍕',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          left: Constants.PIZZAPADDING,
          right: Constants.PIZZAPADDING,
          top: 20,
        ),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [],
            color: Colors.white,
          ),
          child: Column(
            children: [
              Pizza(
                scale: pizzaScale,
                controller: _controller,
              ),
              Container(
                height: Constants.HEADERHEIGHT,
                padding: EdgeInsets.symmetric(vertical: 35),
                child: Column(
                  children: [
                    Text(
                      "\$15",
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "S",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.red),
                          ),
                          child: Center(
                            child: Text(
                              "M",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "L",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 20),
                      buildIngridientContainer(Ingridients.BASIL),
                      buildIngridientContainer(Ingridients.BROCCOLI),
                      buildIngridientContainer(Ingridients.MASHROOM),
                      buildIngridientContainer(Ingridients.ONION),
                      buildIngridientContainer(Ingridients.SAUSAGE),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildIngridientContainer(Ingridients ingridient) {
    return Container(
      height: 70,
      width: 70,
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.yellow[100],
        borderRadius: BorderRadius.circular(35),
      ),
      child: Ingridient(path: ingridient),
    );
  }
}

enum Ingridients {
  BASIL,
  BROCCOLI,
  MASHROOM,
  ONION,
  SAUSAGE,
}
