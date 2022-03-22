import 'package:bluff_chess/screens/mainscreen.dart';
import 'package:bluff_chess/widgets/animatemove.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RulebookP6 extends StatelessWidget {
  const RulebookP6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenInfo = MediaQuery.of(context).size;
    final screenHeight = screenInfo.height;
    final screenWidth = screenInfo.width;
    return Container(
        color: const Color(0xFFA1887F),
        child: Center(
          child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Text("MEMORY FACTOR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22)),
             Padding(
               padding: EdgeInsets.all(screenHeight/57.19),
               child: Icon(Icons.remove_red_eye),
             ),
             Padding(
               padding: EdgeInsets.all(screenHeight/35.2),
               child: Text("When you hold your finger on the eye icon, "
                   "you can see your secret pieces.\n\nThat's the play mode without memory factor."
                   "\n\nIf you want the memory as a factor in game, you can play with Memory Factor: On.",
                   style: TextStyle(color: Colors.white, fontSize: screenHeight/screenWidth > 1.94 ? 16 : 14)),
             ),
             Text("ANIMATION", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22)),
             Padding(
               padding: const EdgeInsets.only(top: 18.0),
               child: SizedBox(
                 height: screenHeight/18.3,
                 child: Stack(
                   alignment: Alignment.center,
                     children: [
                   Image.asset("images/emptywhite.png"),
                   AnimateMove(color: 'white', movetype: 'rook'),
                 ]),
               ),
             ),
             Padding(
               padding: EdgeInsets.all(screenHeight/35.2),
               child: Text("Animation appears as what kind of move have you performed. Which piece have you claimed, in other words.",
                   style: TextStyle(color: Colors.white,fontSize: 16)),
             ),
             Padding(
               padding: EdgeInsets.all(screenHeight/35.2),
               child: TextButton(
                 onPressed: () async {
                   final prefs = await SharedPreferences.getInstance();
                   prefs.setBool('showHome', true);
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
                 },
                 child: Text("Get Started",style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2F4858),fontSize: 26)),
                   ),
             ),
            ],
          ),
        ),
    );
  }
}
