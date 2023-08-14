import 'package:fitsaw/features/routine_list/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActiveRoutineNotifier extends StateNotifier<Routine?> {
  ActiveRoutineNotifier() : super(null);

  void set(Routine routine) {
    state = routine;
  }

  void clear() {
    state = null;
  }
}

final activeRoutineProvider =
    StateNotifierProvider<ActiveRoutineNotifier, Routine?>(
        (ref) => ActiveRoutineNotifier());
