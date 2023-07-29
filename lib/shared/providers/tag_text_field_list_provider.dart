import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    state = state;
  }
}

final tagTextFieldProvider =
    NotifierProvider<TagTextFieldListNotifier, List<String>>(
        () => TagTextFieldListNotifier());
