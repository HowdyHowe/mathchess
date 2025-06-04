import 'package:flutter/material.dart';

class Block extends StatefulWidget {
  final int position;
  final String value;
  final TextStyle textstyle;
  const Block({super.key, required this.position, required this.value, required this.textstyle});

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
          color: widget.position % 2 == 0 ? Colors.grey[600] : Colors.white),
      child: Center(
        child: Text("${widget.value}",
            style: widget.textstyle),
      ),
    );
  }
}
