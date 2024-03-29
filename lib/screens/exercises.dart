import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitsaw/features/exercise_list/presentation/presentation.dart';

class Exercises extends ConsumerWidget {
  const Exercises({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(
        children: const [SearchBox(), ExerciseList()],
      ),
      appBar: CustomAppBar(
        leading: SettingsButton(() => Navigator.pushNamed(context, 'settings')),
        actions: [
          PlusButton(
            () => Navigator.pushNamed(
              context,
              'view_exercise',
              arguments: PageArguments(isNew: true),
            ),
          )
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
