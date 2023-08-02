import 'package:fitsaw/features/exercises/domain/domain.dart';
import 'package:fitsaw/features/routines/domain/domain.dart';

class PageArguments {
  final bool? isNew;
  final Exercise? exercise;
  final Routine? routine;

  PageArguments({this.isNew, this.exercise, this.routine});
}
