import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongo_dart/mongo_dart.dart';

class RegisterUser {
  static Future<List<String>> register(String email, String displayName,
      String password, String confPassword, Db db) async {
    Map<String, Object> response = {};
    List<String> errors = [];
    String encryptedPassword = "";

    if (password != confPassword) {
      errors.add("Passwords do not match.");
    } else {
      encryptedPassword = PasswordEncrypter.encrypt(password);
    }

    var users = db.collection('users');

    bool emailExists = !(await users.find({'email': email}).isEmpty);
    bool displayNameExists =
        !(await users.find({'displayName': displayName}).isEmpty);

    if (emailExists) {
      errors.add('A user with this email already exists.');
    }

    if (displayNameExists) {
      errors.add('A user with this display name already exists.');
    }

    if (errors.isEmpty) {
      var user = await users.insert(
        {
          'email': email,
          'displayName': displayName,
          'password': encryptedPassword,
        },
      );

      response['success'] = user;
    }

    response['errors'] = errors;

    return errors;
  }
}
