import 'package:fitsaw/features/routines/domain/domain.dart';
import 'package:fitsaw/features/routines/presentation/presentation.dart';
import 'package:fitsaw/features/routines/services/routine_exercise_list_provider.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  List<Widget> generateRoutineExerciseList(dynamic routineExerciseList) {
    List<Widget> list = [];

    for (RoutineExerciseWrapper routineExercise in routineExerciseList) {
      list.add(
        CustomContainer(
          color: Palette.container2Background,
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: Text(routineExercise.exercise!.name),
        ),
      );
    }

    return list;
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
                hintText: 'Exercise name',
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
                ...generateRoutineExerciseList(
                    ref.watch(routineExerciseListProvider)),
                RoutineExerciseAutocomplete(),
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
