import 'package:bluff_chess/screens/mainscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.black87,
            onPrimary: Colors.white,
        ),
      ),
      ),
      home: MainScreen(),
    );
  }
}

//MatchScreen(whiteScoreTaken: 0, blackScoreTaken: 0, whiteTurn: true,),