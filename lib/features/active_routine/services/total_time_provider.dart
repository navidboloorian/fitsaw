import 'package:flutter_riverpod/flutter_riverpod.dart';

class TotalTimeNotifier extends StateNotifier<Stopwatch> {
  TotalTimeNotifier() : super(Stopwatch());

  void start() {
    state.start();
  }

  void stop() {
    state.stop();
  }

  void reset() {
    state.reset();
  }

  Duration elapsed() {
    return state.elapsed;
  }
}

final totalTimeProvider = StateNotifierProvider<TotalTimeNotifier, Stopwatch>(
    (ref) => TotalTimeNotifier());
