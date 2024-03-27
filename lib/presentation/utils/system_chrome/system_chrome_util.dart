import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A utility class for configuring the system chrome settings in a Flutter application.
class SystemChromeConfig {
  /// Sets the system UI mode to immersive mode.
  ///
  /// Immersive mode hides all system UI elements such as the status and navigation bars.
  static void setImmersive() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        // statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  /// Toggles the system UI to display both the status and navigation bars.
  static void toggleOff() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);
  }

  /// Sets the status bar color to transparent with dark icons.
  static void setStatusBarColor() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        // statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }
}
