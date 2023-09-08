import 'package:flutter_riverpod/flutter_riverpod.dart';

class TotalTimeNotifier extends StateNotifier<Stopwatch> {
  TotalTimeNotifier() : super(Stopwatch());

  void start() {
    state.start();
    print("HERE");
    print(state.isRunning);
  }

  void stop() {
    print(state.isRunning);
    print(state.elapsed);
    state.stop();
    print("EVERWHERE");
  }

  void reset() {
    state.reset();
    print("THERE");
  }

  Duration elapsed() {
    return state.elapsed;
  }
}

final totalTimeProvider = StateNotifierProvider<TotalTimeNotifier, Stopwatch>(
    (ref) => TotalTimeNotifier());
