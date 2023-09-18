import 'package:fitsaw/features/exercise_list/domain/domain.dart';
import 'package:fitsaw/features/history/domain/history.dart';
import 'package:fitsaw/features/routine_list/domain/domain.dart';
import 'package:fitsaw/features/settings/domain/domain.dart';
import 'package:fitsaw/features/user_flow/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';

// The realm instance provided to the widget tree.
final realmProvider = Provider<Realm>((ref) {
  final configuration = Configuration.local(
    [
      Exercise.schema,
      Routine.schema,
      RoutineExerciseWrapper.schema,
      RoutineSummary.schema,
      History.schema,
      HistoryRoutine.schema,
      HistoryExercise.schema,
      SettingsInfo.schema,
      FitsawUser.schema
    ],
    schemaVersion: 3,
    shouldDeleteIfMigrationNeeded: true,
    migrationCallback: (migration, oldSchemaVersion) {
      final oldRoutineSummaries = migration.oldRealm.all('RoutineSummary');

      for (final oldRoutineSummary in oldRoutineSummaries) {
        final newRoutineSummary =
            migration.findInNewRealm<RoutineSummary>(oldRoutineSummary);

        if (newRoutineSummary == null) {
          continue;
        }

        final oldElapsedTime =
            oldRoutineSummary.dynamic.get<int>('elapsedTime');
        newRoutineSummary.elapsedTime = oldElapsedTime.toString();
      }
    },
  );

  return Realm(configuration);
});
