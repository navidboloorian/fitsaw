import 'package:fitsaw/shared/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitsaw/features/exercises/domain/domain.dart';
import 'package:realm/realm.dart';

// class used to interface with exercise collection in realm
class ExerciseList {
  late final Realm _realm;

  ExerciseList(Ref ref) {
    _realm = ref.read(realmProvider);
  }

  // overload the "[]" operator to allow indexing
  Exercise operator [](int index) {
    return _realm.all<Exercise>()[index];
  }

  int length() {
    return _realm.all<Exercise>().length;
  }

  // return stream of changes to exercise collection
  Stream<RealmResultsChanges<Exercise>> changes() {
    return _realm.all<Exercise>().changes;
  }

  void add(Exercise exercise) {
    _realm.write(() => _realm.add(exercise));
  }

  void delete(Exercise exercise) {
    _realm.write(() => _realm.delete(exercise));
  }

  void update(Exercise exercise) {
    _realm.write(() => _realm.add(exercise, update: true));
  }
}

final exerciseListProvider = Provider<ExerciseList>((ref) => ExerciseList(ref));
