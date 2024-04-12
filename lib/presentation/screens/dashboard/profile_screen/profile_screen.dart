// ignore_for_file: unused_element, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_kash/data/auth/auth.dart';
import 'package:free_kash/data/db/_db_config.dart';
import 'package:free_kash/presentation/presentations.dart';
import 'package:free_kash/presentation/routes/routes.dart';
import 'package:free_kash/provider/provider.dart';

import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/models/user/user.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 10,
          ).w,
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.85,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ReadexProText(
                  data: 'Profile',
                  fontWeight: FontWeight.bold,
                  fontSize: 22.sp,
                  color: Palette.text,
                ),
                Gap(30.h),
                CustomContainer(
                  size: Size(
                    MediaQuery.sizeOf(context).width,
                    80,
                  ),
                  child: _TopItems(
                    user: widget.user,
                  ),
                ),
                Gap(20.h),
                CustomContainer(
                  size: Size(
                    MediaQuery.sizeOf(context).width,
                    195,
                  ),
                  child: _MiddleBody(
                    user: widget.user,
                  ),
                ),
                Gap(20.h),
                CustomContainer(
                  size: Size(
                    MediaQuery.sizeOf(context).width,
                    180,
                  ),
                  child: _AfterTop(
                    user: widget.user,
                  ),
                ),
                Gap(30.h),
                const _BottomBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final Size size;
  final double radius;

  final Widget? child;
  const CustomContainer(
      {super.key, required this.size, this.radius = 15, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height.h,
      width: size.width.w,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius).r,
        ),
        color: Palette.surface,
        shadows: [
          BoxShadow(
            color: Palette.outline,
            blurRadius: 1.2,
          ),
        ],
      ),
      child: child,
    );
  }
}

class _TopItems extends StatelessWidget {
  final User user;
  const _TopItems({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(
              ImageAsset.avatar,
            ),
            radius: 30.r,
          ),
          Gap(5.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ReadexProText(
                data:
                    '${user.firstName}${user.middleName != null ? ' ${user.middleName} ' : ' '}${user.lastName}',
                fontSize: 16.sp,
                color: Palette.text,
                fontWeight: FontWeight.w600,
              ),
              ReadexProText(
                data: '${user.emailAddress}',
                fontSize: 12.sp,
                color: Palette.text,
                fontWeight: FontWeight.w300,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _AfterTop extends StatelessWidget {
  final User user;
  const _AfterTop({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CustomBotton(
          label: 'Withdraw',
          onTap: () {
            context.pushNamed(RouteName.withdrawal,
                pathParameters: {'id': AuthClient().userID!},
                extra: user.toJson());
          },
        ),
        _CustomBotton(
          label: 'Contact Support',
          onTap: () {
            context.pushNamed(
              RouteName.contactSupport,
              pathParameters: {'id': AuthClient().userID!},
            );
          },
        ),
        _CustomBotton(
          label: 'Refer and Earn',
          showDivider: false,
          onTap: () {
            context.pushNamed(RouteName.referral,
                pathParameters: {'id': AuthClient().userID!},
                extra: user.toJson());
          },
        ),
      ],
    );
  }
}

class _MiddleBody extends StatelessWidget {
  const _MiddleBody({super.key, required this.user});

  final User user;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _CustomBotton(
          label: 'Edit profile',
          onTap: () {
            context.pushNamed(RouteName.profile,
                pathParameters: {'id': AuthClient().userID!},
                extra: user.toJson());
          },
        ),
        _CustomBotton(
          label: 'Edit Bank Details',
          onTap: () {
            context.pushNamed(RouteName.bank,
                pathParameters: {'id': AuthClient().userID!},
                extra: user.toJson());
          },
        ),
        _CustomBotton(
          label: 'Delete Account',
          showDivider: false,
          isRed: true,
          onTap: () async {
            final _authClient = AuthClient();
            final _dbConfig = DbConfig(dbStore: 'users');
            final id = _authClient.userID;

            await _authClient.instance.currentUser!.delete();
            await _dbConfig.delete(id);

            if (context.mounted) {
              context.goNamed(RouteName.auth);
            }
          },
        ),
      ],
    );
  }
}

class _CustomBotton extends StatelessWidget {
  _CustomBotton({
    this.onTap,
    required this.label,
    this.showDivider = true,
    this.isRed = false,
  });

  final String label;

  final VoidCallback? onTap;

  final bool showDivider;

  final bool isRed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: 10,
            ).w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ReadexProText(
                  data: label,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                  color: isRed ? Palette.red : Palette.text,
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Icon(
                    Icons.navigate_next,
                    size: 30.h,
                    color: isRed ? Palette.red : Palette.text,
                  ),
                ),
              ],
            ),
          ),
          showDivider
              ? Divider(
                  color: Palette.outline,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class _BottomBody extends StatelessWidget {
  const _BottomBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return CustomButton(
          onTap: () async {
            final _client = AuthClient();

            await _client.logout();

            if (context.mounted) {
              context.pushReplacementNamed(
                RouteName.authGateway,
              );
              ref.read(dashboardPageNotifierProvider.notifier).moveTo(0);
            }
          },
          size: Size(MediaQuery.sizeOf(context).width, 45),
          description: 'Sign out',
          textColor: Palette.surface,
          color: Palette.red.withOpacity(0.7),
          outlineColor: Palette.red.withOpacity(0.7),
        );
      },
    );
  }
}
