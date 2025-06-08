import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_tic_tac_toe/ui/scoreboard.dart';

class ScoreViewLast extends StatefulWidget {
  final int pointforX;
  final int pointforO;
  const ScoreViewLast(
      {super.key, required this.pointforX, required this.pointforO});

  @override
  State<ScoreViewLast> createState() => _ScoreViewLastState();
}

class _ScoreViewLastState extends State<ScoreViewLast> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool whosWinning = widget.pointforX >= widget.pointforO ? true : false;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 53, 47, 68),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                whosWinning ? "TIM A MENANG" : "TIM B MENANG",
                style: GoogleFonts.fredoka(
                  textStyle: TextStyle(
                    fontSize: 40,
                    shadows: List.filled(
                        1,
                        Shadow(
                          color: const Color.fromARGB(25, 250, 240, 230),
                          offset: Offset(0, 0),
                          blurRadius: 15,
                        )),
                    color: whosWinning
                        ? const Color.fromARGB(255, 255, 99, 99)
                        : const Color.fromARGB(255, 0, 215, 255),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              height: screenHeight * 0.15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: ScoreBoard(
                    text: "Tim A: ",
                    symbol: "X",
                    pointfor: widget.pointforX,
                    symbolColor: const Color.fromARGB(255, 250, 99, 99),
                  )),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "VS",
                      style: GoogleFonts.fredoka(
                        textStyle: TextStyle(
                          fontSize: 40,
                          color: const Color.fromARGB(255, 250, 240, 230),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: ScoreBoard(
                    text: "Tim B: ",
                    symbol: "O",
                    pointfor: widget.pointforO,
                    symbolColor: const Color.fromARGB(255, 0, 215, 255),
                  )),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, "/");
                Navigator.pushNamed(context, "/game");
              },
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  height: 70,
                  width: screenWidth * 0.6,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 250, 240, 230),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Icon(Icons.restart_alt_rounded,
                        color: const Color.fromARGB(255, 53, 47, 58), size: 30),
                  )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, "/");
              },
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  height: 70,
                  width: screenWidth * 0.6,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 250, 240, 230),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Icon(Icons.home_rounded,
                        color: const Color.fromARGB(255, 53, 47, 58), size: 30),
                  )),
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
        ),
      ),
    );
  }
}
