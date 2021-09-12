import 'package:coding_challenge_2021/routes/route_names.dart';
import 'package:coding_challenge_2021/routes/routes.dart';
import 'package:coding_challenge_2021/services/size_config.dart';
import 'package:coding_challenge_2021/utils/colors.dart';
import 'package:coding_challenge_2021/utils/constants.dart';
import 'package:coding_challenge_2021/utils/text_styles.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var pizzaOptions = Constants.pizzaList;
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      floatingActionButton: TextButton(
          onPressed: () {
            SetupRoutes.push(context, Routes.DIYPIZZA);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40.toHeight),
            alignment: Alignment.center,
            width: SizeConfig().screenWidth - 50.toWidth,
            height: 70.toHeight,
            decoration: BoxDecoration(
              color: ColorConstants.amber,
              border: Border(),
              borderRadius: BorderRadius.all(
                Radius.circular(20.toWidth),
              ),
              boxShadow: [
                BoxShadow(
                  color: ColorConstants.amber,
                  blurRadius: 5,
                  offset: Offset(-3.0, -0.2),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Customize your pizza',
                  style: TextStyle(
                    color: ColorConstants.white,
                    fontSize: 20.toWidth,
                  ),
                ),
              ],
            ),
          )),
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 100.0),
                  child: Wrap(
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.start,
                      runSpacing: 15.0,
                      spacing: 20.0,
                      children: List.generate(pizzaOptions.length, (index) {
                        String pizzaName =
                            pizzaOptions[index]['name'] as String;
                        pizzaName = pizzaName.toLowerCase();

                        if (pizzaName
                            .contains(searchText.toLowerCase().trim())) {
                          return pizzaCard(
                              pizzaOptions[index]['path'] as String,
                              pizzaOptions[index]['name'] as String);
                        } else
                          return SizedBox();
                      })),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget pizzaCard(String pizzaImage, String title) {
    Widget pizzaCard = SizedBox();
    pizzaCard = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, right: 8, left: 8),
        child: Column(
          children: <Widget>[
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(70),
              ),
              child: Image.asset(pizzaImage),
            ),
            SizedBox(height: 15),
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
        ),
      ),
    );
    return pizzaCard;
  }
}
