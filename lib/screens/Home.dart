import 'package:coding_challenge_2021/routes/route_names.dart';
import 'package:coding_challenge_2021/routes/routes.dart';
import 'package:coding_challenge_2021/services/size_config.dart';
import 'package:coding_challenge_2021/utils/text_styles.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var pizzaOptions = [
    {
      'name': 'Plain pizza',
      'image': 'assets/Pizzas/Pizza_1.png',
      'rating': 4.0,
    },
    {
      'name': 'paneer pizza',
      'image': 'assets/Pizzas/Pizza_3.png',
      'rating': 4.5,
    },
    {
      'name': 'Mushroom pizza',
      'image': 'assets/Pizzas/Pizza_2.png',
      'rating': 3.0,
    },
    {
      'name': 'plain pizza',
      'image': 'assets/Pizzas/Pizza_1.png',
      'rating': 4.0,
    },
  ];
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      floatingActionButton: TextButton(
        onPressed: () {
          SetupRoutes.push(context, Routes.DIYPIZZA);
        },
        child: Text('Customize pizza'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 40),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    'DIY Pizza',
                    style: CustomTextStyles.blackBold(size: 25),
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  width: 300.toWidth,
                  color: Color(0xFFF7F7FF),
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.search),
                        Expanded(
                          child: Container(
                            width: 200.toWidth,
                            padding: const EdgeInsets.only(left: 10),
                            child: TextFormField(
                              onChanged: (String str) {
                                setState(() {
                                  searchText = str;
                                });
                              },
                              decoration: const InputDecoration(
                                  hintText: 'Search your food',
                                  hintStyle:
                                      TextStyle(fontFamily: 'Montserrat'),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        Icon(Icons.filter_alt_outlined)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Wrap(
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    runSpacing: 10.0,
                    spacing: 15.0,
                    children: List.generate(4, (index) {
                      String pizzaName = pizzaOptions[index]['name'] as String;
                      pizzaName = pizzaName.toLowerCase();

                      if (pizzaName.contains(searchText.toLowerCase().trim())) {
                        return pizzaCard(
                            pizzaOptions[index]['image'] as String,
                            pizzaOptions[index]['name'] as String,
                            pizzaOptions[index]['rating'] as double);
                      } else
                        return SizedBox();
                    })),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget pizzaCard(String pizzaImage, String title, double rating) {
    Widget pizzaCard = SizedBox();
    pizzaCard = Column(
      children: <Widget>[
        Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(70),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Image.asset(pizzaImage),
        ),
        SizedBox(height: 5),
        Container(
          child: Text(
            title,
            style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
    return pizzaCard;
  }
}
