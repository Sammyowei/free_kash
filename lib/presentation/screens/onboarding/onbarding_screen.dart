import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_kash/presentation/presentations.dart';
import 'package:free_kash/provider/provider.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var tabs = const [
      UserDetailOnboarding(),
      BankOnboardingDetail(),
    ];

    return Scaffold(
      backgroundColor: Palette.background,
      body: Consumer(builder: (context, ref, _) {
        final index = ref.watch(onboardingIndexProvider);
        return SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OnboardingIndicatorContainer(
                    width: MediaQuery.sizeOf(context).width / 2.5,
                    color: Palette.primary,
                  ),
                  Gap(10.w),
                  OnboardingIndicatorContainer(
                    width: MediaQuery.sizeOf(context).width / 2.5,
                    color: (index == 1) ? Palette.primary : Palette.outline,
                  ),
                ],
              ),
              Expanded(child: tabs[index]),
            ],
          ),
        );
      }),
    );
  }
}

class OnboardingIndicatorContainer extends StatelessWidget {
  final Color? color;

  final double width;
  const OnboardingIndicatorContainer({super.key, this.color, this.width = 50});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10).r),
        color: color ?? Palette.outline,
      ),
      height: 6.h,
      width: width.w,
    );
  }
}
