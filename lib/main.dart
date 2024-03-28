// Importing necessary packages
import 'package:flutter/material.dart'; // Flutter's Material Design widgets
import 'package:firebase_core/firebase_core.dart'; // Firebase initialization
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_kash/presentation/routes/routes.dart';
import 'package:free_kash/presentation/utils/utils.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart'; // Google Mobile Ads
import 'package:hooks_riverpod/hooks_riverpod.dart'; // State management

// Importing local files
import 'firebase_options.dart'; // Firebase options

// Entry point of the application
void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Google Mobile Ads
  await MobileAds.instance.initialize();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Set status bar color
  SystemChromeConfig.setImmersive(); // Set immersive mode
  // Run the app with ProviderScope
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// Root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return _ScreenUtilManager(
      child: MaterialApp.router(
        title: 'Free Kash',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: NavRouter.route, // Define router configuration
      ),
    );
  }
}

// A widget to manage screen utility settings
class _ScreenUtilManager extends StatelessWidget {
  const _ScreenUtilManager({required Widget child}) : _child = child;

  final Widget _child;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => child!,
      designSize: const Size(375, 812), // Design size for screen adaptation
      child: _child,
    );
  }
}
