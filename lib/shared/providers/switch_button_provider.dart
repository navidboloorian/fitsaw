import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The provider that stores the state of a switch button.
final switchButtonProvider =
    StateProvider.family<bool, String>((ref, name) => false);
