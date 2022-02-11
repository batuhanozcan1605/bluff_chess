import 'package:flutter/material.dart';
import 'animate_movetype.dart';
import 'ishidden.dart';

class MyPiece extends StatelessWidget {
// pawn, rook, knight, bishop, queen, king, x (blank), o (available move)
  final String piece;

  // possible kill move
  final String killMove;

  // black, white
  final String color;

  // selected, unselected
  final String thisPieceIsSelected;

  // function
  final onTap;

  //hidden bool
  final bool hiddenBlack;
  final bool hiddenWhite;

  final bool singleReveal;

  MyPiece(
      {required this.piece,
      required this.color,
      required this.onTap,
      required this.hiddenBlack,
      required this.hiddenWhite,
      required this.thisPieceIsSelected,
      required this.killMove,
      required this.singleReveal,
      });

  @override
  Widget build(BuildContext context) {
    // possible kill move
    if (killMove == 'k') {
      return GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            color: Colors.red[200],
            padding: EdgeInsets.all(5),
            child: IsHidden(
            hiddenWhite: hiddenWhite,
            hiddenBlack: hiddenBlack,
            piece: piece,
            color: color,
            singleReveal: singleReveal),
          ),
        ),
      );
    }

    // available positions
    else if (piece == 'o') {
      return GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            color: Colors.green[200],
          ),
        ),
      );
    }

    // x is blank, !x there exists a piece there
    else if (piece != 'x') {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          color: thisPieceIsSelected == 'selected'
              ? Colors.green[200]
              : Colors.transparent,
          padding: EdgeInsets.all(10),
          child: IsHidden(
            hiddenWhite: hiddenWhite,
            hiddenBlack: hiddenBlack,
            piece: piece,
            color: color,
            singleReveal: singleReveal,),
        ),
      );
    }

    // if 'x' then return blank container
    return Container();
  }
}
