import 'package:flutter/material.dart';

class IfSimpleScaleAnimation extends StatefulWidget{
  const IfSimpleScaleAnimation({Key? key}) : super(key: key);
  @override
  IfSimpleScaleAnimationState createState() => IfSimpleScaleAnimationState();
}

class IfSimpleScaleAnimationState extends State<IfSimpleScaleAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double scale = 1.0;


  void changeScale() {
    setState(() => scale = scale == 1.0 ? 3.0 : 1.0);
  }

  double _size = 100.0;

  void scaleUp(double newSize) {
    setState(() {
      _size = newSize;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,)..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _controller,
    child: SizedBox(height: 100,
      width: 100,
      child: Image.asset('assets/images/if_taeyeon.jpeg'),));
  }
}