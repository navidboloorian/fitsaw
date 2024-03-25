import 'package:fitsaw/features/history/domain/history.dart';
import 'package:realm/realm.dart';
import 'package:fitsaw/features/exercise_list/domain/domain.dart';

part 'routine.g.dart';

@RealmModel()
class $Routine {
  @PrimaryKey()
  @MapTo('_id')
  late final ObjectId id;

  late final String name;
  late final ObjectId? creator;
  late final String? description;
  late final double? rating = 0;
  late final int? downloads = 0;
  late final List<$RoutineExerciseWrapper> exercises;
  late final List<String> tags;
  late final List<ObjectId> reviewers = [];
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
