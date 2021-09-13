import 'package:coding_challenge_2021/routes/route_names.dart';
import 'package:coding_challenge_2021/routes/routes.dart';
import 'package:coding_challenge_2021/services/size_config.dart';
import 'package:coding_challenge_2021/utils/colors.dart';
import 'package:coding_challenge_2021/utils/constants.dart';
import 'package:coding_challenge_2021/utils/text_styles.dart';
import 'package:coding_challenge_2021/view_models/pizza_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

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
      floatingActionButton: Container(
        child: Stack(children: [
          Positioned(
            child: Opacity(
                key: UniqueKey(),
                opacity: 0.5,
                child: Container(
                  height: 75,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        ColorConstants.white,
                        ColorConstants.black
                      ])),
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              customButton('Customize pizza'),
              customButton('Build pizza', isCustomBuild: true)
            ],
          ),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 40),
          margin: EdgeInsets.only(bottom: 40),
          child: SingleChildScrollView(
            child: Stack(children: [
              Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      'DIY Pizza',
                      style: CustomTextStyles.blackBold(size: 25),
                    ),
                  ),
                  SizedBox(height: 20),
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
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFFFC700),
                        border: Border(),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.toWidth),
                        )),
                    child: ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      child: Transform.scale(
                          scale: 0.8,
                          child: Lottie.asset(Constants.HOME_BANNER_ANIMATION)),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text('Hungry ? Quick order',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left),
                  ),
                  SizedBox(height: 10),
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
                            return InkWell(
                              onTap: () {
                                final pizzaViewModel =
                                    Provider.of<PizzaViewModel>(context,
                                        listen: false);
                                pizzaViewModel.selectedPizzaObj =
                                    pizzaOptions[index];
                                SetupRoutes.push(context, Routes.DIYPIZZA);
                              },
                              child: pizzaCard(
                                  pizzaOptions[index]['path'] as String,
                                  pizzaOptions[index]['name'] as String),
                            );
                          } else
                            return SizedBox();
                        })),
                  ),
                ],
              ),
            ]),
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

  /// if [isCustomBuild] is true button and text colors are inverted
  Widget customButton(String text, {bool isCustomBuild: false}) {
    return InkWell(
      onTap: () {
        final pizzaViewModel =
            Provider.of<PizzaViewModel>(context, listen: false);
        pizzaViewModel.selectedPizzaObj = {};
        SetupRoutes.push(context, Routes.DIYPIZZA);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        width: 150,
        height: 70.toHeight,
        decoration: BoxDecoration(
          color: isCustomBuild ? ColorConstants.white : ColorConstants.amber,
          border: Border(),
          borderRadius: BorderRadius.all(
            Radius.circular(20.toWidth),
          ),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.amber,
              blurRadius: 2,
              offset: Offset(-3.0, -0.2),
            )
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
              color:
                  isCustomBuild ? ColorConstants.amber : ColorConstants.white,
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
