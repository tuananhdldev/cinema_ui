import 'package:flutter/material.dart';
import 'package:move_app/src/core/constants/app_colors.dart';
import 'package:move_app/src/core/constants/constants.dart';

class SlideUpTween extends StatelessWidget {
  const SlideUpTween(
      {Key? key,
      this.duration = const Duration(milliseconds: 1000),
      this.curve = Curves.easeInCubic,
      required this.begin,
      required this.child})
      : super(key: key);
  final Offset begin;
  final Duration duration;
  final Widget child;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween(begin: begin, end: const Offset(0, 0)),
      curve: curve,
      duration: duration,
      builder: (context, value, child) {
        return Transform.translate(
          offset: value,
          child: child,
        );
      },
      child: child,
    );
  }
}
