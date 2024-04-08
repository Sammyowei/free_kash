// ignore_for_file: use_build_context_synchronously

import 'package:animated_loading_indicators/animated_loading_indicators.dart';
import 'package:flutter/material.dart';
import 'package:free_kash/data/auth/auth.dart';
import 'package:free_kash/data/db/_db_config.dart';
import 'package:free_kash/presentation/routes/routes.dart';
import 'package:go_router/go_router.dart';

import '../../utils/utils.dart';

class ValidatorScreen extends StatefulWidget {
  const ValidatorScreen({super.key});

  @override
  State<ValidatorScreen> createState() => _ValidatorScreenState();
}

class _ValidatorScreenState extends State<ValidatorScreen> {
  void validate(BuildContext context) async {
    final id = AuthClient().userID;

    final data = await DbConfig(dbStore: 'users').read(id);

    print("data exist: ${data.snapshot.exists}");
    if (data.snapshot.exists) {
      print("data exist");
      context.goNamed(RouteName.dashboard, pathParameters: {'id': id!});
    } else {
      print("data does not exist");
      context.goNamed(RouteName.onboarding, pathParameters: {
        'id': id!,
      });
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(
        const Duration(milliseconds: 1000),
        () => validate(context),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('on This screen');
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
