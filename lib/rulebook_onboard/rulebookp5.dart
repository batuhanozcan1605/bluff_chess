import 'package:flutter/material.dart';

class RulebookP5 extends StatelessWidget {
  const RulebookP5({Key? key}) : super(key: key);

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
                          child: Image.asset('images/queen.png')),
                      Text("QUEEN'S REVENGE!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22)),
                      SizedBox(
                          width: 30,
                          child: Image.asset('images/queen.png')),
                    ]),
              ),
              Padding(
                padding: EdgeInsets.all(26),
                child: Text("If the Queen is captured, the piece that has captured it also dies.\n\nTherefore the queen is basically "
                    "like a suicide bomber.",
                  style: TextStyle(color: Colors.white, fontSize: 16),),
              ),
            ]

        ),
      ),
    );
  }
}
