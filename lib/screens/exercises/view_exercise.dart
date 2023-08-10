import 'package:fitsaw/features/exercise_list/domain/domain.dart';
import 'package:fitsaw/features/view_exercise/presentation/presentation.dart';
import 'package:fitsaw/features/exercise_list/services/services.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/providers/providers.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

class ViewExercise extends ConsumerStatefulWidget {
  final bool isNew;
  final Exercise? exercise;

  const ViewExercise({
    super.key,
    required this.isNew,
    this.exercise,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ViewExerciseState();
}

class _ViewExerciseState extends ConsumerState<ViewExercise> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  late final _weightedSwitchButton = switchButtonProvider('isWeighted');
  late final _timedSwitchButton = switchButtonProvider('isTimed');

  void _resetProviders() {
    ref.read(_timedSwitchButton.notifier).state = false;
    ref.read(_weightedSwitchButton.notifier).state = false;
    ref.read(tagTextFieldListProvider.notifier).clear();
  }

  void _upsertExercise() {
    if (_formKey.currentState!.validate()) {
      ObjectId id = widget.isNew ? ObjectId() : widget.exercise!.id;
      String name = _nameController.text;
      bool isTimed = ref.read(_timedSwitchButton);
      bool isWeighted = ref.read(_weightedSwitchButton);
      List<String> tags = ref.read(tagTextFieldListProvider);

      // Make description null if empty.
      String? description = _descriptionController.text.isEmpty
          ? null
          : _descriptionController.text;

      ref.read(exerciseListProvider).upsert(
            Exercise(
              id,
              name,
              isTimed,
              isWeighted,
              description: description,
              tags: tags,
            ),
          );

      String snackbarMessage =
          widget.isNew ? 'Exercise created!' : 'Exercise updated!';

      Navigator.pop(context);

      _resetProviders();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Palette.fitsawGreen,
          duration: const Duration(milliseconds: 500),
          content: Text(
            snackbarMessage,
            style: const TextStyle(color: Palette.darkText),
          ),
        ),
      );
    }
  }

  void _populateForm() {
    _nameController.text = widget.exercise!.name;

    if (widget.exercise!.description != null) {
      _descriptionController.text = widget.exercise!.description!;
    }

    // Uses "Future" to avoid provider being updated before widget is built out.
    Future(() {
      ref.read(_weightedSwitchButton.notifier).state =
          widget.exercise!.isWeighted;
      ref.read(_timedSwitchButton.notifier).state = widget.exercise!.isTimed;
      ref.read(tagTextFieldListProvider.notifier).set(widget.exercise!.tags);
    });
  }

  /// Clear form/reset providers if user uses the back button.
  Future<bool> _onWillPop() async {
    _resetProviders();

    return true;
  }

  @override
  void initState() {
    super.initState();

    if (!widget.isNew) {
      _populateForm();
    }
  }

  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: CustomAppBar(
          actions: [CheckButton(_upsertExercise)],
        ),
        body: ViewExerciseForm(
          formKey: _formKey,
          nameController: _nameController,
          descriptionController: _descriptionController,
          weightedSwitchButton: _weightedSwitchButton,
          timedSwitchButton: _timedSwitchButton,
        ),
      ),
    );
  }
}
