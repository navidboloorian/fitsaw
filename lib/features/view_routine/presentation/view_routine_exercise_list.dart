import 'package:fitsaw/features/exercise_list/domain/domain.dart';
import 'package:fitsaw/features/view_routine/domain/domain.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitsaw/features/view_routine/services/services.dart';
import 'package:fitsaw/features/view_routine/presentation/presentation.dart';

class ViewRoutineExerciseList extends ConsumerStatefulWidget {
  const ViewRoutineExerciseList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ViewRoutineExerciseListState();
}

class _ViewRoutineExerciseListState
    extends ConsumerState<ViewRoutineExerciseList> {
  Future<void> _viewExercise(BuildContext context, Exercise exercise) async {
    await Navigator.pushNamed(
      context,
      'view_exercise',
      arguments: PageArguments(
        exercise: exercise,
        isNew: false,
      ),
    );

    if (!mounted) return;

    // update the routine list with the new exercise
    ref
        .read(routineExerciseListProvider.notifier)
        .set(ref.read(routineExerciseListProvider));
  }

  List<Widget> _generateRoutineExerciseList() {
    List<Widget> list = [];

    for (int i = 0; i < ref.watch(routineExerciseListProvider).length; i++) {
      RoutineExerciseController routineExercise =
          ref.watch(routineExerciseListProvider)[i];

      list.add(
        Dismissible(
          key: UniqueKey(),
          onDismissed: (DismissDirection direction) {
            ref.read(routineExerciseListProvider.notifier).removeAt(i);
          },
          child: RoutineExerciseListItem(
            routineExercise: routineExercise,
            onClick: _viewExercise,
          ),
        ),
      );
    }

    return list;
  }

  // Disables shadow and other default stylings upon dragging an element in the
  // reorderable list.
  Widget _reorderableDecorator(
      Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Material(
          elevation: 0,
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          child: child,
        );
      },
      child: child,
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex--;
    }

    final RoutineExerciseController routineExercise =
        ref.read(routineExerciseListProvider.notifier).removeAt(oldIndex);

    ref
        .read(routineExerciseListProvider.notifier)
        .insert(newIndex, routineExercise);
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        children: [
          ReorderableListView(
            physics: const NeverScrollableScrollPhysics(),
            proxyDecorator: _reorderableDecorator,
            shrinkWrap: true,
            onReorder: (oldIndex, newIndex) => _onReorder(oldIndex, newIndex),
            children: _generateRoutineExerciseList(),
          ),
          const RoutineExerciseAutocomplete(),
        ],
      ),
    );
  }
}
