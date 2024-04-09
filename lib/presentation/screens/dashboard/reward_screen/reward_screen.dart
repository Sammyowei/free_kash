// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_kash/data/data.dart';
import 'package:free_kash/data/models/user/user.dart';
import 'package:free_kash/presentation/presentations.dart';
import 'package:gap/gap.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen(
      {super.key, required this.user, required this.rewardedAds});

  final User user;

  final RewardedVideoAds rewardedAds;

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 10).w,
        child: Column(
          children: [
            _TopBody(
              rewardedVideoAds: widget.rewardedAds,
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBody extends StatelessWidget {
  const _TopBody({super.key, required this.rewardedVideoAds});

  final RewardedVideoAds rewardedVideoAds;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReadexProText(
          data: 'Earn Rewards',
          color: Palette.text,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
        Gap(20.h),
        ReadexProText(
          data:
              "Please take note: You'll earn 10 FreeKash points for watching an ad, and 30 FreeKash points for both watching and clicking on an ad.",
          color: Palette.secondary,
          fontSize: 16.sp,
          textAlign: TextAlign.center,
        ),
        Gap(400.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              onTap: () async {
                rewardedVideoAds.showAds();
              },
              size: Size(MediaQuery.sizeOf(context).width * 0.5, 40),
              color: Palette.primary,
              outlineColor: Palette.primary,
              textColor: Palette.surface,
              description: 'Watch Ads Now!',
            ),
          ],
        )
      ],
    );
  }
}
