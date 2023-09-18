import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewExerciseForm extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController descriptionController;

  const ViewExerciseForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.descriptionController,
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
          const SwitchButton(
            left: 'Reps',
            right: 'Time',
            providerName: 'timed',
          ),
          const SwitchButton(
            left: 'Not Weighted',
            right: 'Weighted',
            providerName: 'weighted',
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
          const TagTextField(type: 'exercise'),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
