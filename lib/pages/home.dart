import 'dart:async';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isVisible = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _isVisible = !_isVisible;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/game');
          },
          child: Center(
            child: Container(
                margin: EdgeInsets.all(10),
                height: 75,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Mulai",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/test');
          },
          child: Center(
            child: Container(
                margin: EdgeInsets.all(10),
                height: 75,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "test",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )),
          ),
        ),
      ],
    ));
  }
}
