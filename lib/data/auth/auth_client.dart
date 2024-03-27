import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:free_kash/data/auth/_auth.dart';
import 'package:free_kash/data/auth/_exception.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthClient extends Auth {
  static final _authInstance = FirebaseAuth.instance;
  @override
  Future<bool> isLoggedIn() async {
    return _authInstance.currentUser == null ? false : true;
  }

  @override
  Future<void> loginWithEmailPassword(String email, String password) async {
    try {
      await _authInstance.signInWithEmailAndPassword(
          email: email, password: password);
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
    // throw UnimplementedError();
  }

  @override
  Future<void> loginWithFederatedProvider() async {
    // Trigger the authentication flow
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
  }

  @override
  Future<void> logout() async {
    await _authInstance.signOut();
  }

  @override
  Future<void> registerWithEmailPassword(String email, String password) async {
    try {
      await _authInstance.createUserWithEmailAndPassword(
          email: email, password: password);
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

  @override
  Future<void> registerWithFederatedProvider(String provider) {
    throw UnimplementedError();
  }
}
