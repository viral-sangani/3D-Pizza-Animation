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
  late AnimationController _pizzaTransformController;
  var images = [
    'assets/Bread/Bread_1.png',
    'assets/Bread/Bread_2.png',
    'assets/Bread/Bread_3.png'
  ];

  var _tweenPizzaTransform = Tween<double>(
    begin: 0.6,
    end: 1.2,
  );

  late Animation<double> curve;

  @override
  void initState() {
    _pizzaTransformController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    curve = _tweenPizzaTransform.animate(CurvedAnimation(
        parent: _pizzaTransformController, curve: Curves.easeOut));

    animate();
    super.initState();
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
                animation: _pizzaTransformController,
                builder: (content, _) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // this is used to move unselected pizza pallete down
                      SizedBox(
                        height: _currentPageIndex != i ? curve.value * 220 : 0,
                      ),
                      Transform.scale(
                        scale: _currentPageIndex == i
                            ? curve.value
                            : (_tweenPizzaTransform.begin! +
                                _tweenPizzaTransform.end! -
                                curve.value),
                        child: Image.asset(images[i]),
                      ),
                      // this is used to move selected pizza pallete up
                      SizedBox(
                        height: _currentPageIndex == i ? curve.value * 100 : 0,
                      )
                    ],
                  );
                });
          },
        ),
      ),
    );
  }
}
