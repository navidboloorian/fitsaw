import 'package:fitsaw/features/exercises/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExerciseList extends ConsumerWidget {
  const ExerciseList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exerciseList = ref.watch(exerciseListProvider);

    return StreamBuilder(
      stream: exerciseList.changes,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        return ListView.builder(
          itemCount: exerciseList.length,
          itemBuilder: (context, index) => Text(exerciseList[index].name),
        );
      },
    );
  }
}
