import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:free_kash/presentation/routes/go_router/route_name.dart';
import 'package:free_kash/presentation/utils/utils.dart';
import 'package:animated_loading_indicators/animated_loading_indicators.dart';
import 'package:go_router/go_router.dart';

class AuthGatewayScreen extends StatefulWidget {
  const AuthGatewayScreen({super.key});

  @override
  State<AuthGatewayScreen> createState() => _AuthGatewayScreenState();
}

class _AuthGatewayScreenState extends State<AuthGatewayScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(
        const Duration(
          milliseconds: 500,
        ),
        () => FirebaseAuth.instance.userChanges().listen((user) {
          if (user == null) {
            debugPrint('User is currently signed out!');

            context.pushReplacementNamed(RouteName.auth);
          } else {
            debugPrint('User is signed in!   ${user.uid}');

            context.pushReplacementNamed(RouteName.dataValidator,
                pathParameters: {'id': user.uid});
          }
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircleAnimation(
          numberOfCircles: 10,
          duration: const Duration(milliseconds: 20),
          size: 5,
          circleRadius: 10,
          color: Palette.primary,
        ),
      ),
    );
  }
}
