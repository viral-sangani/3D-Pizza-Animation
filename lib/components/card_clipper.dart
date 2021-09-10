import 'package:flutter/material.dart';

class CardShinyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.60);
    path.quadraticBezierTo(size.width / 2, size.height * 0.7, size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CardShinyClipper oldClipper) => false;
}
