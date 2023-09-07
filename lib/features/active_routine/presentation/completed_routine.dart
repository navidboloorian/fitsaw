import 'dart:math' as math;

import 'package:fitsaw/shared/classes/classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confetti/confetti.dart';

class CompletedRoutine extends ConsumerStatefulWidget {
  const CompletedRoutine({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CompletedRoutineState();
}

class _CompletedRoutineState extends ConsumerState<CompletedRoutine> {
  late final ConfettiController _controller;

  void _calculateStats() {}

  @override
  void initState() {
    super.initState();

    _controller = ConfettiController(
      duration: const Duration(seconds: 1),
    );
    _controller.play();

    _calculateStats();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ListView(
          children: [],
        ),
        ConfettiWidget(
          confettiController: _controller,
          blastDirection: math.pi / 2,
          blastDirectionality: BlastDirectionality.explosive,
          numberOfParticles: 50,
          shouldLoop: false,
          colors: const [
            Palette.fitsawBlue,
            Palette.fitsawPurple,
            Palette.fitsawRed,
            Palette.fitsawOrange,
            Palette.fitsawGreen,
          ],
        ),
      ],
    );
  }
}
