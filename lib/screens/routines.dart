import 'package:fitsaw/features/routine_list/presentation/presentation.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Routines extends ConsumerWidget {
  const Routines({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(
        children: const [SearchBox(), RoutineList()],
      ),
      appBar: CustomAppBar(
        leading: SettingsButton(() => Navigator.pushNamed(context, 'settings')),
        actions: [
          PlusButton(
            () => Navigator.pushNamed(
              context,
              'view_routine',
              arguments: PageArguments(isNew: true),
            ),
          )
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
