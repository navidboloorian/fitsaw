import 'package:fitsaw/features/user_flow/services/services.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/providers/db_provider.dart';
import 'package:fitsaw/shared/widgets/bottom_button.dart';
import 'package:fitsaw/shared/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongo_dart/mongo_dart.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _displayNameOrEmailController;
  late final TextEditingController _passwordController;

  void _submitForm() {
    if(!_formKey.currentState!.validate()) {
      return;
    }

    AsyncValue<Db> db = ref.watch(dbProvider);

    db.whenData(
      (db) async {
        Map<String, dynamic> response;

        if(_displayNameOrEmailController.text.contains('@') && _displayNameOrEmailController.text.contains('.')) {
          response = await UserHelper.login(
            _passwordController.text,
            db,
            _displayNameOrEmailController.text,
            null,
          );
        }
        else {
          response = await UserHelper.login(
            _passwordController.text,
            db,
            null,
            _displayNameOrEmailController.text,
          );
        }

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
          snackBarString = "User successfully logged in!.";
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
  void initState() {
    super.initState();

    _displayNameOrEmailController = TextEditingController();
    _passwordController = TextEditingController();
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
              controller: _displayNameOrEmailController,
              decoration: const InputDecoration(hintText: 'Display name or email'),
              validator: (value) {
                if (value == null ||
                    value.isEmpty) {
                  return 'Please enter a display name or email.';
                }
                return null;
              },
            ),
          ),
          CustomContainer(
            color: Palette.container2Background,
            child: TextFormField(
              validator: (value) {
                if (value == null ||
                    value.isEmpty) {
                  return 'Please enter a password.';
                }
                return null;
              },
              obscureText: true,
              controller: _passwordController,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
          ),
          BottomButton(
            text: 'Login',
            onTap: _submitForm,
            margin: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
