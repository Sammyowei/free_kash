import 'package:hooks_riverpod/hooks_riverpod.dart';

/// A custom state notifier class for managing boolean state.
class BooleanStateNotifier extends StateNotifier<bool> {
  /// Constructor for [BooleanStateNotifier].
  BooleanStateNotifier() : super(false);

  /// Sets the state to true.
  void toggleOn() {
    state = true;
  }

  /// Sets the state to false.
  void toggleOff() {
    state = false;
  }

  /// Toggles the current state.
  void toggle() {
    state = !state;
  }
}
