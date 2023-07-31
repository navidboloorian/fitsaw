import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:fitsaw/shared/providers/providers.dart';

class TagTextField extends ConsumerStatefulWidget {
  final List<String>? preExistingTags;

  const TagTextField({
    super.key,
    this.preExistingTags,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TagTextFieldState();
}

class _TagTextFieldState extends ConsumerState<TagTextField> {
  late final TextEditingController _controller;

  void _addTag() {
    // Detect when a comma is entered.
    if (_controller.text.contains(',')) {
      int delimIndex = _controller.text.indexOf(',');

      // Trim spaces to evaluate the text only.
      String tag = _controller.text.substring(0, delimIndex).trim();
      bool tagExists = false;

      // Ensure duplicate tags don't exist.
      if (ref.read(tagTextFieldListProvider).contains(tag)) {
        tagExists = true;
      }

      // Prevent tags with only spaces, require at least one alphanumeric.
      if (!tagExists && RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(tag)) {
        // Add tag to the outer tag list state.
        ref.read(tagTextFieldListProvider.notifier).add(tag);

        // Keep chars to the right of the comma.
        if (delimIndex != _controller.text.length - 1) {
          _controller.text = _controller.text.substring(delimIndex + 1);
        } else {
          _controller.text = '';
        }
      } else {
        _controller.text = '';
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
    _controller.addListener(_addTag);

    // Load exercise's tags in if they exist.
    if (widget.preExistingTags != null) {
      ref.read(tagTextFieldListProvider.notifier).set(widget.preExistingTags!);
    }
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tags = ref.watch(tagTextFieldListProvider);

    return TaggedContainer(
      tags: tags,
      onTap: ref.read(tagTextFieldListProvider.notifier).remove,
      isDismissible: true,
      child: TextFormField(
        maxLines: null,
        controller: _controller,
        decoration: const InputDecoration(
          hintText: 'Tags (separate with commas)',
        ),
      ),
    );
  }
}
