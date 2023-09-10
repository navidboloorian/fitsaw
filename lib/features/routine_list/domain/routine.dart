import 'package:fitsaw/features/history/domain/history.dart';
import 'package:realm/realm.dart';
import 'package:fitsaw/features/exercise_list/domain/domain.dart';

part 'routine.g.dart';

@RealmModel()
class $Routine {
  @PrimaryKey()
  late final ObjectId id;

  late final String name;
  late final String? description;
  late final List<$RoutineExerciseWrapper> exercises;
  late final List<String> tags;
}

@RealmModel()
class $RoutineExerciseWrapper {
  late final $Exercise? exercise;
  late final $HistoryExercise? historyExercise;
  late final int? rest;
  late final int? sets;
  late final List<int> reps;
  late final List<int> times;
  late final List<int> weights;
}
