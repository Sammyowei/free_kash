import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_kash/presentation/presentations.dart';
import 'package:gap/gap.dart';

class SocialSignInButton extends StatelessWidget {
  final double radius;

  final Size size;

  final void Function()? onTap;
  final String? description;

  final String? imagePath;
  const SocialSignInButton({
    super.key,
    this.onTap,
    required this.radius,
    required this.size,
    this.imagePath,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size.height.h,
        width: size.width.w,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        padding: const EdgeInsets.only(left: 10, right: 10).w,
        decoration: ShapeDecoration(
          color: Palette.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius).r,
            side: BorderSide(
              color: Palette.outline,
              width: 1,
            ),
          ),
        ),
        child: (description != null)
            ? Row(
                children: [
                  (imagePath == null)
                      ? FlutterLogo(
                          style: FlutterLogoStyle.markOnly,
                          size: (size.height * 0.4).h,
                        )
                      : Image.asset(
                          imagePath!,
                          height: (size.height * 0.4).h,
                        ),
                  Gap(10.w),
                  ReadexProText(
                    data: description!,
                    color: Palette.text,
                    fontSize: 14.sp,
                  )
                ],
              )
            : Center(
                child: (imagePath == null)
                    ? FlutterLogo(
                        style: FlutterLogoStyle.markOnly,
                        size: (size.height * 0.4).h,
                      )
                    : Image.asset(
                        imagePath!,
                        height: (size.height * 0.4).h,
                        width: (size.width * 0.4).w,
                      ),
              ),
      ),
    );
  }
}
