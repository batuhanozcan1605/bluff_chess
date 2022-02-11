import 'package:flutter/material.dart';

class EasyPiece extends StatelessWidget {
  final String piece;
  final String color;

  EasyPiece({required this.color, required this.piece});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: SizedBox(
          width: 50,
          height: 50,
          child: Image.asset('images/' + piece + color + '.png')),
    );
  }
}