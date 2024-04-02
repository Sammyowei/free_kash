// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_kash/data/auth/auth.dart';
import 'package:free_kash/presentation/presentations.dart';
import 'package:free_kash/presentation/routes/routes.dart';
import 'package:free_kash/provider/provider.dart';

import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AccountCreationScreen extends StatefulWidget {
  const AccountCreationScreen({super.key});

  @override
  State<AccountCreationScreen> createState() => _AccountCreationScreenState();
}

class _AccountCreationScreenState extends State<AccountCreationScreen> {
  late TextEditingController _emailEditingController;

  late TextEditingController _passwordEditingController;

  late TextEditingController _referalCodeEditingController;

  @override
  void initState() {
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
    _referalCodeEditingController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    _referalCodeEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        backgroundColor: Palette.background,
        centerTitle: true,
        title: ReadexProText(
          data: 'FreeKash',
          color: Palette.primary,
          fontWeight: FontWeight.w700,
          fontSize: 18.sp,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _TopBody(
              emailController: _emailEditingController,
              passwordController: _passwordEditingController,
              referalcodeController: _referalCodeEditingController,
            ),
            Gap(50.h),
            const _BottomBody(),
          ],
        ),
      ),
    );
  }
}

class _TopBody extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  final TextEditingController referalcodeController;

  _TopBody({
    required this.emailController,
    required this.passwordController,
    required this.referalcodeController,
  });

  String? _emailErrorText;
  String? _passwordTextError;

  void _validateEmail(String value, BuildContext context) {
    final container = ProviderScope.containerOf(context);
    if (value.isEmpty) {
      container.read(signupFormValidatorProvider.notifier).toggleOff();
      _emailErrorText = 'Email is required';
    } else if (!_isEmailValid(value)) {
      container.read(signupFormValidatorProvider.notifier).toggleOff();
      _emailErrorText = 'Enter a valid email address';
    } else if (!_isPasswordValid(passwordController.text.trim())) {
      container.read(signupFormValidatorProvider.notifier).toggleOff();
      _emailErrorText = null;
    } else {
      _emailErrorText = null;
      container.read(signupFormValidatorProvider.notifier).toggleOn();
    }
  }

  void _validatePassword(String value, BuildContext context) {
    final container = ProviderScope.containerOf(context);
    if (value.isEmpty) {
      _passwordTextError = 'Password is Required';
      container.read(signupFormValidatorProvider.notifier).toggleOff();
    } else if (value.length < 5) {
      container.read(signupFormValidatorProvider.notifier).toggleOff();
      _passwordTextError = 'Password length must be greater than 5 characters';
    } else if (!_isPasswordValid(value)) {
      container.read(signupFormValidatorProvider.notifier).toggleOff();
      _passwordTextError =
          'Password should contain at least:\n1 Capital letter\n1 small letter\n1 special character\n1 number';
    } else if (!_isEmailValid(emailController.text.toLowerCase().trim())) {
      container.read(signupFormValidatorProvider.notifier).toggleOff();
      _passwordTextError = null;
    } else {
      _passwordTextError = null;
      container.read(signupFormValidatorProvider.notifier).toggleOn();
    }
  }

  bool _isEmailValid(String email) {
    final RegExp emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      caseSensitive: false,
      multiLine: false,
    );

    return emailRegex.hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    RegExp passwordRegex = RegExp(
        r"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$%^&*()_+{}|:'<>?~`\\\-=[\]\\;\',.\/]).*$");

    return passwordRegex.hasMatch(password);
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitForm(BuildContext context) async {
    final ref = ProviderScope.containerOf(context);
    if (_formKey.currentState!.validate()) {
      ref.read(loadingProvider.notifier).toggle();

      // Perform the Authentication Logic

      final _authClient = AuthClient();

      final response = await _authClient.registerWithEmailPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (response is ErrorAuthResponse) {
        if (context.mounted) {
          ref.read(loadingProvider.notifier).toggle();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: ReadexProText(
                data: response.message,
                color: Palette.surface,
                fontSize: 12.sp,
              ),
              backgroundColor: Palette.red,
            ),
          );
        }

        return;
      }

      debugPrint((response as SuccessAuthResponse).message);

      ref.read(loadingProvider.notifier).toggle();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15).w,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ).w,
              child: ReadexProText(
                data: 'Create your account now!',
                color: Palette.text,
                fontSize: 30.sp,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(20.h),
            AuthTextField(
              labelDescription: 'Email address',
              controller: emailController,
              validator: (value) => _emailErrorText,
              onChanged: (value) => _validateEmail(value, context),
            ),
            Gap(10.h),
            AuthTextField(
              controller: referalcodeController,
              labelDescription: 'Refferal code (optional)',
              prefixIcon: Icon(
                Icons.supervised_user_circle_outlined,
                size: 18.h,
                color: Palette.primary,
              ),
            ),
            Gap(10.h),
            Consumer(
              builder: (context, ref, child) {
                final obscureText = ref.watch(obscureTextProvider);

                return AuthTextField(
                  onChanged: (value) => _validatePassword(value, context),
                  controller: passwordController,
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Palette.primary,
                    size: 18.h,
                  ),
                  obscureText: obscureText,
                  labelDescription: 'Password',
                  validator: (value) => _passwordTextError,
                  sulfixIcon: GestureDetector(
                    onTap: () =>
                        ref.read(obscureTextProvider.notifier).toggle(),
                    child: obscureText
                        ? Icon(
                            Icons.remove_red_eye_outlined,
                            color: Palette.primary,
                            size: 18.h,
                          )
                        : Image.asset(
                            ImageAsset.hide,
                            color: Palette.primary,
                            scale: 25.h,
                          ),
                  ),
                );
              },
            ),
            Gap(20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ReadexProText(
                  data: 'Have an account?',
                  color: Palette.text,
                ),
                Gap(5.w),
                GestureDetector(
                  onTap: () => context.pushNamed(RouteName.signIn),
                  child: ReadexProText(
                    data: 'Log in here',
                    color: Palette.primary,
                  ),
                )
              ],
            ),
            Gap(30.h),
            Consumer(
              builder: (context, ref, child) {
                final loading = ref.watch(loadingProvider);

                final validator = ref.watch(signupFormValidatorProvider);

                final isValid = (validator == true);

                final isLoading = (loading == true);

                return CustomButton(
                  onTap: () => _submitForm(context),
                  widget: isLoading
                      ? CircularProgressIndicator(
                          color: Palette.surface,
                          strokeWidth: 2,
                          strokeCap: StrokeCap.round,
                        )
                      : null,
                  size: Size(MediaQuery.sizeOf(context).width, 45),
                  outlineColor: isValid ? Palette.primary : Palette.outline,
                  color: isValid ? Palette.primary : Palette.outline,
                  textColor: isValid ? Palette.surface : Palette.secondary,
                  description: 'Continue',
                );
              },
            ),
            Gap(30.h),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ReadexProText(
                data:
                    'By registering you accept our Terms & Conditions and Privacy Policy. Your data will be security encrypted with TLS',
                textAlign: TextAlign.center,
                fontSize: 12.sp,
                color: Palette.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomBody extends StatelessWidget {
  const _BottomBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(
                color: Palette.outline,
              ),
            ),
            SizedBox(
              width: 120.w,
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
        Gap(30.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialSignInButton(
              onTap: () async => await AuthClient().loginWithFederatedProvider(
                FederatedAuthProvider.facebook,
              ),
              radius: 10,
              size: const Size(48, 48),
              imagePath: ImageAsset.facebook,
            ),
            (Platform.isIOS)
                ? Row(
                    children: [
                      Gap(30.w),
                      SocialSignInButton(
                        radius: 10,
                        size: const Size(48, 48),
                        imagePath: ImageAsset.apple,
                      )
                    ],
                  )
                : SizedBox(
                    width: 30.w,
                  ),
            SocialSignInButton(
              onTap: () async {
                await AuthClient().loginWithFederatedProvider(
                  FederatedAuthProvider.google,
                );
              },
              radius: 10,
              size: const Size(48, 48),
              imagePath: ImageAsset.google,
            ),
          ],
        ),
      ],
    );
  }
}
