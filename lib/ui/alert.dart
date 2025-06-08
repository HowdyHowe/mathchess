import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> showGameAlert(BuildContext context, String title, String message,
    {VoidCallback? onPressed}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: "Game Alert",
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, anim1, anim2) {
      return const SizedBox(); // Required but unused
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curvedValue = Curves.easeOutBack.transform(animation.value);

      return Transform.scale(
        scale: curvedValue,
        child: AlertDialog(
          backgroundColor: const Color.fromARGB(255, 53, 47, 68),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Center(
            child: Text(
              title,
              style: GoogleFonts.fredoka(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.fredoka(fontSize: 18, color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: onPressed ?? () => Navigator.pop(context),
              child:
                  const Text("OK", style: TextStyle(color: Colors.amberAccent)),
            )
          ],
        ),
      );
    },
  );
}
