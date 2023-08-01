import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The provider that stores the current search query.
final searchQueryProvider = StateProvider<String>((ref) => '');
