import 'package:bluff_chess/widgets/easypiece.dart';
import 'package:flutter/material.dart';

class PlayerSideBlack extends StatelessWidget {
  final List deadBlackPieces;

  PlayerSideBlack(this.deadBlackPieces);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        reverse: true,
        itemCount: deadBlackPieces.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return EasyPiece(
              piece: deadBlackPieces[index][0],
              color: deadBlackPieces[index][1],
            );
        });
  }
}