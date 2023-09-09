import 'package:fitsaw/features/history/presentation/presentation.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class History extends ConsumerWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(),
      body: HistoryList(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
