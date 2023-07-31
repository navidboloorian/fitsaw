import 'package:fitsaw/shared/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitsaw/features/exercises/domain/domain.dart';
import 'package:realm/realm.dart';

/// Interfaces with exercise collection in realm.
class ExerciseList {
  late final Realm _realm;

  ExerciseList(Ref ref) {
    _realm = ref.read(realmProvider);
  }

  /// Overload the "[]" operator to allow indexing.
  Exercise operator [](int index) {
    return _realm.all<Exercise>()[index];
  }

  int length() {
    return _realm.all<Exercise>().length;
  }

  Stream<RealmResultsChanges<Exercise>> changes() {
    return _realm.all<Exercise>().changes;
  }

  void delete(Exercise exercise) {
    _realm.write(() => _realm.delete(exercise));
  }

  void upsert(Exercise exercise) {
    _realm.write(() => _realm.add(exercise, update: true));
  }
}

final exerciseListProvider = Provider<ExerciseList>((ref) => ExerciseList(ref));
