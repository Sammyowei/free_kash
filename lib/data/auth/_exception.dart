import 'package:firebase_auth/firebase_auth.dart';

class AuthException implements Exception {
  final String message;
  final String code;

  AuthException(this.code, this.message);

  factory AuthException.fromFirebaseAuthException(FirebaseAuthException e) {
    String message = "Firebase Authentication Error";
    switch (e.code) {
      case 'invalid-email':
        message = 'Invalid email address.';
        break;
      case 'user-disabled':
        message = 'This user has been disabled.';
        break;
      case 'user-not-found':
        message = 'User not found.';
        break;
      case 'wrong-password':
        message = 'Invalid password.';
        break;
      case 'email-already-in-use':
        message = 'Email already in use.';
        break;
      default:
        print(e.code);
        message = e.message ?? 'An error occurred during authentication.';
        break;
    }
    return AuthException(e.code, message);
  }

  @override
  String toString() {
    return "AuthException: $code - $message";
  }
}
