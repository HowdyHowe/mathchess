import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:super_tic_tac_toe/ui/block.dart';
import 'package:google_fonts/google_fonts.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  List x = [];
  List o = [];
  int pointforX = 0;
  int pointforO = 0;
  bool isXTurn = true;
  bool _isVisible = true;
  String numberA = "";
  String numberB = "";
  late Timer _timer;
  List<String> board = List.filled(81, "");

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _isVisible = !_isVisible;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Super Tic Tac Toe"),
              content: Text("Selamat datang di permainan Super Tic Tac Toe!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
                ),
              ],
            );
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
        backgroundColor: const Color.fromARGB(255, 53, 47, 68),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // sizedbox untuk jarak
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          margin: EdgeInsets.all(3),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 250, 240, 230),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Icon(Icons.home_rounded,
                                color: const Color.fromARGB(255, 53, 47, 58),
                                size: 30),
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          margin: EdgeInsets.all(3),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 250, 240, 230),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Icon(Icons.music_note_rounded,
                                color: const Color.fromARGB(255, 53, 47, 58),
                                size: 30),
                          )),
                    ),
                  ],
                ),
                Text(
                  isXTurn ? "Tim A (X)" : "Tim B (O)",
                  style: GoogleFonts.fredoka(
                    textStyle: TextStyle(
                      fontSize: 30,
                      shadows: List.filled(
                          1,
                          Shadow(
                            color: const Color.fromARGB(20, 250, 240, 230),
                            offset: Offset(0, 0),
                            blurRadius: 30,
                          )),
                      color: isXTurn
                          ? const Color.fromARGB(255, 255, 99, 99)
                          : const Color.fromARGB(255, 0, 215, 255),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // sizedbox untuk jarak
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      margin: EdgeInsets.all(3),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 250, 240, 230),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Icon(Icons.restart_alt_rounded,
                            color: const Color.fromARGB(255, 53, 47, 58),
                            size: 30),
                      )),
                ),
              ],
            ),

            // sizedbox untuk jarak
            SizedBox(
              height: 10,
            ),

            Text(
              "30.00",
              style: GoogleFonts.fredoka(
                textStyle: TextStyle(
                  fontSize: 20,
                  shadows: List.filled(
                      1,
                      Shadow(
                        color: const Color.fromARGB(20, 250, 240, 230),
                        offset: Offset(0, 2),
                        blurRadius: 20,
                      )),
                  color: isXTurn
                      ? const Color.fromARGB(255, 255, 99, 99)
                      : const Color.fromARGB(255, 0, 215, 255),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: Container(
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
                          "X",
                          style: GoogleFonts.fredoka(
                            textStyle: TextStyle(
                              fontSize: 40,
                              shadows: List.filled(
                                  1,
                                  Shadow(
                                    color:
                                        const Color.fromARGB(20, 250, 240, 230),
                                    offset: Offset(0, 0),
                                    blurRadius: 30,
                                  )),
                              color: const Color.fromARGB(255, 255, 99, 99),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tim A: ",
                              style: GoogleFonts.fredoka(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  shadows: List.filled(
                                      1,
                                      Shadow(
                                        color: const Color.fromARGB(
                                            20, 250, 240, 230),
                                        offset: Offset(0, 0),
                                        blurRadius: 30,
                                      )),
                                  color:
                                      const Color.fromARGB(255, 250, 240, 230),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              "${pointforX}",
                              style: GoogleFonts.fredoka(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  shadows: List.filled(
                                      1,
                                      Shadow(
                                        color: const Color.fromARGB(
                                            20, 250, 240, 230),
                                        offset: Offset(0, 0),
                                        blurRadius: 30,
                                      )),
                                  color:
                                      const Color.fromARGB(255, 250, 240, 230),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
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
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color.fromARGB(255, 250, 240, 230),
                          width: 3,
                        )),
                  ),
                ),
              ],
            ),

            // papan permainan
            Container(
              margin: EdgeInsets.only(top: 20, right: 3, left: 3),
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 92, 84, 112),
                borderRadius: BorderRadius.circular(5),
              ),
              child: GridView.builder(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 9,
                ),
                itemCount: 81,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        if (board[index] == "") {
                          setState(() {
                            board[index] = isXTurn ? "X" : "O";
                            isXTurn = !isXTurn;
                          });
                        }
                      },
                      child: Block(
                          position: index,
                          value:
                              "${board[index] == "" ? index + 1 : board[index]}",
                          textwidget: AnimatedSwitcher(
                              duration: Duration(milliseconds: 250),
                              switchInCurve: Curves.easeInOutBack,
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return ScaleTransition(
                                    scale: animation, child: child);
                              },
                              child: board[index] == ""
                                  ? AnimatedOpacity(
                                      opacity: _isVisible ? 1.0 : 0.0,
                                      duration: Duration(milliseconds: 1500),
                                      child: Opacity(
                                        opacity: 0.4,
                                        child: Text(
                                          '${index + 1}',
                                          style: GoogleFonts.chewy(
                                              textStyle: TextStyle(
                                            fontSize: 15,
                                            color: index % 2 == 0
                                                ? const Color.fromARGB(
                                                    255, 250, 240, 230)
                                                : const Color.fromARGB(
                                                    255, 53, 47, 58),
                                            fontWeight: FontWeight.w200,
                                          )),
                                        ),
                                      ),
                                    )
                                  : Text(
                                      board[index],
                                      key: ValueKey(board[index]),
                                      style: GoogleFonts.fredoka(
                                        textStyle: TextStyle(
                                          fontSize: 30,
                                          shadows: List.filled(
                                              1,
                                              Shadow(
                                                color: const Color.fromARGB(
                                                    192, 68, 68, 68),
                                                offset: Offset(0, 2),
                                                blurRadius: 10,
                                              )),
                                          color: board[index] == "X"
                                              ? const Color.fromARGB(
                                                  255, 255, 99, 99)
                                              : const Color.fromARGB(
                                                  255, 0, 215, 255),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ))));
                },
              ),
            ),

            Opacity(
              opacity: 0.8,
              child: Container(
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 9,
                  ),
                  itemCount: 9,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.all(5),
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

            // sizedbox untuk jarak
            SizedBox(
              height: 20,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Opacity(
                  opacity: 0.7,
                  child: Container(
                      child: numberA == ""
                          ? Image.asset("assets/images/cartoon-0.png",
                              width: 60)
                          : Image.asset(
                              numberA,
                              width: 60,
                            )),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("X",
                      style: GoogleFonts.caveatBrush(
                          textStyle: TextStyle(
                              color: const Color.fromARGB(255, 250, 240, 230),
                              fontSize: 40))),
                ),
                Opacity(
                  opacity: 0.7,
                  child: Container(
                      child: numberB == ""
                          ? Image.asset("assets/images/cartoon-0.png",
                              width: 60)
                          : Image.asset(
                              numberB,
                              width: 60,
                            )),
                ),
              ],
            )
          ],
        ));
  }
}
