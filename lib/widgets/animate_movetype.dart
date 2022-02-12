import 'package:flutter/material.dart';

//This widget is not in use now. It will animate the move type on the last moved piece.
class AnimateMoveType extends StatefulWidget {
  final bool triggerOpacity;
  const AnimateMoveType({Key? key, required this.triggerOpacity}) : super(key: key);

  @override
  _AnimateMoveTypeState createState() => _AnimateMoveTypeState();
}

class _AnimateMoveTypeState extends State<AnimateMoveType> {
  double opacityLevel = 1.0;

  void _changeOpacity() {
    setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
  }

  void _onEnd() {
    setState(() {
      opacityLevel = opacityLevel == 0 ? 0.0 : 1.0;
    });

  }
  
  @override
  Widget build(BuildContext context) {
    bool triggerOpacity = widget.triggerOpacity;
    if(triggerOpacity){
      setState(() {
        _changeOpacity();
      });
    }

    return AnimatedOpacity(
      opacity: opacityLevel,
      duration: const Duration(seconds: 3),
      onEnd: _onEnd,
      //child: SvgPicture.asset('images/moverook.svg', color: Colors.grey,),
    );
  }
}
