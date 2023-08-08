import 'package:fitsaw/features/routines/domain/domain.dart';
import 'package:fitsaw/shared/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';

/// Interfaces with routine collection in realm.
class RoutineList {
  late final Realm _realm;

  RoutineList(Ref ref) {
    _realm = ref.read(realmProvider);
  }

  /// Overload the "[]" operator to allow indexing.
  Routine operator [](int index) {
    return _realm.all<Routine>()[index];
  }

  int length() {
    return _realm.all<Routine>().length;
  }

  Stream<RealmResultsChanges<Routine>> changes() {
    return _realm.all<Routine>().changes;
  }

  void delete(Routine routine) {
    _realm.write(() => _realm.delete(routine));
  }

  void upsert(Routine routine) {
    _realm.write(() => _realm.add(routine, update: true));
  }
}

final routineListProvider = Provider<RoutineList>((ref) => RoutineList(ref));
