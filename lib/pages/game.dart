import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
  Widget build(BuildContext context) {
    // List x = [];
    // List o = [];
    // final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // // tombol kembali
        // GestureDetector(
        //   onTap: () {
        //     Navigator.pop(context);
        //   },
        //   child: Container(
        //       margin: EdgeInsets.all(5),
        //       height: 50,
        //       width: 50,
        //       decoration: BoxDecoration(
        //         color: Colors.purple,
        //         borderRadius: BorderRadius.circular(10),
        //       ),
        //       child: Center(
        //         child: Text(
        //           "<",
        //           style: TextStyle(color: Colors.white, fontSize: 20),
        //         ),
        //       )),
        // ),

        // papan permainan
        Center(
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 9,
            ),
            itemCount: 81,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: index % 2 == 0 ? Colors.grey : Colors.white),
                    child: Center(
                      child: Text("${index + 1}",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                          )),
                    ),
                  ));
            },
          ),
        ),

        // pemain 1
        Center(
          child: Container(
            margin: EdgeInsets.all(10),
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                "Mulai",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
