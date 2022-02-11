import 'package:bluff_chess/widgets/easypiece.dart';
import 'package:flutter/material.dart';

class PlayerSideWhite extends StatelessWidget {
  final List deadWhitePieces;

  PlayerSideWhite(this.deadWhitePieces);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              reverse: true,
              itemCount: deadWhitePieces.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                return EasyPiece(
                  piece: deadWhitePieces[index][0],
                  color: deadWhitePieces[index][1],

                );
              }),
    );
  }
}
