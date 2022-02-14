import 'package:audioplayers/audioplayers.dart';

class Audios {
  final player = AudioCache();

  void playMoveSound() {
    player.play('move1.wav');
  }

}