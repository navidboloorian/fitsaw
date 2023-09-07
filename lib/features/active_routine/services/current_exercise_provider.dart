import 'package:fitsaw/features/active_routine/services/services.dart';
import 'package:fitsaw/features/routine_list/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentExerciseProvider = Provider<RoutineExerciseWrapper?>(
  (ref) {
    final exerciseIndex = ref.watch(currentExerciseIndexProvider);

    return ref.watch(activeRoutineProvider)!.exercises[exerciseIndex];
  },
);
