import 'package:fitsaw/features/exercises/domain/domain.dart';
import 'package:fitsaw/features/routines/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';

final realmProvider = Provider<Realm>((ref) => Realm(Configuration.local(
    [Exercise.schema, Routine.schema, RoutineExerciseWrapper.schema])));
