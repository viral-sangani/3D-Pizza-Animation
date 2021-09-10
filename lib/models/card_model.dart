import 'package:flutter/material.dart';

class CardModel {
  final String title;
  final int amount;
  final List<Color> borderContainer1;
  final List<Color> borderContainer2;
  final List<Color> bottomContainer;
  final List<Color> topCurveContainer;

  CardModel({
    required this.title,
    required this.amount,
    required this.borderContainer1,
    required this.borderContainer2,
    required this.bottomContainer,
    required this.topCurveContainer,
  });
}
