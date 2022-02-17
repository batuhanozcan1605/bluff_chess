import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

class AnimateMove extends StatefulWidget {
  final String color;
  final String movetype;

  AnimateMove({required this.color, required this.movetype});

  @override
  State<AnimateMove> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<AnimateMove>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Padding(
          padding: EdgeInsets.all(8),
          child: widget.color == 'black' ? Transform(
              transform: Matrix4.rotationX(math.pi),
              alignment: Alignment.center,
              child: SvgPicture.asset('images/move' + widget.movetype + '.svg', color: Colors.grey,)) :
          SvgPicture.asset('images/move' + widget.movetype + '.svg', color: Colors.grey,),
      ),
    );
  }
}