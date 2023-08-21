import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewExerciseForm extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final StateProvider<bool> weightedSwitchButton;
  final StateProvider<bool> timedSwitchButton;

  const ViewExerciseForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.descriptionController,
    required this.weightedSwitchButton,
    required this.timedSwitchButton,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          CustomContainer(
            child: TextFormField(
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Exercise name',
                counterText: '',
              ),
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'A name is required';
                }
                return null;
              },
            ),
          ),
          SwitchButton(
            left: 'Reps',
            right: 'Time',
            provider: timedSwitchButton,
          ),
          SwitchButton(
            left: 'Not Weighted',
            right: 'Weighted',
            provider: weightedSwitchButton,
          ),
          CustomContainer(
            child: TextFormField(
              minLines: 5,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Description',
                counterText: '',
              ),
              controller: descriptionController,
            ),
          ),
          const TagTextField(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
