import 'package:fitsaw/shared/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitsaw/features/history/domain/domain.dart';
import 'package:realm/realm.dart';

class HistoryList {
  late final Realm _realm;

  HistoryList(Ref ref) {
    _realm = ref.read(realmProvider);
  }

  Stream<RealmResultsChanges<History>> changes() {
    return _realm.all<History>().changes;
  }

  /// Overload the "[]" operator to allow indexing.
  History operator [](int index) {
    return _realm.query<History>('TRUEPREDICATE SORT(date DESC)')[index];
  }

  int length() {
    return _realm.all<History>().length;
  }

  void upsert(History history) {
    RealmResults<History> preexistingHistory =
        _realm.query('date == ${history.date}');

    if (preexistingHistory.isEmpty) {
      _realm.write(() => _realm.add(history, update: true));
    } else {
      _realm.write(
        () => preexistingHistory[0].summaries.add(history.summaries[0]),
      );
    }
  }
}

final historyListProvider = Provider<HistoryList>((ref) => HistoryList(ref));
