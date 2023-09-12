import 'package:fitsaw/features/history/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActiveRoutineNotifier extends StateNotifier<HistoryRoutine?> {
  ActiveRoutineNotifier() : super(null);

  void set(HistoryRoutine? historyRoutine) {
    state = historyRoutine;
  }

  void clear() {
    state = null;
  }
}

final activeRoutineProvider =
    StateNotifierProvider<ActiveRoutineNotifier, HistoryRoutine?>(
        (ref) => ActiveRoutineNotifier());
