import 'package:flutter/material.dart';

class RulebookP2 extends StatelessWidget {
  const RulebookP2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFA1887F),
      child: Center(
        child:
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "THE GOAL",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Padding(
                    padding: EdgeInsets.all(26.0),
                    child: Text( "The goal of the game is \n- To capture the opponent’s King \nor \n- To make remain 3 pieces of opponent.\n\n"
                        "A game consists of multiple sets and winner of a set scores 1. The player who scores 2, wins the game.\n\n"
                        "Under any condition, if a king is revealed, the set ends immediately and a player wins the set depends on what has happened.",
                      style: TextStyle(color: Colors.white, fontSize: 16),),
                  ),
                ]
            ),
      ),
    );
  }
}
