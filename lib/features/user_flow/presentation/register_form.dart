import 'package:fitsaw/features/user_flow/services/services.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/providers/db_provider.dart';
import 'package:fitsaw/shared/widgets/bottom_button.dart';
import 'package:fitsaw/shared/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongo_dart/mongo_dart.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _displayNameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confPasswordController;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _displayNameController = TextEditingController();
    _passwordController = TextEditingController();
    _confPasswordController = TextEditingController();
  }

  void _submitForm() {
    if(!_formKey.currentState!.validate()) {
      return;
    }

    AsyncValue<Db> db = ref.watch(dbProvider);

    db.whenData(
      (db) async {
        Map<String, dynamic> response = await UserHelper.register(
          _emailController.text,
          _displayNameController.text,
          _passwordController.text,
          _confPasswordController.text,
          db,
          ref,
        );

        String snackBarString = "";
        Color snackBarColor;

        if (response['errors'].isNotEmpty) {
          snackBarColor = Palette.fitsawRed;

          for (int i = 0; i < response['errors'].length; i++) {
            snackBarString += response['errors'][i];

            if (i != response['errors'].length - 1) {
              snackBarString += '\n';
            }
          }
        } else {
          snackBarColor = Palette.fitsawGreen;
          snackBarString = "User successfully registered! Please login.";
        }

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: snackBarColor,
              duration: const Duration(milliseconds: 2000),
              content: Text(
                snackBarString,
                style: const TextStyle(color: Palette.darkText),
              ),
            ),
          );
        }
      },
    );
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
              controller: _emailController,
              decoration: const InputDecoration(hintText: 'Email'),
              validator: (value) {
                if (value == null ||
                    value.isEmpty) {
                  return 'Please enter an email.';
                }
                else if(!value.contains('@') ||
                    !value.contains('.')) {
                  return 'Invalid email format.';
                }
                return null;
              },
            ),
          ),
          CustomContainer(
            color: Palette.container2Background,
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a display name.';
                }
                return null;
              },
              controller: _displayNameController,
              decoration: const InputDecoration(hintText: 'Display name'),
            ),
          ),
          CustomContainer(
            color: Palette.container2Background,
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password.';
                }
                return null;
              },
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
          ),
          CustomContainer(
            color: Palette.container2Background,
            child: TextFormField(validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password.';
                }
                return null;
              },
              controller: _confPasswordController,
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Confirm password'),
            ),
          ),
          BottomButton(
            text: 'Register',
            onTap: _submitForm,
            margin: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
