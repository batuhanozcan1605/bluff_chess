import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimateMove extends StatefulWidget {
  const AnimateMove({Key? key}) : super(key: key);

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
          child: SvgPicture.asset('images/movebishop.svg', color: Colors.grey,),
      ),
    );
  }
}