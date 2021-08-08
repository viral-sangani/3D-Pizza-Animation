import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:model_viewer/model_viewer.dart';

class PizzaBox extends StatefulWidget {
  @override
  State<PizzaBox> createState() => _PizzaBoxState();
}

class _PizzaBoxState extends State<PizzaBox> {
  double _left = 20;
  double _top = 20;
  bool _isAtCenter = true;

  double _fixedCenterPizzaDiameter =
      300; // usedfor calculation as [_circleDiameter] will vary
  double _circleDiameter = 300;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      moveToCenter();
    });
  }

  moveToCart() {
    setState(() {
      _left = MediaQuery.of(context).size.width -
          50 -
          30; // 50 size of small pizza at cart,  30 padding
      _top = 50; // position of cart
      _circleDiameter = 50;
    });
  }

  moveToCenter() {
    setState(() {
      _left = MediaQuery.of(context).size.width / 2 -
          (_fixedCenterPizzaDiameter / 2);
      _top = MediaQuery.of(context).size.height / 2 -
          (_fixedCenterPizzaDiameter / 2);
      _circleDiameter = 300;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
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
          ),
        ],
      ),
    );
  }
}
