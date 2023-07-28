import 'package:fitsaw/features/exercises/presentation/presentation.dart';
import 'package:fitsaw/shared/widgets/custom_app_bar.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Exercises extends ConsumerWidget {
  const Exercises({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: ExerciseList(),
      appBar: CustomAppBar(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
