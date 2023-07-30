import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The current tab on the bottom navbar.
final navScreenProvider = StateProvider<String>((ref) => 'routines');
