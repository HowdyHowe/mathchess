// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class AnimatedButton extends StatefulWidget {
//   final String textButton;
//   final Color boxColor;
//   const AnimatedButton(
//       {super.key, required this.boxColor, required this.textButton});

//   @override
//   State<AnimatedButton> createState() => _AnimatedButtonState();
// }

// class _AnimatedButtonState extends State<AnimatedButton> {
//   BorderRadiusGeometry _borderRadius = BorderRadius.circular(10);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: AnimatedContainer(
//         duration: Duration(milliseconds: 500),
//         curve: Curves.easeInOutBack,
//         width: 200,
//         height: 100,
//         decoration: BoxDecoration(
//           color: widget.boxColor,
//           borderRadius: _borderRadius,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 10,
//               spreadRadius: 3,
//               offset: Offset(3, 6),
//             )
//           ],
//         ),
//         child: Center(
//           child: Text(
//             widget.textButton,
//             textAlign: TextAlign.center,
//             style: GoogleFonts.caveatBrush(
//               textStyle: TextStyle(
//                 fontSize: 20,
//                 shadows: List.filled(
//                     1,
//                     Shadow(
//                       color: const Color.fromARGB(150, 53, 47, 58),
//                       offset: Offset(0, 0),
//                       blurRadius: 30,
//                     )),
//                 color: const Color.fromARGB(255, 250, 240, 230),
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedButton extends StatefulWidget {
  final String textButton;
  final Color boxColor;
  final VoidCallback? onTap;

  const AnimatedButton({
    super.key,
    required this.textButton,
    required this.boxColor,
    this.onTap,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );

    _scale = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() async {
    await _controller.forward();
    await _controller.reverse();
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: 200,
          height: 100,
          decoration: BoxDecoration(
            color: widget.boxColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 3,
                offset: Offset(3, 6),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            widget.textButton,
            textAlign: TextAlign.center,
            style: GoogleFonts.caveatBrush(
              textStyle: TextStyle(
                fontSize: 20,
                color: const Color.fromARGB(255, 250, 240, 230),
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: const Color.fromARGB(150, 53, 47, 58),
                    offset: Offset(0, 0),
                    blurRadius: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
