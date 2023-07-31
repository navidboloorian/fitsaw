import 'package:fitsaw/features/exercises/domain/domain.dart';
import 'package:fitsaw/features/exercises/services/services.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Visual representation of the exercise list.
class ExerciseList extends ConsumerStatefulWidget {
  const ExerciseList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExerciseListState();
}

class _ExerciseListState extends ConsumerState<ExerciseList> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final exerciseList = ref.watch(exerciseListProvider);

    return StreamBuilder(
      stream: exerciseList.changes(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        return ListView.builder(
          itemCount: exerciseList.length() + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return SearchBox(_searchController);
            }

            Exercise exercise = exerciseList[index - 1];

            return GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                'view_exercise',
                arguments: PageArguments(isNew: false, exercise: exercise),
              ),
              child: CustomContainer(
                child: Text(exercise.name),
              ),
            );
          },
        );
      },
    );
  }
}
