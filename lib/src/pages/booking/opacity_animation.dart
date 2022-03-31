import 'package:flutter/material.dart';

class OpacityAnimation extends AnimatedWidget {
  const OpacityAnimation(
      {Key? key, required this.child, required Listenable listenable})
      : super(key: key, listenable: listenable);

  final Widget child;
  Animation<double> get progress => listenable as Animation<double>;
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: progress.value,
      child: child,
    );
  }
}
