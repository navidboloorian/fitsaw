import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Manages the list of tags entered into the tag text field.
class TagTextFieldListNotifier extends FamilyNotifier<List<String>, String> {
  @override
  List<String> build(String arg) {
    return [];
  }

  void set(List<String> tags) {
    // A deep copy must be made because the alternative would result in
    // alterations being made to the realm collection outside of a "write" block
    // which is not permitted.
    state = [...tags];
  }

  void add(String tag) {
    state = [...state, tag];
  }

  void remove(String tag) {
    state.remove(tag);

    // The spread operator triggers a rebuild so it's used instead of state = state.
    state = [...state];
  }

  void clear() {
    state = [];
  }
}

final tagTextFieldListFamily =
    NotifierProvider.family<TagTextFieldListNotifier, List<String>, String>(
        () => TagTextFieldListNotifier());
