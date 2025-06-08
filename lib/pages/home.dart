import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_tic_tac_toe/ui/animatedbutton.dart';

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
        backgroundColor: Color.fromARGB(255, 53, 47, 68),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                "MATHCHESS",
                style: GoogleFonts.fredoka(
                  textStyle: TextStyle(
                    fontSize: 50,
                    shadows: List.filled(
                        1,
                        Shadow(
                          color: const Color.fromARGB(25, 250, 240, 230),
                          offset: Offset(0, 0),
                          blurRadius: 15,
                        )),
                    color: const Color.fromARGB(255, 255, 99, 99),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: AnimatedButton(
                textButton: "Mulai",
                boxColor: const Color.fromARGB(255, 53, 47, 58),
                onTap: () {
                  Navigator.pushNamed(context, '/game');
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Opacity(
              opacity: 0.8,
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: 9,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Image.asset(
                        "assets/images/cartoon-${index + 1}.png",
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
