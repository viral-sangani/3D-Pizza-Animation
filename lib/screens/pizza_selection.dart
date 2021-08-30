import 'package:flutter/material.dart';

class PizzaSelection extends StatefulWidget {
  @override
  _PizzaSelectionState createState() => _PizzaSelectionState();
}

class _PizzaSelectionState extends State<PizzaSelection>
    with TickerProviderStateMixin {
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
  AnimationController _pizzaTextController;
  Animation<Offset> _pizzaTextOffset;

  @override
  void initState() {
    _pizzaTransformController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    curve = _tweenPizzaTransform.animate(CurvedAnimation(
        parent: _pizzaTransformController, curve: Curves.easeOut));

    _pizzaTextController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    final pizzaTextcurve =
        CurvedAnimation(curve: Curves.decelerate, parent: _pizzaTextController);
    _pizzaTextOffset =
        Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero)
            .animate(pizzaTextcurve);

    animate();
    super.initState();
  }

  @override
  dispose() {
    _pizzaTransformController.dispose();
    _pizzaTextController.dispose();
    super.dispose();
  }

  animate() {
    if (_pizzaTransformController.isCompleted) {
      _pizzaTransformController.reverse();
      _pizzaTransformController.reset();
      _pizzaTextController.reset();
    }
    _pizzaTransformController.forward();
    _pizzaTextController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Order Manually',
                        style: TextStyle(fontSize: 22, color: Colors.black)),
                    Icon(Icons.shopping_cart, size: 30),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.location_on),
                    Text('Washington'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Pizza'),
                  onPressed: () {},
                  color: Color(0xFFF5D061),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 200,
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
                              height: 200,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(100),
                                    bottomRight: Radius.circular(100)),
                                border: Border(top: BorderSide.none),
                                color: Color(0xFFFBF7F5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xFFEBE7E9),
                                      spreadRadius: 3),
                                ],
                              ),
                              width: 200,
                              height: 300,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: 100),
                                  FadeTransition(
                                    opacity: _pizzaTextController,
                                    child: SlideTransition(
                                      position: _pizzaTextOffset,
                                      child: Text(
                                        'New Orleans Pizza',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.star, size: 15),
                                      Icon(Icons.star, size: 15),
                                      Icon(Icons.star, size: 15),
                                      Icon(Icons.star, size: 15),
                                      Icon(Icons.star, size: 15),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  FadeTransition(
                                    opacity: _pizzaTextController,
                                    child: SlideTransition(
                                      position: _pizzaTextOffset,
                                      child: Text('15',
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.black)),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('S'),
                                      SizedBox(width: 30),
                                      Text('M'),
                                      SizedBox(width: 30),
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
                            height: 1.2 * 200,
                          ),
                        ])),
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
                                    height: _currentPageIndex != i
                                        ? curve.value * 300
                                        : 0,
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
                                    height: _currentPageIndex == i
                                        ? curve.value * 200
                                        : 0,
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
            ],
          ),
        ),
      ),
    );
  }
}
