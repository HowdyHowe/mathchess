import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedBoxApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedBoxPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AnimatedBoxPage extends StatefulWidget {
  @override
  _AnimatedBoxPageState createState() => _AnimatedBoxPageState();
}

class _AnimatedBoxPageState extends State<AnimatedBoxPage> {
  Color _color = Colors.blue;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(10);

  void _changeBox() {
    final random = Random();

    setState(() {
      _color = Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      );
      _borderRadius = BorderRadius.circular(random.nextInt(60).toDouble());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      body: Center(
        child: GestureDetector(
          onTap: _changeBox,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOutBack,
            width: 200,
            height: 100,
            decoration: BoxDecoration(
              color: _color,
              borderRadius: _borderRadius,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 3,
                  offset: Offset(3, 6),
                )
              ],
            ),
            child: Center(
              child: Icon(Icons.play_arrow, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
