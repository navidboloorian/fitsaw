import 'package:fitsaw/features/routines/domain/domain.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitsaw/features/routines/services/services.dart';

class RoutineExerciseListItem extends ConsumerWidget {
  const RoutineExerciseListItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomContainer(
      color: Palette.container2Background,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Routine name'),
          const Divider(
            color: Palette.darkText,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 43,
                child: Column(
                  children: [
                    TextFormField(
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(hintText: '00:00'),
                      inputFormatters: [TimeInputFormatter()],
                    ),
                    Text(
                      'Rest',
                      style: TextStyle(color: Palette.secondaryText),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
