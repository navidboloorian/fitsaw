import 'dart:convert';
import 'package:crypto/crypto.dart';

class PasswordEncrypter {
  static String encrypt(String password) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);

    return hash.toString();
  }
}
