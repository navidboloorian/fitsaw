import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:fitsaw/shared/providers/providers.dart';

class TagTextField extends ConsumerStatefulWidget {
  const TagTextField({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TagTextFieldState();
}

class _TagTextFieldState extends ConsumerState<TagTextField> {
  late final TextEditingController _controller;

  void _addTag() {
    // detect when a comma is entered
    if (_controller.text.contains(',')) {
      final tags = ref.read(tagTextFieldListProvider);

      int delimIndex = _controller.text.indexOf(',');

      // trim spaces to evaluate the text only
      String tag = _controller.text.substring(0, delimIndex).trim();
      bool tagExists = false;

      // ensure duplicate tags don't exist
      if (tags.contains(tag)) {
        tagExists = true;
      }

      // prevent tags with only spaces, require at least one alphanumeric
      if (!tagExists && RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(tag)) {
        // add tag to the outer state
        ref.read(tagTextFieldListProvider.notifier).add(tag);

        // if there are chars to the right of the comma keep them
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
  }

  @override
  Widget build(BuildContext context) {
    final tags = ref.watch(tagTextFieldListProvider);

    return TaggedContainer(
      tags: tags,
      onTap: ref.read(tagTextFieldListProvider.notifier).remove,
      isDismissible: true,
      child: TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          hintText: 'Tags (separate with commas)',
        ),
      ),
    );
  }
}
