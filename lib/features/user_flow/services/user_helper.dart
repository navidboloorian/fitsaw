import 'package:mongo_dart/mongo_dart.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserHelper {
  static Future<Map<String, dynamic>> register(String email, String displayName,
      String password, String confPassword, Db db) async {
    Map<String, dynamic> response = {};
    List<String> errors = [];

    if (password != confPassword) {
      errors.add("Passwords don't match.");
    }

    if (displayName.length < 3 || displayName.length > 24) {
      errors.add('Your display name must be between 3 and 24 characters long.');
    }

    if (password.length < 8) {
      errors.add('Your password must be at least 8 characters long.');
    }

    if(errors.isEmpty) {
      var users = db.collection('users');

      bool displayNameExists =
          !(await users.find({'displayName': displayName}).isEmpty);

      if (displayNameExists) {
        errors.add('A user with this display name already exists.');
      }

      if (errors.isEmpty) {
        try {
          var firebaseResp = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

          var user = await users.insert(
            {
              'firebaseUID': firebaseResp.user!.uid,
              'displayName': displayName,
            },
          );

          response['success'] = user;
        } catch(error) {
          if(error is FirebaseAuthException) {
            switch(error.code) {
              case 'email-already-in-use':
                errors.add('A user with this email already exists.');
                break;
            }
          }
        }
      }
    }

    response['errors'] = errors;

    return response;
  }
  
  static Future<Map<String, dynamic>> login(String password, String email, Db db) async {
    Map<String, dynamic> response = {};
    List<String> errors = [];
    try {
      var firebaseResp = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      var users = db.collection('users');

      Map<String, dynamic>? user = await users.findOne(where.eq('firebaseUID', firebaseResp.user!.uid));

      response['success'] = user;
    } catch (error) {
      if(error is FirebaseAuthException) {
        switch(error.code) {
          case 'unknown-error':
            errors.add('A user with this email/password combination doesn\'t exists.');
            break;
        }
      }
    }

    response['errors'] = errors;

    return response;
  }
}
