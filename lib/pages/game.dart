// IMPORTANT
// BASIS NOMOR YANG DIGUNAKAN ADALAH DARI 1 BUKAN DARI 0.
// SELALU SESUAIKAN CODE NYA

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:super_tic_tac_toe/pages/scoreviewlast.dart';
import 'package:super_tic_tac_toe/structure/list.dart';
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
  bool isXTurn = false;
  bool _isVisible = true;
  String textCount = "O";
  String whosPlaying = "X";
  late Timer _timer;
  double _timeLeft = 60.0;
  Timer? _clockTimer;
  List<String> board = List.filled(36, "");

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
        context,
        "TIM ${isXTurn ? "A" : "B"} MULAI",
        "Tim ${isXTurn ? "A" : "B"} Dipersilahkan Memilih Angka",
        titleColor: textCount == "X"
            ? const Color.fromARGB(255, 255, 99, 99)
            : const Color.fromARGB(255, 0, 215, 255),
      );
      startTimer();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _clockTimer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _clockTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        _timeLeft -= 0.1;
        if (_timeLeft <= 0) {
          _clockTimer?.cancel();
          _timeLeft = 0;
          onTimeUp();
        }
      });
    });
  }

  void resetTimer() {
    _clockTimer?.cancel();
    setState(() {
      _timeLeft = 60.0;
    });
    startTimer();
  }

  void onTimeUp() async {
    var team = whosPlaying == "X" ? "A" : "B";
    final random = Random();
    int randomNumber = random.nextInt(8);
    setState(() {
      changeNumber(randomNumber + 1);
      // textCount == "X" ? readyA = true : readyB = true;
      turnCount++;
      isXTurn = !isXTurn;
      textCount == "X" ? textCount = "O" : textCount = "X";
    });

    await showGameAlert(
        context, "WAKTU HABIS", "Akan Dipilih Waktu Acak Untuk Tim ${team}.");
    await Future.delayed(Duration(milliseconds: 300));
    await showGameAlert(context, "TIM ${isXTurn ? "A" : "B"} MULAI",
        "Tim ${isXTurn ? "A" : "B"} Dipersilahkan Memilih Angka.");
    await calculateSum(numberA, numberB);
  }

  void checkFullBoard() async {
    bool hasEmpty = board.contains("");
    if (!hasEmpty) {
      await showGameAlert(
          context, "PERMAINAN BERAKHIR", "Semua Kotak sudah penuh");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ScoreViewLast(pointforO: pointforO, pointforX: pointforX),
        ),
      );
    }
  }

  void changeNumber(int index) {
    if (textCount == "X") {
      numberA = index + 1;
    }
    if (textCount == "O") {
      numberB = index + 1;
    }
    print(x);
    print(o);
    print("turncountnya adalah ${turnCount}");
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

  Future<void> calculateSum(int numA, int numB) async {
    int sum = (numA * numB);
    if (sum != 0) {
      int position = customNumbers.indexOf(sum);

      if (x.contains(position) || o.contains(position)) {
        await Future.delayed(Duration(milliseconds: 300));
        await showGameAlert(
            context,
            "TIM ${whosPlaying == "X" ? "A" : "B"} GAGAL ❌",
            "Angka Yang Dipilih Sudah Ada di Papan.");
      } else {
        if (whosPlaying == "X") {
          if (board[position] == "") {
            x.add(position);
            setState(() {
              board[position] = "X";
            });
          }
          await checkPoint();
          await Future.delayed(Duration(milliseconds: 300));
          await showGameAlert(context, "TIM A BERHASIL ✔️",
              "Angka Yang Dipilih Berhasil Dimasukkan ke Papan.");
        }
        if (whosPlaying == "O") {
          if (board[position] == "") {
            o.add(position);
            setState(() {
              board[position] = "O";
            });
            await checkPoint();
            await Future.delayed(Duration(milliseconds: 300));
            await showGameAlert(context, "TIM B BERHASIL ✔️",
                "Angka Yang Dipilih Berhasil Dimasukkan ke Papan.");
          } else {
            await showGameAlert(
              context,
              "TIM ${whosPlaying == "X" ? "A" : "B"} GAGAL ❌",
              "Angka Yang Dipilih Sudah Ada di Papan.",
            );
          }
        }
      }
      // readyA = false;
      // readyB = false;
      whosPlaying = whosPlaying == "X" ? "O" : "X";
    }
    setState(() {
      _timeLeft = 60.0;
    });
    resetTimer();
    checkFullBoard();
  }

  Future<void> horizontal(var i, usedList) async {
    // ANGKA DARI 1 - 6
    if (i + 1 <= 5 &&
        i + 1 >= 0 &&
        usedList.contains(i + 1) &&
        usedList.contains(i + 2)) {
      setState(() {
        board[i] = whosPlaying == "X" ? "🟥" : "🟦";
        board[i + 1] = whosPlaying == "X" ? "🟥" : "🟦";
        board[i + 2] = whosPlaying == "X" ? "🟥" : "🟦";
      });
      usedList.removeWhere((item) => [i, (i + 1), (i + 2)].contains(item));
      whosPlaying == "X" ? pointforX++ : pointforO++;
      print("Kombinasi Mendatar Pada Angka ${i}, ${i + 1}, ${i + 2}");
    }
    // ANGKA DARI 7 - 12
    if (i + 1 <= 11 &&
        i + 1 >= 6 &&
        usedList.contains(i + 1) &&
        usedList.contains(i + 2)) {
      setState(() {
        board[i] = whosPlaying == "X" ? "🟥" : "🟦";
        board[i + 1] = whosPlaying == "X" ? "🟥" : "🟦";
        board[i + 2] = whosPlaying == "X" ? "🟥" : "🟦";
      });
      usedList.removeWhere((item) => [i, (i + 1), (i + 2)].contains(item));
      whosPlaying == "X" ? pointforX++ : pointforO++;
      print("Kombinasi Mendatar Pada Angka ${i}, ${i + 1}, ${i + 2}");
    }
    // ANGKA DARI 13 - 18
    if (i + 1 <= 17 &&
        i + 1 >= 12 &&
        usedList.contains(i + 1) &&
        usedList.contains(i + 2)) {
      setState(() {
        board[i] = whosPlaying == "X" ? "🟥" : "🟦";
        board[i + 1] = whosPlaying == "X" ? "🟥" : "🟦";
        board[i + 2] = whosPlaying == "X" ? "🟥" : "🟦";
      });
      usedList.removeWhere((item) => [i, (i + 1), (i + 2)].contains(item));
      whosPlaying == "X" ? pointforX++ : pointforO++;
      print("Kombinasi Mendatar Pada Angka ${i}, ${i + 1}, ${i + 2}");
    }
    // ANGKA DARI 19 - 24
    if (i + 1 <= 23 &&
        i + 1 >= 18 &&
        usedList.contains(i + 1) &&
        usedList.contains(i + 2)) {
      setState(() {
        board[i] = whosPlaying == "X" ? "🟥" : "🟦";
        board[i + 1] = whosPlaying == "X" ? "🟥" : "🟦";
        board[i + 2] = whosPlaying == "X" ? "🟥" : "🟦";
      });
      usedList.removeWhere((item) => [i, (i + 1), (i + 2)].contains(item));
      whosPlaying == "X" ? pointforX++ : pointforO++;
      print("Kombinasi Mendatar Pada Angka ${i}, ${i + 1}, ${i + 2}");
    }
    // ANGKA DARI 25 - 30
    if (i + 1 <= 29 &&
        i + 1 >= 24 &&
        usedList.contains(i + 1) &&
        usedList.contains(i + 2)) {
      setState(() {
        board[i] = whosPlaying == "X" ? "🟥" : "🟦";
        board[i + 1] = whosPlaying == "X" ? "🟥" : "🟦";
        board[i + 2] = whosPlaying == "X" ? "🟥" : "🟦";
      });
      usedList.removeWhere((item) => [i, (i + 1), (i + 2)].contains(item));
      whosPlaying == "X" ? pointforX++ : pointforO++;
      print("Kombinasi Mendatar Pada Angka ${i}, ${i + 1}, ${i + 2}");
    }
    // ANGKA DARI 31 - 36
    if (i + 1 <= 35 &&
        i + 1 >= 30 &&
        usedList.contains(i + 1) &&
        usedList.contains(i + 2)) {
      setState(() {
        board[i] = whosPlaying == "X" ? "🟥" : "🟦";
        board[i + 1] = whosPlaying == "X" ? "🟥" : "🟦";
        board[i + 2] = whosPlaying == "X" ? "🟥" : "🟦";
      });
      usedList.removeWhere((item) => [i, (i + 1), (i + 2)].contains(item));
      whosPlaying == "X" ? pointforX++ : pointforO++;
      print("Kombinasi Mendatar Pada Angka ${i}, ${i + 1}, ${i + 2}");
    }
  }

  Future<void> checkPoint() async {
    var usedList = whosPlaying == "X" ? x : o;

    for (var i in List.from(usedList)) {
      // KOMBINASI MENDATAR
      await horizontal(i, usedList);

      // KOMBINASI MENURUN
      if (vertical.contains(i)) {
        var i2 = usedList.contains(i + 6);
        if (i2) {
          var i3 = usedList.contains(i + 12);
          if (i3) {
            print("Ada Kombinasi Menurun.");
            setState(() {
              board[i] = whosPlaying == "X" ? "🟥" : "🟦";
              board[i + 6] = whosPlaying == "X" ? "🟥" : "🟦";
              board[i + 12] = whosPlaying == "X" ? "🟥" : "🟦";
            });
            usedList
                .removeWhere((item) => [i, (i + 6), (i + 12)].contains(item));
            whosPlaying == "X" ? pointforX++ : pointforO++;
          }
        }
      }

      for (var i in List.from(usedList)) {
        // KOMBINASI DIAGONAL KANAN
        if (rightDiagonal.contains(i)) {
          var i2 = usedList.contains(i + 7);
          if (i2) {
            print(i2);
            var i3 = usedList.contains(i + 14);
            if (i3) {
              print("Ada Diagonal Kanan");
              setState(() {
                board[i] = whosPlaying == "X" ? "🟥" : "🟦";
                board[i + 7] = whosPlaying == "X" ? "🟥" : "🟦";
                board[i + 14] = whosPlaying == "X" ? "🟥" : "🟦";
              });
              usedList
                  .removeWhere((item) => [i, (i + 7), (i + 14)].contains(item));
              whosPlaying == "X" ? pointforX++ : pointforO++;
            }
          }
        }
      }
      // KOMBINASI DIAGONAL KIRI
      if (leftDiagonal.contains(i)) {
        var i2 = usedList.contains(i + 5);
        if (i2) {
          var i3 = usedList.contains(i + 10);
          if (i3) {
            print("Ada kombinasi diagonal kiri.");
            setState(() {
              board[i] = whosPlaying == "X" ? "🟥" : "🟦";
              board[i + 5] = whosPlaying == "X" ? "🟥" : "🟦";
              board[i + 10] = whosPlaying == "X" ? "🟥" : "🟦";
            });
            usedList
                .removeWhere((item) => [i, (i + 5), (i + 10)].contains(item));
            whosPlaying == "X" ? pointforX++ : pointforO++;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 53, 47, 68),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                  ],
                ),
                Text(
                  whosPlaying == "X" ? "Poin Tim A (X)" : "Poin Tim B (O)",
                  style: GoogleFonts.fredoka(
                    textStyle: TextStyle(
                      fontSize: 30,
                      shadows: List.filled(
                          1,
                          Shadow(
                            color: const Color.fromARGB(25, 250, 240, 230),
                            offset: Offset(0, 0),
                            blurRadius: 15,
                          )),
                      color: whosPlaying == "X"
                          ? const Color.fromARGB(255, 255, 99, 99)
                          : const Color.fromARGB(255, 0, 215, 255),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/game");
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
              _timeLeft.toStringAsFixed(2),
              style: GoogleFonts.fredoka(
                textStyle: TextStyle(
                  fontSize: 20,
                  shadows: [
                    Shadow(
                      color: Color.fromARGB(25, 250, 240, 230),
                      offset: Offset(0, 2),
                      blurRadius: 10,
                    )
                  ],
                  color: whosPlaying == "X"
                      ? Color.fromARGB(255, 255, 99, 99)
                      : Color.fromARGB(255, 0, 215, 255),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: screenWidth * 0.3,
                    height: 100,
                    child: ScoreBoard(
                      text: "Tim A: ",
                      symbol: "X",
                      pointfor: pointforX,
                      symbolColor: const Color.fromARGB(255, 250, 99, 99),
                    )),
                Container(
                  width: screenWidth * 0.3,
                  child: Center(
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
                ),
                Container(
                    width: screenWidth * 0.3,
                    height: 100,
                    child: ScoreBoard(
                      text: "Tim B: ",
                      symbol: "O",
                      pointfor: pointforO,
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
                  crossAxisCount: 6,
                ),
                itemCount: 36,
                itemBuilder: (BuildContext context, int index) {
                  return Block(
                    index: index,
                    number: customNumbers[index],
                    boardIndex: board[index],
                    isVisible: _isVisible,
                    // value: "${board[index] == "" ? index + 1 : board[index]}",
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
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth * 0.2,
                  height: 75,
                  child: !isXTurn
                      ? Opacity(opacity: 0.0)
                      : AnimatedButton(
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
                                  // readyA = true;
                                  turnCount++;
                                  isXTurn = !isXTurn;
                                  textCount = "O";
                                });
                                await showGameAlert(context, "TIM A SIAP",
                                    "Tim A telah Memilih angka.");
                                await Future.delayed(
                                    Duration(milliseconds: 300));
                                await showGameAlert(
                                    context,
                                    "TIM ${isXTurn ? "A" : "B"} MULAI",
                                    "Tim ${isXTurn ? "A" : "B"} Dipersilahkan Memilih Angka.");
                                await calculateSum(numberA, numberB);
                              }
                            }
                          },
                        ),
                ),
                Container(
                  width: screenWidth * 0.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Opacity(
                        opacity: 0.7,
                        child: Container(
                            child: numberA == ""
                                ? Image.asset("assets/images/cartoon-0.png",
                                    width: 50)
                                : Image.asset(
                                    "assets/images/cartoon-${numberA}.png",
                                    width: 50,
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
                                    width: 50)
                                : Image.asset(
                                    "assets/images/cartoon-${numberB}.png",
                                    width: 50,
                                  )),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: screenWidth * 0.2,
                  height: 75,
                  child: isXTurn
                      ? Opacity(opacity: 0.0)
                      : AnimatedButton(
                          textButton: "Tim B\nSiap",
                          boxColor: Color.fromARGB(255, 0, 215, 255),
                          onTap: () async {
                            if (!isXTurn) {
                              if (numberB == 0) {
                                showGameAlert(context, "TIM B PILIH ULANG",
                                    "Harus Memilih Angka 1 Sampai 9.");
                                return;
                              } else {
                                setState(() {
                                  // readyB = true;
                                  turnCount++;
                                  isXTurn = !isXTurn;
                                  textCount = "X";
                                });
                                await showGameAlert(context, "TIM B SIAP",
                                    "Tim B telah Memilih angka.");
                                await Future.delayed(
                                    Duration(milliseconds: 300));
                                await showGameAlert(
                                    context,
                                    "TIM ${isXTurn ? "A" : "B"} MULAI",
                                    "Tim ${isXTurn ? "A" : "B"} Dipersilahkan Memilih Angka.");
                                await calculateSum(numberA, numberB);
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
