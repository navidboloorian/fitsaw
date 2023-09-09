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
  late final $Routine? routine;
}
