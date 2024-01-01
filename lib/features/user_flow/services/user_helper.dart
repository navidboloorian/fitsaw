import 'package:fitsaw/shared/classes/classes.dart';
import 'package:mongo_dart/mongo_dart.dart';

class UserHelper {
  static Future<Map<String, dynamic>> register(String email, String displayName,
      String password, String confPassword, Db db) async {
    Map<String, dynamic> response = {};
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

    return response;
  }
  
  static Future<Map<String, dynamic>> login(String email,
      String password, Db db) async {
    Map<String, dynamic> response = {};
    List<String> errors = [];
    String encryptedPassword = PasswordEncrypter.encrypt(password);

    var users = db.collection('users');
    Map<String, dynamic>? matchedUser = await users.findOne(where.eq('email', email).eq('password', encryptedPassword));

    if (matchedUser == null) {
      errors.add('A user with your provided credentials does not exist!');
    }

    response['errors'] = errors;

    return response;
  }
}
