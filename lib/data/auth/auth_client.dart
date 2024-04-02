import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:free_kash/data/auth/_auh_provider.dart';
import 'package:free_kash/data/auth/_auth.dart';
import 'package:free_kash/data/auth/_exception.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '_auth_response.dart';

class AuthClient extends Auth {
  static final _authInstance = FirebaseAuth.instance;
  @override
  Future<bool> isLoggedIn() async {
    return _authInstance.currentUser == null ? false : true;
  }

  @override
  Future<AuthResponse> loginWithEmailPassword(
      String email, String password) async {
    try {
      final user = await _authInstance.signInWithEmailAndPassword(
          email: email, password: password);

      return SuccessAuthResponse(message: 'Login Successfully.');
    } catch (e) {
      if (e is FirebaseAuthException) {
        AuthException customException =
            AuthException.fromFirebaseAuthException(e);
        debugPrint('Authentication Exception: ${customException.message}');
        // Handle the exception, for example, show an error message to the user

        return ErrorAuthResponse(customException.message, customException.code);
      } else {
        debugPrint('Unexpected error occurred: $e');
        // Handle other types of exceptions here if needed

        return ErrorAuthResponse('Unexpected error occurred: $e', 'unckown');
      }
    }
    // throw UnimplementedError();
  }

  @override
  Future<void> loginWithFederatedProvider(
      FederatedAuthProvider provider) async {
    /// Authenticat for Google
    ///
    ///
    ///

    switch (provider) {
      case FederatedAuthProvider.google:
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        // Obtain the auth details from the request
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        // Once signed in, return the UserCredential
        try {
          _authInstance.signInWithCredential(credential);
        } catch (e) {
          if (e is FirebaseAuthException) {
            AuthException customException =
                AuthException.fromFirebaseAuthException(e);
            debugPrint('Authentication Exception: ${customException.message}');
            // Handle the exception, for example, show an error message to the user
          } else {
            debugPrint('Unexpected error occurred: $e');
            // Handle other types of exceptions here if needed
          }
        }
        break;

      ///  Sign In with Facebook set up
      case FederatedAuthProvider.facebook:
        final LoginResult loginResult = await FacebookAuth.instance.login();

        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);

        try {
          _authInstance.signInWithCredential(facebookAuthCredential);
        } catch (e) {
          if (e is FirebaseAuthException) {
            AuthException customException =
                AuthException.fromFirebaseAuthException(e);
            debugPrint('Authentication Exception: ${customException.message}');
            // Handle the exception, for example, show an error message to the user
          } else {
            debugPrint('Unexpected error occurred: $e');
            // Handle other types of exceptions here if needed
          }
        }
      default:
    }
    // Trigger the authentication flow
  }

  @override
  Future<void> logout() async {
    await _authInstance.signOut();
  }

  @override
  Future<AuthResponse> registerWithEmailPassword(
      String email, String password) async {
    try {
      final newUser = await _authInstance.createUserWithEmailAndPassword(
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
        // Handle the exception, for example, show an error message to the user
      } else {
        debugPrint('Unexpected error occurred: $e');
        return ErrorAuthResponse("Unexpected error occurred: $e", 'error code');
        // Handle other types of exceptions here if needed
      }
    }
  }

  @override
  Future<void> registerWithFederatedProvider(String provider) {
    throw UnimplementedError();
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _authInstance.sendPasswordResetEmail(
        email: email,
      );
    } catch (e) {
      if (e is FirebaseAuthException) {
        AuthException customException =
            AuthException.fromFirebaseAuthException(e);
        debugPrint('Authentication Exception: ${customException.message}');
        // Handle the exception, for example, show an error message to the user
      } else {
        debugPrint('Unexpected error occurred: $e');
        // Handle other types of exceptions here if needed
      }
    }
  }
}
