import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PizzaBox extends StatefulWidget {
  @override
  State<PizzaBox> createState() => _PizzaBoxState();
}

class _PizzaBoxState extends State<PizzaBox>
    with SingleTickerProviderStateMixin {
  Duration movingPizzaDuration = const Duration(milliseconds: 500);
  double _left = 20;
  double _top = 20;
  bool _isAtCenter = true;
  double _fixedCenterPizzaDiameter =
      300; // usedfor calculation as [_circleDiameter] will vary
  double _circleDiameter = 300;

  //////////
  late AnimationController _centerPizzaController;
  var _centerPizzaTransform = Tween<double>(
    begin: 0,
    end: 300,
  );
  late Animation<double> _centerPizzaAnimation;

  @override
  void initState() {
    _centerPizzaController =
        AnimationController(vsync: this, duration: movingPizzaDuration);

    _centerPizzaAnimation = _centerPizzaTransform.animate(
        CurvedAnimation(parent: _centerPizzaController, curve: Curves.easeOut));

    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      moveToCenter();
    });
  }

  moveToCart() async {
    setState(() {
      _left = MediaQuery.of(context).size.width -
          50 -
          30; // 50 size of small pizza at cart,  30 padding
      _top = 50; // position of cart
      _circleDiameter = 50;
    });

    // await Future.delayed(movingPizzaDuration);
    _centerPizzaController.forward();
  }

  moveToCenter() async {
    setState(() {
      _left = MediaQuery.of(context).size.width / 2 -
          (_fixedCenterPizzaDiameter / 2);
      _top = MediaQuery.of(context).size.height / 2 -
          (_fixedCenterPizzaDiameter / 2);
      _circleDiameter = 300;
    });

    // await Future.delayed(movingPizzaDuration);
    _centerPizzaController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[movingPizzaWidget(), centerPizzaWidget()],
      ),
    );
  }

  Widget movingPizzaWidget() {
    return AnimatedPositioned(
      duration: movingPizzaDuration,
      curve: Curves.fastOutSlowIn,
      left: _left,
      top: _top,
      width: _circleDiameter,
      height: _circleDiameter,
      child: InkWell(
        onTap: () {
          if (_isAtCenter) {
            moveToCart();
          } else {
            moveToCenter();
          }
          _isAtCenter = !_isAtCenter;
        },
        child: Container(
          child: Image.asset('assets/Bread/Bread_1.png'),
        ),
      ),
    );
  }

  Widget centerPizzaWidget() {
    return AnimatedBuilder(
      animation: _centerPizzaController,
      builder: (content, _) {
        return Positioned(
          top: MediaQuery.of(context).size.height / 2 -
              (_centerPizzaAnimation.value / 2),
          left: MediaQuery.of(context).size.width / 2 -
              (_centerPizzaAnimation.value / 2),
          child: Container(
            width: _centerPizzaAnimation.value,
            height: _centerPizzaAnimation.value,
            child: Image.asset('assets/Bread/Bread_1.png'),
          ),
        );
      },
    );
  }
}
