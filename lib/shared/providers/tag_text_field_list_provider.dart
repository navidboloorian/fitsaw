import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Manages the list of tags entered into the tag text field.
class TagTextFieldListNotifier extends Notifier<List<String>> {
  @override
  List<String> build() {
    return [];
  }

  void set(List<String> tags) {
    state = tags;
  }

  void add(String tag) {
    state = [...state, tag];
  }

  void remove(String tag) {
    state.remove(tag);

    // The spread operator triggers a rebuild so it's used instead of state = state.
    state = [...state];
  }
}

final tagTextFieldListProvider =
    NotifierProvider<TagTextFieldListNotifier, List<String>>(
        () => TagTextFieldListNotifier());
