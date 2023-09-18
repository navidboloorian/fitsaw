import 'package:fitsaw/features/exercise_list/domain/domain.dart';
import 'package:fitsaw/features/routine_list/domain/domain.dart';
import 'package:realm/realm.dart';

part 'fitsaw_user.g.dart';

@RealmModel()
class _FitsawUser {
  @PrimaryKey()
  late final ObjectId id;

  late final List<$Routine> routines;
  late final List<$Exercise> exercises;
  late final String? email;
  late final String? password;
  late final String? displayName;
  late final String? profilePictureURL;
  late final double? reputation;
  late final int? totalDownloads;
}
