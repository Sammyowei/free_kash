import 'package:free_kash/provider/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Provider for managing loading state.
final loadingProvider =
    StateNotifierProvider<BooleanStateNotifier, bool>((ref) {
  return BooleanStateNotifier();
});

/// Provider for managing the visibility of text in text fields.
final obscureTextProvider =
    StateNotifierProvider<BooleanStateNotifier, bool>((ref) {
  final obscureText = BooleanStateNotifier();

  obscureText.toggleOn(); // Initial toggle to set obscure text to true
  return obscureText;
});

/// Provider for managing form validation for the login form.
final loginFormValidatorProvider =
    StateNotifierProvider<BooleanStateNotifier, bool>((ref) {
  return BooleanStateNotifier();
});

/// Provider for managing form validation for password reset.
final passwordResetValidatorProvider =
    StateNotifierProvider<BooleanStateNotifier, bool>((ref) {
  return BooleanStateNotifier();
});

/// Provider for managing form validation for the signup form.
final signupFormValidatorProvider =
    StateNotifierProvider<BooleanStateNotifier, bool>((ref) {
  return BooleanStateNotifier();
});

final profileStateNotifierProvider =
    StateNotifierProvider<BooleanStateNotifier, bool>((ref) {
  return BooleanStateNotifier();
});

final bankValidatorStateNotifierProvider =
    StateNotifierProvider<BooleanStateNotifier, bool>((ref) {
  return BooleanStateNotifier();
});

final editProfileStateProvider =
    StateNotifierProvider<BooleanStateNotifier, bool>((ref) {
  return BooleanStateNotifier();
});

final withdrawalFormVAlidatorProvider =
    StateNotifierProvider<BooleanStateNotifier, bool>((ref) {
  return BooleanStateNotifier();
});
