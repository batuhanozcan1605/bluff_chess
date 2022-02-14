import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

class Audios {
  final player = AudioCache();
  final List<String> moveSounds = ['move1.wav', 'move2.wav'];
  final _random = Random();
  int randomSound() => _random.nextInt(2);

  void playMoveSound() {
    print('girdi');
    int r = randomSound();
    print(r);
    print(moveSounds[r]);
    player.play(moveSounds[r]);
  }

}