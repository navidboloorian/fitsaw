import 'package:fitsaw/features/view_routine/presentation/presentation.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitsaw/features/view_routine/services/services.dart';

class ViewRoutineForm extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController descriptionController;

  const ViewRoutineForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.descriptionController,
  });

  List<Widget> _generateRoutineExerciseList(WidgetRef ref) {
    List<Widget> list = [];

    for (int i = 0; i < ref.watch(routineExerciseListProvider).length; i++) {
      Map<String, dynamic> routineExercise =
          ref.watch(routineExerciseListProvider)[i];

      list.add(
        Dismissible(
          key: UniqueKey(),
          onDismissed: (DismissDirection direction) {
            ref.read(routineExerciseListProvider.notifier).removeAt(i);
          },
          child: RoutineExerciseListItem(routineExercise: routineExercise),
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

  void _onReorder(int oldIndex, int newIndex, WidgetRef ref) {
    if (oldIndex < newIndex) {
      newIndex--;
    }

    final Map<String, dynamic> routineExercise =
        ref.read(routineExerciseListProvider.notifier).removeAt(oldIndex);

    ref
        .read(routineExerciseListProvider.notifier)
        .insert(newIndex, routineExercise);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          CustomContainer(
            child: TextFormField(
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Routine name',
                counterText: '',
              ),
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'A name is required';
                }
                return null;
              },
            ),
          ),
          CustomContainer(
            child: Column(
              children: [
                ReorderableListView(
                  proxyDecorator: _reorderableDecorator,
                  shrinkWrap: true,
                  onReorder: (oldIndex, newIndex) =>
                      _onReorder(oldIndex, newIndex, ref),
                  children: _generateRoutineExerciseList(ref),
                ),
                const RoutineExerciseAutocomplete(),
              ],
            ),
          ),
          CustomContainer(
            child: TextFormField(
              minLines: 5,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Description',
                counterText: '',
              ),
              controller: descriptionController,
            ),
          ),
          const TagTextField(),
        ],
      ),
    );
  }
}
