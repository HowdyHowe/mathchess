import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Block extends StatefulWidget {
  final int index;
  final String boardIndex;
  final String value;
  final bool isVisible;
  const Block({
    super.key,
    required this.value,
    required this.index,
    required this.boardIndex,
    required this.isVisible,
  });

  @override
  State<Block> createState() => _BlockState();
}

class _BlockState extends State<Block> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(1),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: widget.index % 2 == 0
              ? const Color.fromARGB(255, 53, 47, 58)
              : const Color.fromARGB(255, 250, 240, 230)),
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
                      child: Text(
                        '${widget.index + 1}',
                        style: GoogleFonts.chewy(
                            textStyle: TextStyle(
                          fontSize: 15,
                          color: widget.index % 2 == 0
                              ? const Color.fromARGB(255, 250, 240, 230)
                              : const Color.fromARGB(255, 53, 47, 58),
                          fontWeight: FontWeight.w200,
                        )),
                      ),
                    ),
                  )
                : Text(
                    widget.boardIndex,
                    key: ValueKey(widget.boardIndex),
                    style: GoogleFonts.fredoka(
                      textStyle: TextStyle(
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
                    ),
                  )),
      ),
    );
  }
}
