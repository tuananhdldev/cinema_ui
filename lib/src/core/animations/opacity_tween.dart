import 'package:flutter/material.dart';

class OpacityTween extends StatelessWidget {
  const OpacityTween(
      {Key? key,
      required this.child,
      this.curve = Curves.easeInToLinear,
      this.duration = const Duration(milliseconds: 1000),
      this.begin = 0.2})
      : super(key: key);
  final Widget child;
  final Duration duration;
  final Curve curve;
  final double begin;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      child: child,
      tween: Tween(begin: begin, end: 1.0),
      curve: curve,
      duration: duration,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
    );
  }
}
