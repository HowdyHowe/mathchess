import 'package:flutter/material.dart';
import 'package:super_tic_tac_toe/pages/game.dart';
import 'package:super_tic_tac_toe/pages/home.dart';
import 'package:super_tic_tac_toe/test.dart';

void main() async {
  runApp((MathChess()));
}

class MathChess extends StatefulWidget {
  const MathChess({super.key});

  @override
  State<MathChess> createState() => _MathChessState();
}

class _MathChessState extends State<MathChess> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        title: "Super tic tac toe",
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => Home(),
          '/game': (context) => Game(),
          // '/test': (context) => Test()
        });
  }
}
