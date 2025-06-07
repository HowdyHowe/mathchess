// IMPORTANT
// BASIS NOMOR YANG DIGUNAKAN ADALAH DARI 1 BUKAN DARI 0.
// SELALU SESUAIKAN CODE NYA

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:super_tic_tac_toe/ui/block.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_tic_tac_toe/ui/scoreboard.dart';
import 'package:super_tic_tac_toe/ui/animatedbutton.dart';
import 'package:super_tic_tac_toe/ui/alert.dart';

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
  int turnCount = 0;
  int numberA = 0;
  int numberB = 0;
  int autoReset = 0;
  bool readyA = false;
  bool readyB = false;
  bool isXTurn = true;
  bool _isVisible = true;
  String textCount = "X";
  String whosPlaying = "X";
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

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showGameAlert(
          context, "Selamat Datang", "Ayo kita Mulai bermain MathChess 🎮");
      await Future.delayed(Duration(milliseconds: 300));
      await showGameAlert(
          context, "TIM A MULAI", "Tim A Dipersilahkan Memilih Angka");
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void checkBoard() {
    for (var i in x) {
      if (board[i - 1] == "") {
        setState(() {
          board[i - 1] = "X";
        });
      }
    }
    for (var i in o) {
      if (board[i - 1] == "") {
        setState(() {
          board[i - 1] = "O";
        });
      }
    }
  }

  void changeNumber(int index) {
    if (textCount == "X") {
      numberA = index + 1;
    }
    if (textCount == "O") {
      numberB = index + 1;
    }
  }

  bool currentPlayer(int turn) {
    int patternIndex = turn % 4;
    if (patternIndex == 0 || patternIndex == 3) {
      textCount = "X";
      return true;
    } else {
      textCount = "O";
      return false;
    }
  }

  Future<void> calculateSum(bool statA, bool statB, int numA, int numB) async {
    if (statA && statB) {
      int sum = (numA * numB);

      if (whosPlaying == "X") {
        if (x.contains(sum) || o.contains(sum)) {
          readyA = false;
          readyB = false;
          numberA = 0;
          numberB = 0;
          whosPlaying = "O";
          await Future.delayed(Duration(milliseconds: 300));
          await showGameAlert(context, "TIM A GAGAL ❌",
              "Angka Yang Dipilih Sudah Ada di Papan.");
          return;
        } else {
          x.add(sum);
          readyA = false;
          readyB = false;
          numberA = 0;
          numberB = 0;
          whosPlaying = "O";

          checkBoard();
          await Future.delayed(Duration(milliseconds: 300));
          await showGameAlert(context, "TIM A BERHASIL ✔️",
              "Angka Yang Dipilih Berhasil Dimasukkan ke Papan.");
        }
      } else if (whosPlaying == "O") {
        if (x.contains(sum) || o.contains(sum)) {
          readyA = false;
          readyB = false;
          numberA = 0;
          numberB = 0;
          whosPlaying = "O";
          await Future.delayed(Duration(milliseconds: 300));
          await showGameAlert(context, "TIM B GAGAL ❌",
              "Angka Yang Dipilih Sudah Ada di Papan.");
          return;
        } else {
          o.add(sum);
          readyA = false;
          readyB = false;
          numberA = 0;
          numberB = 0;
          whosPlaying = "X";

          checkBoard();
          await Future.delayed(Duration(milliseconds: 300));
          await showGameAlert(context, "TIM B BERHASIL ✔️",
              "Angka Yang Dipilih Berhasil Dimasukkan ke Papan.");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    print(x);
    print(o);

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
                          margin: EdgeInsets.symmetric(horizontal: 5),
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
                            color: const Color.fromARGB(50, 250, 240, 230),
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
                      margin: EdgeInsets.symmetric(horizontal: 5),
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
                        color: const Color.fromARGB(50, 250, 240, 230),
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
                    child: ScoreBoard(
                  text: "Tim A: ",
                  symbol: "X",
                  pointfor: pointforO,
                  symbolColor: const Color.fromARGB(255, 250, 99, 99),
                )),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
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
                  pointfor: pointforX,
                  symbolColor: const Color.fromARGB(255, 0, 215, 255),
                )),
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
                      print("telah ditekan ${index}");
                      if (board[index] == "") {
                        bool thisTurn = currentPlayer(turnCount);
                        setState(() {
                          board[index] = thisTurn ? "X" : "O";
                          numberA = 0;
                          numberB = 0;
                          turnCount++;
                          isXTurn = currentPlayer(
                              turnCount); // for showing current turn in UI
                        });
                      }
                    },
                    child: Block(
                      index: index,
                      boardIndex: board[index],
                      isVisible: _isVisible,
                      value: "${board[index] == "" ? index + 1 : board[index]}",
                    ),
                  );
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
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          changeNumber(index);
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Image.asset(
                          "assets/images/cartoon-${index + 1}.png",
                          fit: BoxFit.cover,
                        ),
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth * 0.25,
                  height: 100,
                  child: AnimatedButton(
                    textButton: "Tim  A\nSiap",
                    boxColor: const Color.fromARGB(255, 255, 99, 99),
                    onTap: () async {
                      if (isXTurn) {
                        if (numberA == 0) {
                          showGameAlert(context, "TIM A PILIH ULANG",
                              "Harus Memilih Angka 1 Sampai 9.");
                          return;
                        } else {
                          setState(() {
                            readyA = true;
                            turnCount++;
                            isXTurn = currentPlayer(turnCount);
                          });
                          await showGameAlert(context, "TIM A SIAP",
                              "Tim A telah Memilih angka.");
                          await calculateSum(readyA, readyB, numberA, numberB);
                          await Future.delayed(Duration(milliseconds: 300));
                          await showGameAlert(
                              context,
                              "TIM ${isXTurn ? "A" : "B"} MULAI",
                              "Tim ${isXTurn ? "A" : "B"} Dipersilahkan Memilih Angka.");
                        }
                      }
                    },
                  ),
                ),
                Container(
                  width: screenWidth * 0.4,
                  child: Row(
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
                                    "assets/images/cartoon-${numberA}.png",
                                    width: 60,
                                  )),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("X",
                            style: GoogleFonts.caveatBrush(
                                textStyle: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 250, 240, 230),
                                    fontSize: 40))),
                      ),
                      Opacity(
                        opacity: 0.7,
                        child: Container(
                            child: numberB == ""
                                ? Image.asset("assets/images/cartoon-0.png",
                                    width: 60)
                                : Image.asset(
                                    "assets/images/cartoon-${numberB}.png",
                                    width: 60,
                                  )),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: screenWidth * 0.25,
                  height: 100,
                  child: AnimatedButton(
                    textButton: "Tim B\nSiap",
                    boxColor: Color.fromARGB(255, 0, 215, 255),
                    onTap: () async {
                      if (!isXTurn) {
                        if (numberB == 0) {
                          showGameAlert(context, "TIM B PILIH ULANG",
                              "Harus Memilih Angka 1 Sampai 9.");
                          return;
                        } else {
                          print("sudah masuk B");
                          setState(() {
                            readyB = true;
                            turnCount++;
                            isXTurn = currentPlayer(turnCount);
                          });
                          await showGameAlert(context, "TIM B SIAP",
                              "Tim B telah Memilih angka.");
                          await calculateSum(readyA, readyB, numberA, numberB);
                          await Future.delayed(Duration(milliseconds: 300));
                          await showGameAlert(
                              context,
                              "TIM ${isXTurn ? "A" : "B"} MULAI",
                              "Tim ${isXTurn ? "A" : "B"} Dipersilahkan Memilih Angka.");
                        }
                      }
                    },
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
