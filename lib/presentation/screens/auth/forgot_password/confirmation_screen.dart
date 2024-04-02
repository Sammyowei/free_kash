import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_kash/presentation/presentations.dart';
import 'package:gap/gap.dart';

class ForgetPasswordConfirmationScreen extends StatelessWidget {
  const ForgetPasswordConfirmationScreen(
      {super.key, this.email = 'samuelsonowei04@gmail.com'});

  final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        backgroundColor: Palette.background,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15).w,
          child: Column(
            children: [
              _TopBody(email),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBody extends StatelessWidget {
  const _TopBody(this.email);
  final String email;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 25).w,
      child: Column(
        children: [
          Image.asset(
            ImageAsset.confirmatonMail,
            height: 346.h,
            width: 375.w,
          ),
          Gap(30.h),
          ReadexProText(
            data: 'Confirm your email',
            fontSize: 30.sp,
            fontWeight: FontWeight.w600,
            color: Palette.text,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0).w,
            child: ReadexProText(
              data: 'We just sent you an email to $email',
              color: Palette.secondary,
              fontSize: 14.sp,
              textAlign: TextAlign.center,
            ),
          ),
          Gap(30.h),
          CustomButton(
            size: Size(MediaQuery.sizeOf(context).width, 45),
            color: Palette.primary,
            outlineColor: Palette.primary,
            textColor: Palette.surface,
            description: 'Confirm',
          ),
          Gap(30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ReadexProText(
                data: "didn't recieve an email?",
                color: Palette.text,
              ),
              Gap(8.w),
              ReadexProText(
                data: 'click here',
                color: Palette.primary,
              ),
            ],
          )
        ],
      ),
    );
  }
}
