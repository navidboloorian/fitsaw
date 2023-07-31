import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Market extends ConsumerWidget {
  const Market({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(child: Text('Market')),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
