import 'package:fitsaw/features/routines/domain/domain.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/providers/providers.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

class ViewRoutine extends ConsumerStatefulWidget {
  final bool isNew;
  final Routine? routine;

  const ViewRoutine({
    super.key,
    required this.isNew,
    this.routine,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ViewRoutineState();
}

class _ViewRoutineState extends ConsumerState<ViewRoutine> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _resetProviders() {
    ref.read(tagTextFieldListProvider.notifier).clear();
  }

  void _upsertRoutine() {}

  void _populateForm() {}

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
      child: const Scaffold(
        appBar: CustomAppBar(),
        body: Placeholder(),
      ),
    );
  }
}
