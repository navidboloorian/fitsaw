import 'dart:math' as math;

import 'package:fitsaw/features/active_routine/services/active_exercise_list_provider.dart';
import 'package:fitsaw/features/active_routine/services/active_routine_provider.dart';
import 'package:fitsaw/features/routine_list/domain/domain.dart';
import 'package:fitsaw/features/view_routine/services/routine_exercise_list_provider.dart';
import 'package:fitsaw/features/view_routine/services/services.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
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
  late int _exerciseCount;
  late int _repCount;
  late int _totalTime;

  void _calculateStats() {
    Set<String> exercises = {};

    _exerciseCount = 0;
    _repCount = 0;
    _totalTime = 0;

    ref.read(activeExerciseListProvider).length;

    for (RoutineExerciseWrapper routineExercise
        in ref.read(activeExerciseListProvider)) {
      if (routineExercise.exercise!.name != 'Rest') {
        exercises.add(routineExercise.exercise!.name);

        if (routineExercise.reps != null) {
          _repCount += routineExercise.reps!;
        } else {
          _totalTime += routineExercise.time!;
        }
      }
    }

    print(_totalTime);

    _exerciseCount = exercises.length;
  }

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
          children: [
            CustomContainer(
              child: Center(
                child: Column(
                  children: [
                    const Text(
                      'Congratulations!',
                      style: TextStyle(fontSize: 30),
                    ),
                    Text(
                      'You completed ${ref.read(activeRoutineProvider)!.name}! Keep up the great work!',
                      textAlign: TextAlign.center,
                    ),
                    const Divider(),
                    Text('$_exerciseCount exercises'),
                    Text('$_repCount reps'),
                    Text('$_totalTime seconds of timed exercises')
                  ],
                ),
              ),
            ),
          ],
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
