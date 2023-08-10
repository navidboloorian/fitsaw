import 'package:fitsaw/features/exercise_list/domain/domain.dart';
import 'package:fitsaw/features/exercise_list/services/services.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/providers/providers.dart';
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
  List<Widget> generateWidgetList(dynamic exerciseList) {
    final searchQuery = ref.watch(searchQueryProvider);
    List<Widget> list = [];

    for (int i = 0; i < exerciseList.length(); i++) {
      bool containsSearchQuery = false;
      Exercise exercise = exerciseList[i];

      if (exercise.name.toLowerCase().contains(searchQuery)) {
        containsSearchQuery = true;
      }

      for (String tag in exercise.tags) {
        if (tag.toLowerCase().contains(searchQuery)) {
          containsSearchQuery = true;
          break;
        }
      }

      if (containsSearchQuery) {
        list.add(
          Dismissible(
            // Generates a unique key from the exercise's id.
            key: ValueKey(exercise.id),
            background: Container(
              color: Palette.fitsawRed,
              child: const Center(
                child: Icon(
                  Icons.delete_outline,
                  color: Palette.darkText,
                ),
              ),
            ),
            onDismissed: (DismissDirection direction) =>
                ref.read(exerciseListProvider).delete(exercise),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                'view_exercise',
                arguments: PageArguments(isNew: false, exercise: exercise),
              ),
              child: TaggedContainer(
                tags: exercise.tags,
                child: Text(exercise.name),
              ),
            ),
          ),
        );

        list.add(const SizedBox(
          height: 10,
        ));
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final exerciseList = ref.watch(exerciseListProvider);

    return StreamBuilder(
      stream: exerciseList.changes(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        return ExpandableSection(
          title: 'Your Exercises',
          children: generateWidgetList(exerciseList),
        );
      },
    );
  }
}
