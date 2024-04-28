// ignore_for_file: unused_element, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:free_kash/presentation/presentations.dart';
import 'package:free_kash/provider/provider.dart';
import 'package:free_kash/provider/providers/user_provider.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserDetailOnboarding extends StatefulWidget {
  const UserDetailOnboarding({super.key});

  @override
  State<UserDetailOnboarding> createState() => _UserDetailOnboardingState();
}

class _UserDetailOnboardingState extends State<UserDetailOnboarding> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _middleNameController;
  late TextEditingController _mobileNumberController;

  @override
  void initState() {
    _firstNameController = TextEditingController();
    _middleNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _mobileNumberController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _middleNameController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 15,
        ).w,
        child: Column(
          children: [
            _TopBody(
              firstNameController: _firstNameController,
              middleNameController: _middleNameController,
              lastNameController: _lastNameController,
              mobileNumberController: _mobileNumberController,
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBody extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController middleNameController;
  final TextEditingController mobileNumberController;
  _TopBody({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.middleNameController,
    required this.mobileNumberController,
  });

  String? _errorFirstName;
  String? _errorLastName;

  String? _errorMobileNumber;

  void _validateMobileNumber(String value, BuildContext context) {
    final ref = ProviderScope.containerOf(context);

    if (value.isEmpty) {
      _errorMobileNumber = 'Mobile number is required';

      ref.read(profileStateNotifierProvider.notifier).toggleOff();
    } else if (value.length < 8) {
      _errorMobileNumber = 'Invalid phone number format';
      ref.read(profileStateNotifierProvider.notifier).toggleOff();
    } else if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        mobileNumberController.text.isEmpty) {
      ref.read(profileStateNotifierProvider.notifier).toggleOff();
    } else if (!_isNumberValid(value)) {
      _errorMobileNumber = 'Invalid phone number format';
      ref.read(profileStateNotifierProvider.notifier).toggleOff();
    } else {
      _errorMobileNumber = null;
      ref.read(profileStateNotifierProvider.notifier).toggleOn();
    }
  }

  void _validateLastName(String value, BuildContext context) {
    final ref = ProviderScope.containerOf(context);
    if (value.isEmpty) {
      _errorLastName = 'Last name is required';
      ref.read(profileStateNotifierProvider.notifier).toggleOff();
    } else if (firstNameController.text.isEmpty ||
        mobileNumberController.text.isEmpty) {
      ref.read(profileStateNotifierProvider.notifier).toggleOff();
    } else {
      _errorLastName = null;
      ref.read(profileStateNotifierProvider.notifier).toggleOn();
    }
  }

  void _validateFirstName(String value, BuildContext context) {
    final ref = ProviderScope.containerOf(context);
    if (value.isEmpty) {
      _errorFirstName = 'First name is Required';
      ref.read(profileStateNotifierProvider.notifier).toggleOff();
    } else if (lastNameController.text.isEmpty ||
        mobileNumberController.text.isEmpty) {
      ref.read(profileStateNotifierProvider.notifier).toggleOff();
    } else {
      _errorFirstName = null;
      ref.read(profileStateNotifierProvider.notifier).toggleOn();
    }
  }

  bool _isNumberValid(String value) {
    final numbersOnly = RegExp(r'^[0-9]+$');

    return numbersOnly.hasMatch(value);
  }

  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(10.h),
            ReadexProText(
              data: 'Getting Started',
              color: Palette.text,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
            Gap(5.h),
            ReadexProText(
              data: 'Please update your personal details...',
              color: Palette.text,
              fontSize: 13.sp,
            ),
            Gap(20.h),
            AuthTextField(
              controller: firstNameController,
              validator: (value) => _errorFirstName,
              onChanged: (value) => _validateFirstName(value, context),
              labelDescription: 'First name',
              prefixIcon: Icon(
                Icons.account_circle_outlined,
                color: Palette.primary,
                size: 18.h,
              ),
            ),
            Gap(10.h),
            AuthTextField(
              controller: lastNameController,
              onChanged: (value) => _validateLastName(value, context),
              validator: (value) => _errorLastName,
              labelDescription: 'Last name',
              prefixIcon: Icon(
                Icons.account_circle_outlined,
                color: Palette.primary,
                size: 18.h,
              ),
            ),
            Gap(10.h),
            AuthTextField(
              controller: middleNameController,
              labelDescription: 'Middle name (Optonal)',
              prefixIcon: Icon(
                Icons.account_circle_outlined,
                color: Palette.primary,
                size: 18.h,
              ),
            ),
            Gap(10.h),
            AuthTextField(
              controller: mobileNumberController,
              validator: (value) => _errorMobileNumber,
              onChanged: (value) => _validateMobileNumber(value, context),
              labelDescription: 'Mobile number',
              prefixIcon: Icon(
                Icons.phone,
                color: Palette.primary,
                size: 18.h,
              ),
            ),
            Gap(60.h),
            Consumer(
              builder: (context, ref, child) {
                // final index = ref.watch(onboardingIndexProvider);

                final notifier = ref.watch(profileStateNotifierProvider);

                final value = (notifier == true);
                return CustomButton(
                  onTap: () async {
                    if (_key.currentState!.validate()) {
                      // final _userData = User(
                      //   firstName: firstNameController.text.trim(),
                      //   lastName: lastNameController.text.trim(),
                      //   middleName: (middleNameController.text.isEmpty)
                      //       ? null
                      //       : middleNameController.text.trim(),
                      //   mobileNumber: mobileNumberController.text.trim(),
                      // );

                      final user = ref.read(userProvider);

                      user.addUserDetails(
                        mobileNumbers: mobileNumberController.text.trim(),
                        firstNames: firstNameController.text.trim(),
                        lastNames: lastNameController.text.trim(),
                        middleNames: middleNameController.text.isEmpty
                            ? null
                            : middleNameController.text.trim(),
                      );

                      ref.read(onboardingIndexProvider.notifier).foward();

                      debugPrint(ref.read(userProvider).toJson().toString());
                    }
                  },
                  size: Size(MediaQuery.sizeOf(context).width, 45),
                  color: value ? Palette.primary : Palette.outline,
                  outlineColor: value ? Palette.primary : Palette.outline,
                  textColor: value ? Palette.surface : Palette.secondary,
                  description: 'Continue',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
