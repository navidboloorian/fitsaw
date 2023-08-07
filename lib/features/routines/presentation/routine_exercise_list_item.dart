import 'package:fitsaw/features/routines/domain/domain.dart';
import 'package:fitsaw/features/routines/presentation/presentation.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            children: [
              TextFieldColumn(
                width: 43,
                label: 'Rest',
                textField: TimedTextField(controller: TextEditingController()),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class TextFieldColumn extends StatelessWidget {
  final double width;
  final String label;
  final Widget textField;

  const TextFieldColumn({
    super.key,
    required this.width,
    required this.label,
    required this.textField,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          textField,
          Text(
            label,
            style: const TextStyle(color: Palette.secondaryText),
          ),
        ],
      ),
    );
  }
}
