import 'package:fitsaw/features/exercises/domain/domain.dart';
import 'package:fitsaw/features/exercises/services/services.dart';
import 'package:fitsaw/features/routines/services/routine_exercise_list_provider.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoutineExerciseAutocomplete extends ConsumerWidget {
  const RoutineExerciseAutocomplete({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exerciseList = ref.watch(exerciseListProvider);

    return RawAutocomplete<Exercise>(
      // when enter is pressed, clear the textbox
      displayStringForOption: (option) => '',
      optionsBuilder: (textEditingValue) {
        List<Exercise> options = [];

        for (int i = 0; i < exerciseList.length(); i++) {
          if (exerciseList[i]
              .name
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase())) {
            options.add(exerciseList[i]);
          }
        }

        return options;
      },
      fieldViewBuilder: (
        context,
        textEditingController,
        focusNode,
        onFieldSubmitted,
      ) {
        return CustomContainer(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          color: Palette.container2Background,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: TextFormField(
              controller: textEditingController,
              focusNode: focusNode,
              decoration: const InputDecoration(hintText: 'Exercises...'),
              onFieldSubmitted: (String value) {
                onFieldSubmitted();
              },
            ),
          ),
        );
      },
      onSelected: (option) {
        Map<String, dynamic> routineExercise = {
          'exercise': option,
          'restController': TextEditingController(),
          'setController': TextEditingController(),
        };

        if (option.isTimed) {
          routineExercise['timeController'] = TextEditingController();
        } else {
          routineExercise['repController'] = TextEditingController();
        }

        if (option.isWeighted) {
          routineExercise['weightController'] = TextEditingController();
        }

        ref.read(routineExerciseListProvider.notifier).add(routineExercise);
      },
      optionsViewBuilder: (
        context,
        onSelected,
        options,
      ) {
        return CustomContainer(
          width: MediaQuery.of(context).size.width * 0.9 - 22,
          color: Palette.container2Background,
          alignment: Alignment.topLeft,
          padding: EdgeInsets.zero,
          height: 33.0 * options.length,
          margin: EdgeInsets.zero,
          boxConstraints: const BoxConstraints(maxHeight: 99),
          child: ListView.separated(
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => const Divider(
              height: 0,
              color: Palette.darkText,
            ),
            itemCount: options.length,
            itemBuilder: (context, index) {
              final Exercise option = options.elementAt(index);
              return GestureDetector(
                onTap: () => onSelected(option),
                child: ExerciseAutocompleteResult(exercise: option),
              );
            },
          ),
        );
      },
    );
  }
}

class ExerciseAutocompleteResult extends ConsumerWidget {
  final Exercise exercise;

  const ExerciseAutocompleteResult({super.key, required this.exercise});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Text(exercise.name),
    );
  }
}
