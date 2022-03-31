import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class ButtonSizeAnimationController {
  final AnimationController buttonController;
  final AnimationController contentController;
  final Animation<double> initialOpacityAnimation;
  final Animation<double> endOpacityAnimation;

  ButtonSizeAnimationController({
    required this.buttonController,
    required this.contentController,
  })  : initialOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(
                parent: contentController,
                curve: const Interval(0.1, 1, curve: Curves.fastOutSlowIn))),
        endOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(
                parent: contentController,
                curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

  Animation<Size> buttonSizeAnimation(
          {required Size begin, required Size end}) =>
      Tween<Size>(begin: begin, end: end).animate(CurvedAnimation(
          parent: buttonController, curve: Curves.fastOutSlowIn));

  dispose() {
    buttonController.dispose();
    contentController.dispose();
  }
}
