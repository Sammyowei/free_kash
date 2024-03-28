import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_kash/presentation/utils/color_palette/color_palette.dart';
import 'package:gap/gap.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.background,
        appBar: AppBar(
          title: ReadexProText(
            data: 'FreeKash',
            fontSize: 20.sp,
            color: Palette.primary,
            fontWeight: FontWeight.w600,
          ),
          centerTitle: true,
          backgroundColor: Palette.background,
        ),
        body: Column(
          children: [
            const TopBody(),
            Gap(150.h),
            const BottomBody(),
          ],
        ));
  }
}

class TopBody extends StatelessWidget {
  const TopBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10).w,
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15).w,
              child: ReadexProText(
                data: 'Login to your Account',
                textAlign: TextAlign.center,
                color: Palette.text,
                fontWeight: FontWeight.w600,
                fontSize: 30.sp,
              ),
            ),

            Gap(20.h),
            // Satart adding the text field for Email and Passowrd

            // Email TextField

            AuthTextField(
              onChanged: (value) => debugPrint(value),
            ),
            Gap(10.h),
            AuthTextField(
              onChanged: (value) => debugPrint(value),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: Palette.primary,
                size: 18.h,
              ),
              labelDescription: 'Password',
            ),

            Gap(20.h),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ReadexProText(
                    data: 'Forgot your password?',
                    color: Palette.text,
                    fontSize: 14.sp,
                  ),
                  Gap(3.w),
                  GestureDetector(
                    child: ReadexProText(
                      data: 'Click here',
                      color: Palette.primary,
                    ),
                  )
                ],
              ),
            ),
            Gap(30.h),
            CustomButton(
              size: Size(
                MediaQuery.sizeOf(context).width,
                45,
              ),
              color: Palette.primary,
              outlineColor: Palette.primary,
              textColor: Palette.surface,
              description: 'Sign in',
            )
          ],
        ),
      ),
    );
  }
}

class BottomBody extends StatelessWidget {
  const BottomBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          SizedBox(
            child: Row(
              children: [
                Expanded(
                    child: Divider(
                  color: Palette.outline,
                )),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.3,
                  child: Center(
                    child: ReadexProText(
                      data: 'or continue with',
                      color: Palette.text,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Palette.outline,
                  ),
                ),
              ],
            ),
          ),
          Gap(40.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SocialSignInButton(
                radius: 10,
                size: const Size(48, 48),
                onTap: () {},
              ),
              (Platform.isIOS)
                  ? Row(
                      children: [
                        Gap(25.w),
                        SocialSignInButton(
                          radius: 10,
                          size: const Size(48, 48),
                          onTap: () {},
                        ),
                      ],
                    )
                  : Gap(0.w),
              Gap(25.w),
              SocialSignInButton(
                radius: 10,
                size: const Size(48, 48),
                onTap: () {},
              )
            ],
          ),
        ],
      ),
    );
  }
}
