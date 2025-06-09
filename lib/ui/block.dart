import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Block extends StatefulWidget {
  final int index;
  final String boardIndex;
  // final String value;
  final bool isVisible;
  final int number;
  const Block({
    super.key,
    // required this.value,
    required this.index,
    required this.boardIndex,
    required this.isVisible,
    required this.number,
  });

  @override
  State<Block> createState() => _BlockState();
}

class _BlockState extends State<Block> {
  @override
  Widget build(BuildContext context) {
    bool isLightSquare = ((widget.index ~/ 6) + (widget.index % 6)) % 2 == 0;
    return Container(
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isLightSquare
            ? const Color.fromARGB(255, 250, 240, 230)
            : const Color.fromARGB(255, 53, 47, 58),
      ),
      child: Center(
        child: AnimatedSwitcher(
            duration: Duration(milliseconds: 250),
            switchInCurve: Curves.easeInOutBack,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: widget.boardIndex == ""
                ? AnimatedOpacity(
                    opacity: widget.isVisible ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 1500),
                    child: Opacity(
                      opacity: 0.4,
                      child: Text('${widget.number}',
                          style: TextStyle(
                            fontFamily: "CaveatBrush",
                            fontSize: 15,
                            color: isLightSquare
                                ? const Color.fromARGB(255, 53, 47, 58)
                                : const Color.fromARGB(255, 250, 240, 230),
                            fontWeight: FontWeight.w200,
                          )),
                    ),
                  )
                : Text(
                    widget.boardIndex,
                    key: ValueKey(widget.boardIndex),
                    style: TextStyle(
                      fontFamily: "Fredoka",
                      fontSize: 30,
                      shadows: List.filled(
                          1,
                          Shadow(
                            color: const Color.fromARGB(192, 68, 68, 68),
                            offset: Offset(0, 2),
                            blurRadius: 10,
                          )),
                      color: widget.boardIndex == "X"
                          ? const Color.fromARGB(255, 255, 99, 99)
                          : const Color.fromARGB(255, 0, 215, 255),
                      fontWeight: FontWeight.bold,
                    ),
                  )),
      ),
    );
  }
}
