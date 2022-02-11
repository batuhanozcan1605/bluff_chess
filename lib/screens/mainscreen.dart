import 'package:bluff_chess/rulebook_onboard/rulebook_onboard.dart';
import 'package:bluff_chess/screens/matchscreen.dart';
import 'package:flutter/material.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDE9D0),
      appBar: AppBar(
        backgroundColor: Colors.black87,
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const Rulebook()));
               },
              icon: Icon(Icons.book_rounded)),
        ],
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () =>
            Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) =>
                    MatchScreen(whiteScoreTaken: 0, blackScoreTaken: 0, whiteStarted: true, memoryFactor: false,),)),
            child: SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  color: Colors.brown[300],
                  child: Center(
                    child: Text("PLAY ON THE SAME DEVICE",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),),
                   ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) =>
                      MatchScreen(whiteScoreTaken: 0, blackScoreTaken: 0, whiteStarted: true, memoryFactor: true,),)),
            child: SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  color: Colors.brown[300],
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text("PLAY ON THE SAME DEVICE",
                           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),),
                         Text("Memory Factor: On",
                           style: TextStyle(color: Colors.white,),),
                       ],
                      )
                  ),
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}
