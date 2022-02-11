import 'package:flutter/material.dart';

class RulebookP6 extends StatelessWidget {
  const RulebookP6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xFFA1887F),
        child: Center(
          child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Text("MEMORY FACTOR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22)),
             Padding(
               padding: EdgeInsets.all(16.0),
               child: Icon(Icons.remove_red_eye),
             ),
             Padding(
               padding: EdgeInsets.all(26.0),
               child: Text("When you hold your finger on the eye icon, "
                   "you can see your secret pieces.\n\nThat's the play mode without memory factor."
                   "\n\nIf you want the memory as a factor in game, you can play with Memory Factor: On.",
                   style: TextStyle(color: Colors.white,fontSize: 16)),
             ),
            ],
          ),
        ),
    );
  }
}
