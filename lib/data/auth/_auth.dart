import 'package:free_kash/data/auth/auth.dart';

abstract class Auth {
  // Method to register a new user with email and password
  Future<AuthResponse> registerWithEmailPassword(String email, String password);

  // Method to log in an existing user with email and password
  Future<AuthResponse> loginWithEmailPassword(String email, String password);

  // Method to register a new user with federated providers (e.g., Google, Facebook)
  Future<void> registerWithFederatedProvider(String provider);

  // Method to log in an existing user with federated providers (e.g., Google, Facebook)
  Future<void> loginWithFederatedProvider(FederatedAuthProvider provider);

  // Method to log out the current user
  Future<void> logout();

  Future<void> forgotPassword(String email);

  // Method to check if a user is currently logged in
  Future<bool> isLoggedIn();
}
