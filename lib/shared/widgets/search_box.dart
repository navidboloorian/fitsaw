import 'package:fitsaw/shared/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchBox extends ConsumerStatefulWidget {
  const SearchBox({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchBoxState();
}

class _SearchBoxState extends ConsumerState<SearchBox> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Update the search query state when text is inputted in the search field.
    // Cast to lower case for a standardized keyword comparison.
    _controller.addListener(() => ref.read(searchQueryProvider.notifier).state =
        _controller.text.toLowerCase());
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          hintText: 'Search...',
        ),
      ),
    );
  }
}
