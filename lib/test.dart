import 'package:flutter/material.dart';
import 'package:super_tic_tac_toe/ui/alert.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => TestState();
}

class TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              showGameAlert(context, "You Lose", "better luck next time jimmy");
            },
            child: Container(
              width: 200,
              height: 100,
              color: Colors.purple[600],
              child: Text("contoh"),
            ),
          ),
          GestureDetector(
            onTap: () async {},
            child: Container(
              width: 200,
              height: 100,
              color: Colors.purple[600],
              child: Text("contoh"),
            ),
          ),
        ],
      ),
    );
  }
}
