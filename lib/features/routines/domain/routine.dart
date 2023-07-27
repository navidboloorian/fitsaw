import 'package:realm/realm.dart';
import 'package:fitsaw/features/exercises/domain/domain.dart';

part 'routine.g.dart';

@RealmModel()
class _Routine {
  @PrimaryKey()
  late final ObjectId id;

  late final String name;
  late final String? description;
  late final List<_RoutineExerciseWrapper> exercises;
  late final List<String> tags;
}

@RealmModel()
class _RoutineExerciseWrapper {
  late final $Exercise? exercise;
  late final int sets;
  late final int? reps;
  late final int? time;
  late final int? rest;
}
