import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The provider that stores the state of a switch button.
final expandableArrowProvider =
    StateProvider.family<double, Key>((ref, key) => 0);
