import 'package:fitsaw/features/exercises/domain/domain.dart';
import 'package:fitsaw/shared/providers/providers.dart';
import 'package:realm/realm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExerciseListNotifier extends Notifier<RealmResults<Exercise>> {
  late final Realm _realm;

  @override
  RealmResults<Exercise> build() {
    _realm = ref.read(realmProvider);
    return ref.read(realmProvider).all<Exercise>();
  }

  void add(Exercise exercise) {
    _realm.write(() => _realm.add(exercise));
  }

  void update(Exercise exercise) {
    _realm.write(() => _realm.add(exercise, update: true));
  }

  void delete(Exercise exercise) {
    _realm.write(() => _realm.delete(exercise));
  }

  RealmResults<Exercise> get(ObjectId id) {
    return _realm.query<Exercise>('id == $id');
  }
}

final exerciseListProvider =
    NotifierProvider<ExerciseListNotifier, RealmResults<Exercise>>(
        () => ExerciseListNotifier());
