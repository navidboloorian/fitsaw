import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final userProvider = StreamProvider<User?>((ref) => ref.watch(firebaseAuthProvider).authStateChanges());
final userLoggedInProvider = Provider<bool>((ref) {
  final user = ref.watch(userProvider);

  return user.value?.uid != null;
});