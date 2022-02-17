import 'package:flutter/material.dart';

class RulebookP1 extends StatelessWidget {
  const RulebookP1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Color(0xFFA1887F),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "BLUFF CHESS",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
                ),
                Padding(
                  padding: EdgeInsets.all(26.0),
                  child: Text("Bluff chess is a chess-based game that includes bluff mechanics.\n\n"
                      "Non-pawn pieces start to game face-down and they may act like another piece as long as they have not caught. "
                      "So, each move claims a piece.\n"
                      "\nYou can not claim queen beacuse its move already consists of rook and bishop. Queen has a different role. See Page 5.",
                    style: TextStyle(color: Colors.white, fontSize: 16),),
                ),
                Padding(
                  padding: const EdgeInsets.all(26.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset('images/emptywhite.png')),
                      SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset('images/emptyblack.png')),
                      SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset('images/pawnwhite.png')),
                      SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset('images/pawnblack.png')),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(26.0),
                  child: Text("Pawns are fixed walls that can not move or capture. They are always visible. The other pieces are:",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(26.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset('images/rookwhite.png')),
                      SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset('images/knightwhite.png')),
                      SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset('images/bishopwhite.png')),
                      SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset('images/kingwhite.png')),
                      SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset('images/queenwhite.png')),

                    ],
                  ),
                ),
              ],
            ),
          ),
    );

  }
}

