import 'package:coding_challenge_2021/components/card_clipper.dart';
import 'package:coding_challenge_2021/components/gradient_text.dart';
import 'package:coding_challenge_2021/models/card_model.dart';
import 'package:coding_challenge_2021/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardsContainer extends StatefulWidget {
  final Animation containerHeightAnimation;
  final Animation cardXAnimation;
  final Animation<double> cardSize;
  final Animation cardTransform;
  final Animation<dynamic> cardHeightAnimation;
  final AnimationController animationController;

  final Function updateIsDetailOpen;

  CardsContainer({
    Key? key,
    required this.containerHeightAnimation,
    required this.animationController,
    required this.cardXAnimation,
    required this.cardSize,
    required this.cardTransform,
    required this.cardHeightAnimation,
    required this.updateIsDetailOpen,
  }) : super(key: key);

  @override
  _CardsContainerState createState() => _CardsContainerState();
}

class _CardsContainerState extends State<CardsContainer> {
  int? selectedCard;
  double x = 0.50;
  double y = 0.01;
  double height = 200;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: widget.containerHeightAnimation,
      builder: (context, child) {
        return Container(
          height: widget.containerHeightAnimation.value,
          child: Listener(
            onPointerMove: (PointerMoveEvent moveEvent) {
              if (selectedCard != null) {
                setState(() {
                  selectedCard = null;
                });
              }
              if (moveEvent.delta.dy > 0) {
                if (widget.animationController.status !=
                    AnimationStatus.completed) {
                  widget.animationController.forward();
                }
              }
              if (moveEvent.delta.dy < 0) {
                if (widget.animationController.status ==
                    AnimationStatus.completed) {
                  widget.animationController.reverse();
                  widget.updateIsDetailOpen(false, null);
                }
              }
            },
            child: Stack(
              children: [
                for (int i = 0; i < Constants.cardModel.length; i++)
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 500),
                    top: selectedCard == null
                        ? getTop(i)
                        : selectedCard == i
                            ? 0
                            : 500,
                    left: 27,
                    child: AnimatedOpacity(
                      opacity: selectedCard == null
                          ? 1
                          : selectedCard == i
                              ? 1
                              : 0,
                      duration: Duration(milliseconds: 400),
                      child: Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateX(selectedCard == null
                              ? widget.cardXAnimation.value +
                                  ((i + 1) * 5) / 100
                              : selectedCard == i
                                  ? 0
                                  : widget.cardXAnimation.value +
                                      ((i + 1) * 5) / 100),
                        alignment: FractionalOffset.center,
                        child: Transform.scale(
                          scale: widget.cardSize.value + (i + 1) / 120,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCard = i;
                              });
                              widget.updateIsDetailOpen(true, i);
                              widget.animationController.reverse();
                            },
                            child: CreditCard(
                              height: height,
                              width: width,
                              cardModel: Constants.cardModel[i],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  double getTop(int i) {
    return (((i + 1) * 10 +
        i * widget.cardTransform.value * 460 +
        (widget.cardHeightAnimation.value * 200 as double)));
  }
}

class CreditCard extends StatelessWidget {
  CreditCard({
    Key? key,
    required this.height,
    required this.width,
    required this.cardModel,
  }) : super(key: key);

  final double height;
  final double width;
  final CardModel cardModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height + 10,
          width: width - 54,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            gradient: new LinearGradient(
              colors: cardModel.borderContainer1,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.0, 0.5, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          child: Container(
            height: height + 10,
            width: width - 54,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
              gradient: new LinearGradient(
                colors: cardModel.borderContainer2,
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                stops: [0.0, 0.5],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: new LinearGradient(
                  colors: cardModel.bottomContainer,
                  begin: Alignment.centerLeft,
                  end: Alignment.topRight,
                  stops: [0.0, 0.9, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
              child: ClipPath(
                clipper: CardShinyClipper(),
                child: Container(
                  height: height,
                  width: width - 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: new LinearGradient(
                      colors: cardModel.topCurveContainer,
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 20,
          left: 20,
          child: GradientText(cardModel.title.toUpperCase(),
              gradient: LinearGradient(
                colors: [
                  Colors.grey[700]!,
                  Colors.white,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              fontSize: 20,
              letterSpacing: 3.5),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: GradientText(
            "\$" + cardModel.amount.toString().toUpperCase(),
            gradient: LinearGradient(
              colors: [
                Colors.grey[700]!,
                Colors.white,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            fontSize: 36,
            letterSpacing: 1,
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Container(
            child: SvgPicture.asset(
              "assets/rings.svg",
              height: 80,
              cacheColorFilter: true,
            ),
          ),
        ),
      ],
    );
  }

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
}

extension GlobalKeyExtension on GlobalKey {
  Rect? get globalPaintBounds {
    var renderObject = currentContext?.findRenderObject();
    var translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null) {
      return renderObject!.paintBounds
          .shift(Offset(translation.x, translation.y));
    } else {
      return null;
    }
  }
}
