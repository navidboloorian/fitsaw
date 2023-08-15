import 'package:fitsaw/features/active_routine/services/services.dart';
import 'package:fitsaw/features/routine_list/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentExerciseProvider = Provider<RoutineExerciseWrapper?>(
  (ref) {
    final index = ref.watch(currentExerciseIndexProvider);
    final activeExerciseList = ref.watch(activeExerciseListProvider);

    return activeExerciseList[index];
  },
);
