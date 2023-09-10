import 'package:fitsaw/features/routine_list/domain/domain.dart';
import 'package:realm/realm.dart';

part 'history.g.dart';

@RealmModel()
class _History {
  @PrimaryKey()
  late final int date;

  late final List<_RoutineSummary> summaries;
}

@RealmModel()
class _RoutineSummary {
  @PrimaryKey()
  late final ObjectId id;

  late final String? elapsedTime;
  late final _HistoryRoutine? historyRoutine;
}

@RealmModel()
class _HistoryRoutine {
  late final String name;
  late final String? description;
  late final List<$RoutineExerciseWrapper> exercises;
  late final List<String> tags;
}

@RealmModel()
class $HistoryExercise {
  late final String name;
  late final String? description;
  late final bool isTimed;
  late final bool isWeighted;
  late final List<String> tags;
}
