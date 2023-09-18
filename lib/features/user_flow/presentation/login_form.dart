import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/widgets/bottom_button.dart';
import 'package:fitsaw/shared/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  late final GlobalKey _formKey;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomContainer(
            color: Palette.container2Background,
            child: TextFormField(
              decoration: const InputDecoration(hintText: 'Email'),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    !value.contains('@') ||
                    !value.contains('.')) {
                  return 'Invalid email';
                }
                return null;
              },
            ),
          ),
          CustomContainer(
            color: Palette.container2Background,
            child: TextFormField(
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
          ),
          BottomButton(
            text: 'Login',
            onTap: () {},
            margin: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
