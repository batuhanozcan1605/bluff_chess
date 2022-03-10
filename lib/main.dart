import 'package:bluff_chess/rulebook_onboard/rulebook_onboard.dart';
import 'package:bluff_chess/screens/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;

  runApp(MyApp(showHome: showHome));
}

class MyApp extends StatelessWidget {
  final bool showHome;

  const MyApp({required this.showHome});

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
      home: showHome ? MainScreen() : Rulebook(),
    );
  }
}

//MatchScreen(whiteScoreTaken: 0, blackScoreTaken: 0, whiteTurn: true,),