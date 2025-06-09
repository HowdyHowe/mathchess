import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScoreBoard extends StatefulWidget {
  final String text;
  final String symbol;
  final int pointfor;
  final Color symbolColor;
  const ScoreBoard(
      {super.key,
      required this.pointfor,
      required this.symbolColor,
      required this.text,
      required this.symbol});

  @override
  State<ScoreBoard> createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color.fromARGB(255, 250, 240, 230),
            width: 3,
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.symbol,
            style: GoogleFonts.fredoka(
              textStyle: TextStyle(
                fontSize: 40,
                shadows: List.filled(
                    1,
                    Shadow(
                      color: const Color.fromARGB(50, 250, 240, 230),
                      offset: Offset(0, 0),
                      blurRadius: 30,
                    )),
                color: widget.symbolColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.text,
                style: TextStyle(
                  fontFamily: "Fredoka",
                  fontSize: 20,
                  shadows: List.filled(
                      1,
                      Shadow(
                        color: const Color.fromARGB(50, 250, 240, 230),
                        offset: Offset(0, 0),
                        blurRadius: 30,
                      )),
                  color: const Color.fromARGB(255, 250, 240, 230),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${widget.pointfor}",
                style: TextStyle(
                  fontFamily: "Fredoka",
                  fontSize: 20,
                  shadows: List.filled(
                      1,
                      Shadow(
                        color: const Color.fromARGB(50, 250, 240, 230),
                        offset: Offset(0, 0),
                        blurRadius: 30,
                      )),
                  color: const Color.fromARGB(255, 250, 240, 230),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
