import 'package:fitsaw/features/exercises/domain/domain.dart';
import 'package:fitsaw/features/routines/domain/domain.dart';
import 'package:fitsaw/features/routines/presentation/presentation.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitsaw/features/routines/services/services.dart';

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

  List<Widget> generateRoutineExerciseList(
      List<Map<String, dynamic>> routineExerciseList) {
    List<Widget> list = [];

    for (Map<String, dynamic> routineExerciseMap in routineExerciseList) {
      list.add(RoutineExerciseListItem(routineExerciseMap: routineExerciseMap));
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
