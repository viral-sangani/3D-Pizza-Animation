import 'package:flutter/material.dart';

class PizzaSelection extends StatefulWidget {
  @override
  _PizzaSelectionState createState() => _PizzaSelectionState();
}

class _PizzaSelectionState extends State<PizzaSelection>
    with SingleTickerProviderStateMixin {
  PageController _pageController =
      PageController(initialPage: 1, viewportFraction: 0.5);
  int _currentPageIndex = 1;
  AnimationController _pizzaTransformController;
  var images = [
    'assets/Bread/Bread_1.png',
    'assets/Bread/Bread_2.png',
    'assets/Bread/Bread_3.png'
  ];

  var _tweenPizzaTransform = Tween<double>(
    begin: 0.6,
    end: 1.2,
  );

  Animation<double> curve;

  @override
  void initState() {
    _pizzaTransformController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    curve = _tweenPizzaTransform.animate(CurvedAnimation(
        parent: _pizzaTransformController, curve: Curves.easeOut));

    animate();
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  animate() {
    if (_pizzaTransformController.isCompleted) {
      _pizzaTransformController.reverse();
      _pizzaTransformController.reset();
    }
    _pizzaTransformController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Positioned(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          // color: Colors.yellow.withOpacity(0.5),
                          ),
                      width: 200,
                      height: 250,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(100),
                            bottomRight: Radius.circular(100)),
                        border: Border(top: BorderSide.none),
                        color: Color(0xFFFBF7F5),
                        boxShadow: [
                          BoxShadow(color: Color(0xFFEBE7E9), spreadRadius: 3),
                        ],
                      ),
                      width: 200,
                      height: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 100),
                          Text('New Orleans Pizza'),
                          Text('15'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('S'),
                              Text('M'),
                              Text('L'),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.scale(
                    scale: 0.7,
                    child: Image.asset('assets/plate.png'),
                  ),
                  SizedBox(
                    height: 1.2 * 100,
                  )
                ],
              ),
            ),
            Positioned(
              child: PageView.builder(
                itemCount: images.length,
                controller: _pageController,
                onPageChanged: (i) {
                  setState(() {
                    _currentPageIndex = i;
                    animate();
                  });
                },
                itemBuilder: (context, i) {
                  return AnimatedBuilder(
                    child: Image.asset(images[i]),
                    animation: _pizzaTransformController,
                    builder: (content, pizzaImage) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // this is used to move unselected pizza pallete down
                          SizedBox(
                            height:
                                _currentPageIndex != i ? curve.value * 220 : 0,
                          ),
                          Transform.scale(
                            scale: _currentPageIndex == i
                                ? curve.value
                                : (_tweenPizzaTransform.begin +
                                    _tweenPizzaTransform.end -
                                    curve.value),
                            child: pizzaImage,
                          ),
                          // this is used to move selected pizza pallete up
                          SizedBox(
                            height:
                                _currentPageIndex == i ? curve.value * 100 : 0,
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
