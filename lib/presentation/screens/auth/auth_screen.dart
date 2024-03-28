import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_kash/presentation/presentations.dart';
import 'package:free_kash/presentation/routes/go_router/route_name.dart';
import 'package:free_kash/presentation/utils/color_palette/color_palette.dart';
import 'package:free_kash/presentation/utils/utils.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Palette.background,
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [BodyWithButton(), BottomButton()],
          ),
        ),
      ),
    );
  }
}

class BodyWithButton extends StatelessWidget {
  const BodyWithButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
        ).w,
        child: Column(
          children: [
            ReadexProText(
              data: 'FreeKash',
              fontSize: 18.sp,
              color: Palette.primary,
              fontWeight: FontWeight.bold,
            ),
            Gap(35.h),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10).w,
              child: ReadexProText(
                textAlign: TextAlign.center,
                data: 'Hello! Start earning amazing rewards today',
                color: Palette.text,
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gap(20.h),
            SocialSignInButton(
              radius: 10,
              size: Size(MediaQuery.sizeOf(context).width, 55),
              description: 'Continue with Facebook',
              onTap: () {
                debugPrint('Hello World');
              },
            ),
            Gap(10.h),
            SocialSignInButton(
              radius: 10,
              size: Size(MediaQuery.sizeOf(context).width, 55),
              description: 'Continue with Google',
            ),
            Gap(10.h),
            (!Platform.isIOS)
                ? Container()
                : SocialSignInButton(
                    radius: 10,
                    size: Size(MediaQuery.sizeOf(context).width, 55),
                    description: 'Continue with Apple',
                  ),
            Gap(10.h),
            CustomButton(
              onTap: () => context.pushNamed(RouteName.signup),
              size: Size(MediaQuery.sizeOf(context).width, 50),
              description: 'Sign up with email',
              color: Palette.primary,
              outlineColor: Palette.primary,
              textColor: Palette.surface,
            )
          ],
        ),
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  const BottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Palette.outline,
                  ),
                ),
                SizedBox(
                  width: 170.w,
                  child: Center(
                    child: ReadexProText(
                      data: 'Already have an account?',
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Palette.outline,
                  ),
                )
              ],
            ),
          ),
          Gap(20.h),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 8).w,
            child: CustomButton(
              onTap: () => context.pushNamed(RouteName.signIn),
              size: Size(MediaQuery.sizeOf(context).width, 50),
              description: 'Sign in',
              outlineColor: Palette.primary,
              textColor: Palette.primary,
            ),
          ),
          Gap(70.h),
        ],
      ),
    );
  }
}
