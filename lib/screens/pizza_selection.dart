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
      backgroundColor: Color(0xFFF3EBEC),
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
                        style:
                            TextStyle(fontSize: 25, color: Color(0xFF7C3A3B))),
                    Icon(Icons.shopping_cart,
                        size: 30, color: Color(0xFF7C3A3B)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Color(0xFF7C3A3B),
                    ),
                    Text('Washington',
                        style: TextStyle(
                            color: Color(0xFF7C3A3B),
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: Text(
                    'Pizza',
                    style: TextStyle(
                        color: Color(0xFF7C3A3B),
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFFF5D061)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Color(0xFFF5D061))),
                    ),
                    // textStyle: MaterialStateProperty.all(
                    // TextStyle(color: Colors.red, fontSize: 25)),
                  ),
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
                                color: Color(0xFFFEF3ED),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFEBE7E9),
                                    spreadRadius: 5,
                                    offset: Offset(0.0, 3.0),
                                    blurRadius: 20.0,
                                  ),
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
                                            fontSize: 20,
                                            color: Color(0xFF7C3A3B)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.star,
                                            size: 18, color: Color(0xFFCF7441)),
                                        Icon(Icons.star,
                                            size: 18, color: Color(0xFFCF7441)),
                                        Icon(Icons.star,
                                            size: 18, color: Color(0xFFCF7441))
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  FadeTransition(
                                    opacity: _pizzaTextController,
                                    child: SlideTransition(
                                      position: _pizzaTextOffset,
                                      child: Text('15',
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Color(0xFF7C3A3B),
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            border: Border.all(
                                                width: 1, color: Colors.white),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0xFFEBE7E9),
                                                spreadRadius: 2,
                                                offset: Offset(0.0, 3.0),
                                                blurRadius: 5,
                                              )
                                            ]),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('S'),
                                          ),
                                        ),
                                      ),
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
