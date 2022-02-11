import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RulebookP4 extends StatelessWidget {
  const RulebookP4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xFFA1887F),
        child: Center(
           child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          width: 30,
                          child: Image.asset('images/king.png')),
                      Text('CLAIMING KING', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22)),
                      SizedBox(
                          width: 30,
                          child: Image.asset('images/king.png')),
                    ]),
              ),
              Padding(
                padding: EdgeInsets.all(26),
                child: Text("After selected a piece, you may claim that the piece is a king.",
                  style: TextStyle(color: Colors.white, fontSize: 16),),
              ),

              Padding(
                padding: const EdgeInsets.all(26.0),
                child: SizedBox(
                  height: 50,
                  width: 160,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('Claim King'), Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset('images/king.png'),
                        )]),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(26),
                child: Text("Once you clicked the button, possible king moves appear and you may play as king.\n"
                    "\nIf you really played a king and opponent claims bluff. You win the set immediately.",
                  style: TextStyle(color: Colors.white, fontSize: 16),),
              ),
              ]
          ),
        ),
    );
  }
}
