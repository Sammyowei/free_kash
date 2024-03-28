import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_kash/presentation/presentations.dart';
import 'package:free_kash/presentation/routes/go_router/route_name.dart';
import 'package:free_kash/presentation/utils/utils.dart';
import 'package:go_router/go_router.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 2),
      () {
        context.pushReplacementNamed(RouteName.authGateway);

        SystemChromeConfig.toggleOff();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primary,
      body: Center(
        child: ReadexProText(
          data: 'FreeKash',
          fontWeight: FontWeight.bold,
          color: Palette.background,
          fontSize: 22.sp,
        ),
      ),
    );
  }
}
