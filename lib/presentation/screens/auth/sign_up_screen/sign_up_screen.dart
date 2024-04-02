import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_kash/presentation/presentations.dart';
import 'package:free_kash/presentation/routes/routes.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        backgroundColor: Palette.background,
      ),
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: const Column(
          children: [
            _TopBody(),
          ],
        ),
      ),
    );
  }
}

class _TopBody extends StatelessWidget {
  const _TopBody();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10).w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ReadexProText(
            data: 'Get started in 3 easy steps',
            color: Palette.text,
            fontSize: 30.sp,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
          Image.asset(
            ImageAsset.accountCreation,
          ),
          const CustomStepperWithDesc(),
          Gap(20.h),
          CustomButton(
            size: Size(MediaQuery.sizeOf(context).width, 45),
            textColor: Palette.surface,
            color: Palette.primary,
            outlineColor: Palette.primary,
            description: 'Continue',
            onTap: () => context.pushNamed(
              RouteName.accountCreation,
            ),
          )
        ],
      ),
    );
  }
}

class CustomStepperWithDesc extends StatelessWidget {
  const CustomStepperWithDesc({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.h,
      child: Stack(
        children: [
          const Align(
            alignment: Alignment(-0.399, -0.5),
            child: LineDrawer(),
          ),
          Align(
            alignment: const Alignment(0.525, -0.5),
            child: SizedBox(
              height: 100.h,
              width: MediaQuery.sizeOf(context).width * 0.6,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DescContainer(
                    value: '1',
                    desc: 'Create your account',
                  ),
                  DescContainer(
                    value: '2',
                    desc: 'Complete the onboarding',
                  ),
                  DescContainer(
                    value: '3',
                    desc: 'Start Earning',
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DescContainer extends StatelessWidget {
  final String value;

  final String desc;
  const DescContainer(
      {super.key, this.desc = 'Create your account', this.value = '1'});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Container(
            height: 25.h,
            width: 25.w,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Palette.primary),
            child: Center(
              child: ReadexProText(
                data: value,
                color: Palette.surface,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ),
          Gap(10.w),
          ReadexProText(
            data: desc,
            fontWeight: FontWeight.w400,
            color: Palette.text,
            fontSize: 14.sp,
          )
        ],
      ),
    );
  }
}

class LineDrawer extends StatelessWidget {
  const LineDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      width: 2.w,
      color: Palette.primary,
    );
  }
}
