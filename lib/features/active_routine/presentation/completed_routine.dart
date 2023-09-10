import 'dart:math' as math;

import 'package:fitsaw/features/active_routine/presentation/presentation.dart';
import 'package:fitsaw/features/active_routine/services/services.dart';
import 'package:fitsaw/features/history/domain/domain.dart';
import 'package:fitsaw/features/history/presentation/history_helper.dart';
import 'package:fitsaw/features/history/services/history_list_provider.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confetti/confetti.dart';
import 'package:realm/realm.dart';

class CompletedRoutine extends ConsumerStatefulWidget {
  const CompletedRoutine({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CompletedRoutineState();
}

class _CompletedRoutineState extends ConsumerState<CompletedRoutine> {
  late final ConfettiController _controller;
  String? elapsedTime;

  void _calculateStats() {}

  @override
  void initState() {
    super.initState();

    ref.read(totalTimeProvider).stop();
    elapsedTime = ref.read(totalTimeProvider.notifier).elapsed().toString();
    ref.read(totalTimeProvider).reset();

    List<String> splitDate =
        DateTime.now().toString().substring(0, 10).split('-');
    String formattedDate = '${splitDate[0]}${splitDate[1]}${splitDate[2]}';

    ref.read(historyListProvider).upsert(
          History(
            int.parse(formattedDate),
            summaries: [
              RoutineSummary(
                ObjectId(),
                elapsedTime: elapsedTime,
                historyRoutine: HistoryHelper.routineToHistory(
                  ref.read(activeRoutineProvider)!,
                ),
              ),
            ],
          ),
        );

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
    if (elapsedTime == null) {
      return const CircularProgressIndicator();
    } else {
      return Stack(
        alignment: Alignment.center,
        children: [
          ListView(
            children: [
              RoutineSummaryDisplay(
                elapsedTime: elapsedTime!,
                historyRoutine: HistoryHelper.routineToHistory(
                  ref.read(activeRoutineProvider)!,
                ),
                isHistory: false,
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
}
