import 'package:flutter/material.dart';

class RulebookP3 extends StatelessWidget {
  const RulebookP3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenInfo = MediaQuery.of(context).size;
    final screenHeight = screenInfo.height;
    return Container(
        color: const Color(0xFFA1887F),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Text(
            "CLAIMING BLUFF",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
          ),
           Padding(
             padding: EdgeInsets.all(screenHeight/35.2),
             child: Text("After any move of opponent, you can claim bluff.\n\n"
                 "If you caught a bluffed move, that piece is captured."
                 " However, if the move was not a bluff, it stays there and you sacrifice one piece as penalty.",
               style: TextStyle(color: Colors.white, fontSize: 16),),
           ),
             SizedBox(
               height: screenHeight/18.3,
               width: screenHeight/18.3*2,
               child: ElevatedButton(
                 onPressed: (){},
                 child: Text("Claim\nBluff", style: TextStyle(fontSize: screenHeight/57.19),),
               ),
             ),
           const Padding(
             padding: EdgeInsets.all(26.0),
             child: Text("In sacrifice, the piece won't be revealed. So you can let escape your king from game secretly."
                 " If you dare to let escape it and you lost set, you lose the game immediately.\n\n"
                 "This rule may not be in the online version but it has a point on the same device/table.",
               style: TextStyle(color: Colors.white, fontSize: 16),
             ),
           ),
         ],
        ),
      ),
    );
  }
}
