import 'package:fitsaw/features/exercise_list/domain/domain.dart';
import 'package:fitsaw/features/routine_list/domain/domain.dart';

class PageArguments {
  final bool? isNew;
  final Exercise? exercise;
  final Routine? routine;

  PageArguments({this.isNew, this.exercise, this.routine});
}
