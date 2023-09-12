import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimationControllerNotifier extends StateNotifier<AnimationController?> {
  AnimationControllerNotifier() : super(null);

  void initialize(dynamic vsync) {
    state ??= AnimationController(vsync: vsync);
  }

  void setDuration(Duration duration) {
    state!.duration = duration;
  }

  void stop() {
    state!.stop();
  }

  void start() {
    state!.reverse();
  }

  void reset(int duration) {
    state!.value = duration.toDouble();
    state!.duration = Duration(seconds: duration);

    if (!isStopped()) {
      start();
    }
  }

  bool isStopped() {
    return !state!.isAnimating;
  }
}

final animationControllerProvider =
    StateNotifierProvider<AnimationControllerNotifier, AnimationController?>(
        (ref) => AnimationControllerNotifier());
