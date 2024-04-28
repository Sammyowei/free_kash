// ignore_for_file: must_be_immutable, no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_kash/presentation/routes/routes.dart';
import 'package:free_kash/provider/provider.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../data/auth/auth.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController _emailEditingController;

  late TextEditingController _passwordEditingController;

  @override
  void initState() {
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              TopBody(
                emailController: _emailEditingController,
                passwordController: _passwordEditingController,
              ),
              Gap(150.h),
              const BottomBody(),
            ],
          ),
        ));
  }
}

class TopBody extends StatelessWidget {
  TopBody(
      {super.key,
      required this.emailController,
      required this.passwordController});

  final TextEditingController emailController;
  final TextEditingController passwordController;

  String? _emailErrorText;
  String? _passwordTextError;

  void _validateEmail(String value, BuildContext context) {
    final container = ProviderScope.containerOf(context);
    if (value.isEmpty) {
      container.read(loginFormValidatorProvider.notifier).toggleOff();
      _emailErrorText = 'Email is required';
    } else if (!_isEmailValid(value)) {
      container.read(loginFormValidatorProvider.notifier).toggleOff();
      _emailErrorText = 'Enter a valid email address';
    } else if (!_isPasswordValid(passwordController.text.trim())) {
      container.read(loginFormValidatorProvider.notifier).toggleOff();
      _emailErrorText = null;
    } else {
      _emailErrorText = null;
      container.read(loginFormValidatorProvider.notifier).toggleOn();
    }
  }

  void _validatePassword(String value, BuildContext context) {
    final container = ProviderScope.containerOf(context);
    if (value.isEmpty) {
      _passwordTextError = 'Password is Required';
      container.read(loginFormValidatorProvider.notifier).toggleOff();
    } else if (value.length < 5) {
      container.read(loginFormValidatorProvider.notifier).toggleOff();
      _passwordTextError = 'Password length must be greater than 5 characters';
    } else if (!_isPasswordValid(value)) {
      container.read(loginFormValidatorProvider.notifier).toggleOff();
      _passwordTextError =
          'Password should contain at least 1 Capital letter, 1 small letter, 1 special character and 1 number';
    } else if (!_isEmailValid(emailController.text.toLowerCase().trim())) {
      container.read(loginFormValidatorProvider.notifier).toggleOff();
      _passwordTextError = null;
    } else {
      _passwordTextError = null;
      container.read(loginFormValidatorProvider.notifier).toggleOn();
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitForm(BuildContext context) async {
    final container = ProviderScope.containerOf(context);
    if (_formKey.currentState!.validate()) {
      container.read(loadingProvider.notifier).toggleOn();

      final _client = AuthClient();

      final response = await _client.loginWithEmailPassword(
          emailController.text.trim(), passwordController.text.trim());

      if (response is ErrorAuthResponse) {
        final message = response.message;

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: ReadexProText(
                data: message,
              ),
              backgroundColor: Palette.red,
            ),
          );
        }
        // container.read(loginFormValidatorProvider.notifier).tuggleOff();
        container.read(loadingProvider.notifier).toggleOff();
        return;
      }

      if (response is SuccessAuthResponse) {
        if (context.mounted) {
          // context.pushNamed(RouteName.confirmation,
          //     queryParameters: {'email': _controller.text.trim()});
          // container.read(loginFormValidatorProvider.notifier).tuggleOff();
          container.read(loadingProvider.notifier).toggleOff();

          context.goNamed(RouteName.dataValidator,
              pathParameters: {'id': _client.userID!});
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
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
                  onChanged: (value) => _validateEmail(value, context),
                  controller: emailController,
                  validator: (value) => _emailErrorText,
                ),
                Gap(10.h),

                Consumer(
                  builder: (context, ref, child) {
                    final obscureText = ref.watch(obscureTextProvider);

                    return AuthTextField(
                      onChanged: (value) => _validatePassword(value, context),
                      controller: passwordController,
                      validator: (value) => _passwordTextError,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Palette.primary,
                        size: 18.h,
                      ),
                      obscureText: obscureText,
                      labelDescription: 'Password',
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
                        onTap: () =>
                            context.pushNamed(RouteName.forgotPassword),
                        child: ReadexProText(
                          data: 'Click here',
                          color: Palette.primary,
                        ),
                      )
                    ],
                  ),
                ),
                Gap(30.h),

                Consumer(
                  builder: (context, ref, child) {
                    final value = ref.watch(loginFormValidatorProvider);

                    final loading = ref.watch(loadingProvider);

                    final isValid = (value == true);

                    final isLoading = (loading == true);
                    return CustomButton(
                      widget: isLoading
                          ? CircularProgressIndicator(
                              color: Palette.surface,
                              strokeWidth: 2,
                              strokeCap: StrokeCap.round,
                            )
                          : null,
                      onTap: !isValid ? null : () => _submitForm(context),
                      size: Size(MediaQuery.sizeOf(context).width, 45),
                      color: isValid ? Palette.primary : Palette.outline,
                      outlineColor: isValid ? Palette.primary : Palette.outline,
                      textColor: isValid ? Palette.surface : Palette.secondary,
                      description: 'Sign in',
                    );
                  },
                ),
              ],
            ),
          ),
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
                onTap: () async {
                  await AuthClient().loginWithFederatedProvider(
                      FederatedAuthProvider.facebook, context);
                },
                imagePath: ImageAsset.facebook,
              ),
              (Platform.isIOS)
                  ? Row(
                      children: [
                        Gap(25.w),
                        SocialSignInButton(
                          radius: 10,
                          size: const Size(48, 48),
                          onTap: () async {},
                          imagePath: ImageAsset.apple,
                        ),
                      ],
                    )
                  : Gap(0.w),
              Gap(25.w),
              SocialSignInButton(
                radius: 10,
                imagePath: ImageAsset.google,
                size: const Size(48, 48),
                onTap: () async {
                  await AuthClient().loginWithFederatedProvider(
                      FederatedAuthProvider.google, context);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
