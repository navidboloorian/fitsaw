import 'package:fitsaw/features/active_routine/presentation/presentation.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActiveRoutine extends ConsumerWidget {
  const ActiveRoutine({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: CustomContainer(
        child: CountdownTimer(
          duration: 400,
        ),
      ),
    );
  }
}
