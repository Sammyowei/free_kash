// ignore_for_file: unused_element

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_kash/data/data.dart';
import 'package:free_kash/presentation/presentations.dart';

import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/user/user.dart';
import '../../../../provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.user});

  final User user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 10).w,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _TopBody(
                user: widget.user,
              ),
              const _MiddleBody(),
              Gap(10.h),
              _BottomBody(
                user: widget.user,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBody extends StatelessWidget {
  final User user;
  const _TopBody({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 25.r,
              backgroundColor: Palette.primary.withOpacity(0.5),
              backgroundImage: AssetImage(
                ImageAsset.avatar,
              ),
            ),
            Gap(5.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReadexProText(
                  data: 'Hello, ${user.firstName}',
                  color: Palette.text,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
                ReadexProText(
                  data: greeting(),
                  color: Palette.text,
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                ),
              ],
            )
          ],
        ),
        Gap(20.h),
        WalletScreen(
          amount: user.wallet!.walletBalance,
        ),
        Gap(20.h)
      ],
    );
  }
}

String greeting() {
  final time = DateTime.now();

  if (time.hour < 12) {
    return 'Good Morning ☀️';
  } else if (time.hour < 17) {
    return 'Good Afternoon 🌤️';
  } else {
    return 'Good Evening 🌙';
  }
}

class WalletScreen extends StatelessWidget {
  final double amount;
  const WalletScreen({super.key, required this.amount});

  String formatedAmount(double amount) {
    final formatCurrency = NumberFormat.currency(
      name: 'FreeKash Points',
      symbol: '₣',
    );

    return formatCurrency.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final format = formatedAmount(amount);
    return Container(
      height: 150.h,
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(10).w,
      decoration: ShapeDecoration(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15).r),
        gradient: LinearGradient(
          colors: [
            Palette.primary,
            Palette.primary.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          tileMode: TileMode.mirror,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ReadexProText(
                data: 'Available balance',
                color: Palette.surface,
                fontWeight: FontWeight.w400,
                fontSize: 13.sp,
              ),
              Gap(10.w),
              Consumer(
                builder: (context, ref, child) {
                  final obscureText = ref.watch(obscureTextProvider);
                  return GestureDetector(
                    onTap: () =>
                        ref.watch(obscureTextProvider.notifier).toggle(),
                    child: obscureText
                        ? Icon(
                            Icons.remove_red_eye_outlined,
                            color: Palette.surface,
                            size: 18.h,
                          )
                        : Image.asset(
                            ImageAsset.hide,
                            color: Palette.surface,
                            scale: 25.h,
                          ),
                  );
                },
              )
            ],
          ),
          Consumer(
            builder: (context, ref, child) {
              final obscureText = ref.watch(obscureTextProvider);
              return ReadexProText(
                data: obscureText ? '****' : format,
                color: Palette.surface,
                fontWeight: FontWeight.w600,
                fontSize: 22.sp,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _MiddleBody extends StatelessWidget {
  const _MiddleBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ReadexProText(
          data: 'Reward Earnings',
          color: Palette.text,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(
          height: 20.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ReadexProText(
                data: 'see more',
                color: Palette.primary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              Icon(
                Icons.navigate_next_outlined,
                color: Palette.primary,
                size: 22.h,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _BottomBody extends StatelessWidget {
  const _BottomBody({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final rewards = user.rewardHistory;
    if (rewards.isEmpty) {
      return const NothingToSeeHere();
    } else {
      return SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.545,
        child: ListView.builder(
            itemCount: rewards.length > 5 ? 5 : rewards.length,
            itemBuilder: (context, index) {
              final reversedList = rewards.reversed.toList();

              return Padding(
                padding: const EdgeInsets.only(bottom: 8).w,
                child: RewardContainer(
                  reward: reversedList[index],
                ),
              );
            }),
      );
    }
  }
}

class RewardContainer extends StatelessWidget {
  const RewardContainer({
    super.key,
    required this.reward,
  });

  final Reward reward;

  String formatedAmount(double amount) {
    final formatCurrency = NumberFormat.currency(
      name: 'FreeKash Points',
      symbol: '₣',
    );

    return formatCurrency.format(amount);
  }

  String formatedDate(DateTime date) {
    return DateFormat.yMMMMEEEEd().format(date);
  }

  @override
  Widget build(BuildContext context) {
    final amount = formatedAmount(reward.amount);

    final date = formatedDate(reward.createdAt);
    return Container(
      height: 70,
      padding: const EdgeInsets.all(10).w,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10).r,
        ),
        color: Palette.surface,
        shadows: const [BoxShadow()],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReadexProText(
                data: reward.description,
                fontSize: 16.sp,
                color: Palette.text,
              ),
              ReadexProText(
                data: date,
                color: Palette.secondary.withOpacity(0.8),
                fontSize: 12.sp,
              ),
            ],
          ),
          ReadexProText(
            data: '+$amount',
            fontSize: 16.sp,
            color: Palette.green,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}

class NothingToSeeHere extends StatelessWidget {
  const NothingToSeeHere({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Gap(100.h),
        Icon(
          Icons.cancel_outlined,
          color: Palette.orange,
          size: 80.h,
        ),
        Gap(5.h),
        ReadexProText(
          data: 'Oops, Nothing to see here!!',
          color: Palette.text,
          fontSize: 16.sp,
        ),
        Gap(100.h),
        CustomButton(
          size: Size(
            MediaQuery.sizeOf(context).width * 0.6,
            40,
          ),
          color: Palette.primary,
          outlineColor: Palette.primary,
          description: 'Earn Now!',
          textColor: Palette.surface,
        )
      ],
    );
  }
}
