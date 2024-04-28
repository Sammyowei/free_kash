// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_kash/data/models/user/user.dart';
import 'package:free_kash/presentation/presentations.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:share_plus/share_plus.dart';

class ReferalScreen extends StatefulWidget {
  final User user;
  const ReferalScreen({super.key, required this.user});

  @override
  State<ReferalScreen> createState() => _ReferalScreenState();
}

class _ReferalScreenState extends State<ReferalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        backgroundColor: Palette.background,
        title: ReadexProText(
          data: 'Refer and Earn',
          color: Palette.text,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15).w,
        child: Column(
          children: [
            const _TopContainer(),
            _Body(user: widget.user),
          ],
        ),
      ),
    );
  }
}

class _TopContainer extends StatelessWidget {
  const _TopContainer();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.sizeOf(context).width,
      decoration: ShapeDecoration(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15).r),
        color: Palette.orange,
      ),
      padding: const EdgeInsets.all(8.0).w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.6,
            child: ReadexProText(
              data: 'Get up to ₣150 Freekash points when you refer a friend',
              color: Palette.surface,
            ),
          ),
          SizedBox(
            child: Image.asset(ImageAsset.referal),
          )
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final User user;

  const _Body({required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(10.h),
        _CustomContainer(
          size: Size(MediaQuery.sizeOf(context).width, 150),
          child: Column(
            children: [
              ReadexProText(
                data: 'Invite family & friends',
                color: Palette.text,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
              Gap(5.h),
              ReadexProText(
                data: 'Copy your code and share it with your friends',
                color: Palette.text,
                fontSize: 12.sp,
              ),
              Gap(30.h),
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: 45.h,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30).r,
                  ),
                  color: Palette.outline,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ReadexProText(
                        data: user.referralCode ?? "",
                        color: Palette.text,
                        fontWeight: FontWeight.w400,
                        fontSize: 13.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await Clipboard.setData(
                          ClipboardData(text: user.referralCode ?? ''),
                        );

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Palette.green,
                              content: ReadexProText(
                                data: 'Copied!',
                                color: Palette.surface,
                              ),
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 45.h,
                        width: 70.w,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30).r,
                          ),
                          color: Palette.primary,
                        ),
                        child: Center(
                          child: ReadexProText(
                            data: 'Copy',
                            color: Palette.surface,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Gap(50.h),
        _CustomContainer(
          size: Size(MediaQuery.sizeOf(context).width, 200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReadexProText(
                data: 'How it works?',
                color: Palette.text,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
              Gap(10.h),
              const _HowDesc(
                description: 'Invite your friends and family.',
              ),
              Gap(5.h),
              const _HowDesc(
                index: 2,
                description: 'Ensure they successfully sign up with code.',
              ),
              Gap(5.h),
              const _HowDesc(
                index: 3,
                description: 'You earn about ₣150 FreeKash points.',
              ),
            ],
          ),
        ),
        Gap(50.h),
        CustomButton(
          size: Size(
            MediaQuery.sizeOf(context).width,
            45,
          ),
          onTap: () async {
            final text = """


Hey friends! Want to earn some extra cash in your free time? Check out FreeKash, the app where you can make money just by watching ads! Use my referral code ${user.referralCode} to sign up and start earning today. Let's cash in together! 💸 #FreeKash #EarnMoney #ReferralCode

""";
            final result = await Share.shareWithResult(text);

            if (result.status == ShareResultStatus.success) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Palette.green,
                    content: ReadexProText(
                      data:
                          'Congratulations, you have successfully shared your referral code',
                      color: Palette.surface,
                    ),
                  ),
                );
              }
            }
          },
          color: Palette.primary,
          outlineColor: Palette.primary,
          textColor: Palette.surface,
          description: 'Share referral code',
        )
      ],
    );
  }
}

class _HowDesc extends StatelessWidget {
  final int index;

  final String description;

  const _HowDesc({this.index = 1, this.description = 'Hello world'});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: 45.h,
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: Palette.outline,
            child: ReadexProText(
              data: index.toString(),
              color: Palette.secondary,
              fontSize: 14.sp,
            ),
          ),
          Gap(10.w),
          ReadexProText(
            data: description,
            fontSize: 12.sp,
            color: Palette.secondary,
          )
        ],
      ),
    );
  }
}

class _CustomContainer extends StatelessWidget {
  const _CustomContainer({required this.size, this.child, this.radius = 15});

  final Size size;

  final Widget? child;

  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height.h,
      width: size.width.w,
      padding: const EdgeInsets.all(8.0).w,
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius).r,
          ),
          color: Palette.surface,
          shadows: [
            BoxShadow(
              color: Palette.outline,
              blurRadius: 4,
            )
          ]),
      child: child,
    );
  }
}
