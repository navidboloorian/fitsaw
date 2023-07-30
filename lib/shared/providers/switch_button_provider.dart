import 'package:flutter_riverpod/flutter_riverpod.dart';

final switchButtonProvider =
    StateProvider.family<bool, String>((ref, name) => false);
