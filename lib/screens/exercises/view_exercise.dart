import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class ViewExercise extends ConsumerStatefulWidget {
  const ViewExercise({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ViewExerciseState();
}

class _ViewExerciseState extends ConsumerState<ViewExercise> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Form(
        child: Column(
          children: [
            TagTextField(),
          ],
        ),
      ),
    );
  }
}
