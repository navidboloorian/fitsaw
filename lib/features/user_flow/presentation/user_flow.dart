import 'package:fitsaw/features/user_flow/presentation/presentation.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/providers/providers.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserFlow extends ConsumerWidget {
  const UserFlow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(dbProvider);
    
    return switch(db) {
      AsyncError() => const Text('There\'s been an error, please try again later.'),
      AsyncData() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomContainer(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              children: [
                const SwitchButton(
                  left: 'Login',
                  right: 'Register',
                  providerName: 'userFlow',
                  backgroundColor: Palette.container2Background,
                ),
                ref.watch(switchButtonProvider('userFlow'))
                    ? const RegisterForm()
                    : const LoginForm(),
              ],
            ),
          )
        ],
      ),
      _ => const CircularProgressIndicator(color: Palette.fitsawBlue),
    };
  }
}