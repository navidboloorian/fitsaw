import 'package:fitsaw/shared/classes/classes.dart';
import 'package:mongo_dart/mongo_dart.dart';

class UserHelper {
  static Future<Map<String, dynamic>> register(String email, String displayName,
      String password, String confPassword, Db db) async {
    Map<String, dynamic> response = {};
    List<String> errors = [];
    String encryptedPassword = "";

    if (password != confPassword) {
      errors.add("Passwords don't match.");
    } else {
      encryptedPassword = PasswordEncrypter.encrypt(password);
    }

    if (displayName.length < 3 || displayName.length > 24) {
      errors.add('Your display name must be between 3 and 24 characters long.');
    }

    if (password.length < 8) {
      errors.add('Your password must be at least 8 characters long.');
    }

    if(errors.isEmpty) {
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
    }

    response['errors'] = errors;

    return response;
  }
  
  static Future<Map<String, dynamic>> login(String password, Db db, [String? email, String? displayName]) async {
    Map<String, dynamic> response = {};
    List<String> errors = [];
    String encryptedPassword = PasswordEncrypter.encrypt(password);
    bool matchedUser = false;

    var users = db.collection('users');
    if(email != null) {
      Map<String, dynamic>? matchedUserEmail = await users.findOne(where.eq('email', email).eq('password', encryptedPassword));

      matchedUser = matchedUserEmail != null;
    }

    if(displayName != null) {
      Map<String, dynamic>? matchedUserDisplayName = await users.findOne(where.eq('displayName', displayName).eq('password', encryptedPassword));

      matchedUser = matchedUserDisplayName != null;
    }

    if (!matchedUser) {
      errors.add('A user with your provided credentials doesn\'t exist!');
    }

    response['errors'] = errors;

    return response;
  }
}
