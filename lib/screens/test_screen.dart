import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  final String path;
  const TestScreen({Key? key, required this.path}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Hero(
          tag: Text("Pizza123"),
          child: Image.asset(widget.path),
        ),
      ),
    );
  }
}
