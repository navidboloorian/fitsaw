import 'package:fitsaw/features/market_list/presentation/presentation.dart';
import 'package:fitsaw/features/routine_list/domain/domain.dart';
import 'package:fitsaw/features/user_flow/presentation/presentation.dart';
import 'package:fitsaw/features/user_flow/services/services.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';

class Market extends ConsumerWidget {
  const Market({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userLoggedIn = ref.watch(userLoggedInProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(),
      body: Center(
        child: userLoggedIn
            ? MarketContainer(
                routine: Routine(ObjectId(), 'Testing', rating: 5),
                onTap: (test) => null,
                tags: const ['Test'],
              )
            : const UserFlow(),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
