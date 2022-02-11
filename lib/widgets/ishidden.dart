import 'package:flutter/material.dart';
import 'dart:math' as math;

class IsHidden extends StatelessWidget {
  final bool hiddenWhite;
  final bool hiddenBlack;
  final String piece;
  final String color;
  final bool singleReveal;

  IsHidden({
    required this.hiddenWhite,
    required this.hiddenBlack,
    required this.piece,
    required this.color,
    required this.singleReveal
  });

  @override
  Widget build(BuildContext context) {
      if(singleReveal){
        if(color == 'white') {
          return Image.asset('images/' + piece + color + '.png');
        } else {
          return Transform(
              transform: Matrix4.rotationX(math.pi),
              alignment: Alignment.center,
              child: Image.asset('images/' + piece + color + '.png'));
        }
      }

      if(piece == 'pawn'){
        if(color == 'white'){
        return Image.asset('images/' + piece + color + '.png');
        }else{
          return Transform(
              transform: Matrix4.rotationX(math.pi),
              alignment: Alignment.center,
              child: Image.asset('images/' + piece + color + '.png'));
      }

    }else{
        if(color == 'white'){
          return hiddenWhite ? Image.asset('images/emptywhite.png') :
          Image.asset('images/' + piece + color + '.png') ;
        }else{
          return hiddenBlack ?  Image.asset('images/emptyblack.png') :
              Transform(
                transform: Matrix4.rotationX(math.pi),
                alignment: Alignment.center,
                child:Image.asset('images/' + piece + color + '.png')) ;
        }
      }
  }
}
