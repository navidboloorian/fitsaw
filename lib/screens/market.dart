import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/providers/providers.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitsaw/features/user_flow/presentation/presentation.dart';

class Market extends ConsumerWidget {
  const Market({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            CustomContainer(
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
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
