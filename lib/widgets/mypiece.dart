import 'package:bluff_chess/widgets/animatemove.dart';
import 'package:flutter/material.dart';
import 'ishidden.dart';

class MyPiece extends StatelessWidget {
// pawn, rook, knight, bishop, queen, king, x (blank), o (available move)
  final String piece;

  // possible kill move
  final String killMove;

  final String moveType;

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

  final bool animation;

  MyPiece(
      {required this.piece,
      required this.color,
      required this.onTap,
      required this.hiddenBlack,
      required this.hiddenWhite,
      required this.thisPieceIsSelected,
      required this.killMove,
      required this.singleReveal,
        required this.animation,
        required this.moveType,
      });

  @override
  Widget build(BuildContext context) {
    Size screenInfo = MediaQuery.of(context).size;
    final screenWidth = screenInfo.width;
    final screenHeight = screenInfo.height;
    // possible kill move
    if (killMove == 'k') {
      return GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(screenWidth/82),
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
          padding: EdgeInsets.all(screenWidth/82),
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
          padding: EdgeInsets.all(screenWidth/50),
          child: Stack(
            children: [
                IsHidden(
                hiddenWhite: hiddenWhite,
                hiddenBlack: hiddenBlack,
                piece: piece,
                color: color,
                singleReveal: singleReveal,),
                animation ? AnimateMove(color: color, movetype: moveType,) : Center(),
              ],
          ),
        ),
      );
    }

    // if 'x' then return blank container
    return Container();
  }
}
