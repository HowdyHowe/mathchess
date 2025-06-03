import 'package:flutter/material.dart';

class Block extends StatefulWidget {
  final int position;
  final String value;
  const Block({super.key, required this.position, required this.value});

  @override
  State<Block> createState() => _BlockState();
}

class _BlockState extends State<Block> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(1),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: widget.position % 2 == 0 ? Colors.grey : Colors.white),
      child: Center(
        child: Text("${widget.position + 1}",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w200,
            )),
      ),
    );
  }
}
