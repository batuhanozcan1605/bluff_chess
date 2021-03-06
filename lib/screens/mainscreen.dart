import 'package:bluff_chess/rulebook_onboard/rulebook_onboard.dart';
import 'package:bluff_chess/screens/matchscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  void showInfoAboutOnline() {

    Widget back = TextButton(
      onPressed: ()
      async {
      await launch('https://www.kickstarter.com/projects/batuhanozcan/bluff-chess');
      },
        child: Text("BACK US!", style: TextStyle(color: Colors.white),),);

    Widget ok = TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text("OK GOOD LUCK", style: TextStyle(color: Colors.white),),);

    Widget info = Text("We can not provide an online server for now but that's the next main goal of the project.\n\n"
        "This game can not survive without a community, therefore the next action has been planned as Kickstarter!\n"
        "If you liked the idea, if the project speaks to you, we will be waiting there for you.", 
        style: TextStyle(color: Colors.white));

    AlertDialog alert = AlertDialog(
      backgroundColor: Color(0xFF2F4858),
      title: Text("THAT'S THE GOAL OF THE PROJECT", style: TextStyle(color: Colors.white),),
      content: info,
      actions: [
        back,
      ],
    );
    
    showDialog(
      context: context, builder: (BuildContext context) {
      return alert;
    },
    );

  }

  @override
  Widget build(BuildContext context) {
    Size screenInfo = MediaQuery.of(context).size;
    final screenHeight = screenInfo.height;

    return Scaffold(
      backgroundColor: Color(0xFFA1887F),
      appBar: AppBar(
        backgroundColor: Color(0xA1887F),
        leadingWidth: 150,

         actions: [
           GestureDetector(
               onTap: () async {
                 await launch('https://discord.gg/2GqUd2VF');
               },
               child: SizedBox(
                   width: screenHeight/30.5,
                   height: screenHeight/30.5,
                   child: Image.asset('images/discord-mascot.png'))),
           IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const Rulebook()));
              },
              icon: Icon(Icons.book_rounded), color: Color(0xFFEDE9D0),),

         ]
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            color: Color(0xFFEDE9D0),
            child: Center(child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              child: SizedBox(
                  width: 40,
                  height: 40,
                  child: SvgPicture.asset('images/logo_front.svg')),
            ),),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => showInfoAboutOnline(),
                child: SizedBox(
                  height: screenHeight/4.58,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Card(
                      color: Color(0xFFEDE9D0),
                      child: Center(
                        child: Text(">       PLAY ONLINE       <",
                          style: TextStyle(color: Colors.brown[300], fontWeight: FontWeight.bold,),),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () =>
                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) =>
                          MatchScreen(whiteScoreTaken: 0, blackScoreTaken: 0, whiteStarted: true, memoryFactor: false,),)),
                child: SizedBox(
                  height: screenHeight/4.58,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Card(
                      color: Color(0xFFEDE9D0),
                      child: Center(
                        child: Text("PLAY ON THE SAME DEVICE",
                          style: TextStyle(color: Colors.brown[300], fontWeight: FontWeight.bold,),),
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
                  height: screenHeight/4.58,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Card(
                      color: Color(0xFFEDE9D0),
                      child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("PLAY ON THE SAME DEVICE",
                                style: TextStyle(color: Colors.brown[300], fontWeight: FontWeight.bold,),),
                              Text("Memory Factor: On",
                                style: TextStyle(color: Colors.brown[300],),),
                            ],
                          )
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]
      ),
    );
  }
}
