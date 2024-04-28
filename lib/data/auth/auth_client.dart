import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:free_kash/data/auth/_auh_provider.dart';
import 'package:free_kash/data/auth/_auth.dart';
import 'package:free_kash/data/auth/_exception.dart';
import 'package:free_kash/presentation/routes/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '_auth_response.dart';

/// A class implementing authentication operations using Firebase Authentication.
class AuthClient extends Auth {
  static final _authInstance = FirebaseAuth.instance;

  String? get userID => _authInstance.currentUser?.uid;

  FirebaseAuth get instance => _authInstance;

  /// Checks if a user is currently logged in.
  @override
  Future<bool> isLoggedIn() async {
    return _authInstance.currentUser == null ? false : true;
  }

  /// Logs in a user with email and password.
  /// Returns an [AuthResponse] indicating the result of the operation.
  @override
  Future<AuthResponse> loginWithEmailPassword(
      String email, String password) async {
    try {
      await _authInstance.signInWithEmailAndPassword(
          email: email, password: password);

      return SuccessAuthResponse(message: 'Login Successfully.');
    } catch (e) {
      if (e is FirebaseAuthException) {
        AuthException customException =
            AuthException.fromFirebaseAuthException(e);
        debugPrint('Authentication Exception: ${customException.message}');
        return ErrorAuthResponse(customException.message, customException.code);
      } else {
        debugPrint('Unexpected error occurred: $e');
        return ErrorAuthResponse('Unexpected error occurred: $e', 'unknown');
      }
    }
  }

  /// Logs in a user with a federated provider (e.g., Google, Facebook).
  @override
  Future<void> loginWithFederatedProvider(
      FederatedAuthProvider provider, BuildContext context) async {
    switch (provider) {
      case FederatedAuthProvider.google:
        final GoogleSignInAccount? googleUser =
            await GoogleSignIn(forceCodeForRefreshToken: true).signIn();
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        try {
          final credentials =
              await _authInstance.signInWithCredential(credential);

          if (context.mounted) {
            context.goNamed(RouteName.dataValidator,
                pathParameters: {'id': credentials.user!.uid});
          }
        } catch (e) {
          if (e is FirebaseAuthException) {
            AuthException customException =
                AuthException.fromFirebaseAuthException(e);
            debugPrint('Authentication Exception: ${customException.message}');
          } else {
            debugPrint('Unexpected error occurred: $e');
          }
        }
        break;
      case FederatedAuthProvider.facebook:
        final LoginResult loginResult = await FacebookAuth.instance.login();
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);
        try {
          final credentials =
              await _authInstance.signInWithCredential(facebookAuthCredential);

          if (context.mounted) {
            context.goNamed(RouteName.dataValidator,
                pathParameters: {'id': credentials.user!.uid});
          }
        } catch (e) {
          if (e is FirebaseAuthException) {
            AuthException customException =
                AuthException.fromFirebaseAuthException(e);
            debugPrint('Authentication Exception: ${customException.message}');
          } else {
            debugPrint('Unexpected error occurred: $e');
          }
        }
      default:
    }
  }

  /// Logs out the currently logged-in user.
  @override
  Future<void> logout() async {
    await _authInstance.signOut();
  }

  /// Registers a new user with email and password.
  @override
  Future<AuthResponse> registerWithEmailPassword(
      String email, String password) async {
    try {
      await _authInstance.createUserWithEmailAndPassword(
          email: email, password: password);
      return SuccessAuthResponse(
        message:
            'Congratulations! 🎉 You have successfully created your account.',
      );
    } catch (e) {
      if (e is FirebaseAuthException) {
        AuthException customException =
            AuthException.fromFirebaseAuthException(e);
        debugPrint('Authentication Exception: ${customException.message}');
        return ErrorAuthResponse(customException.message, customException.code);
      } else {
        debugPrint('Unexpected error occurred: $e');
        return ErrorAuthResponse("Unexpected error occurred: $e", 'error');
      }
    }
  }

  @override
  Future<void> registerWithFederatedProvider(String provider) {
    throw UnimplementedError();
  }

  /// Initiates the process of resetting the user's password.
  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _authInstance.sendPasswordResetEmail(email: email);
    } catch (e) {
      if (e is FirebaseAuthException) {
        AuthException customException =
            AuthException.fromFirebaseAuthException(e);
        debugPrint('Authentication Exception: ${customException.message}');
      } else {
        debugPrint('Unexpected error occurred: $e');
      }
    }
  }
}
