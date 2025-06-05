import 'package:flutter/material.dart';

class Block extends StatefulWidget {
  final int position;
  final String value;
  final Widget textwidget;
  const Block(
      {super.key,
      required this.position,
      required this.value,
      required this.textwidget});

  @override
  State<Block> createState() => _BlockState();
}

class _BlockState extends State<Block> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: widget.position % 2 == 0
              ? const Color.fromARGB(255, 53, 47, 58)
              : const Color.fromARGB(255, 250, 240, 230)),
      child: Center(
        child: widget.textwidget,
      ),
    );
  }
}
