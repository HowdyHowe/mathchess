import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:super_tic_tac_toe/pages/game.dart';
import 'package:super_tic_tac_toe/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  runApp((Super3t()));
}

class Super3t extends StatelessWidget {
  const Super3t({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.purple,
          textTheme: TextTheme(
            bodyLarge: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white),
          )),
        title: "Super tic tac toe",
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => Home(),
          '/game': (context) => Game(),
        });
  }
}
