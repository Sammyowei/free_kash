// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_kash/data/auth/auth_client.dart';
import 'package:free_kash/presentation/presentations.dart';
import 'package:free_kash/presentation/routes/routes.dart';
import 'package:free_kash/provider/provider.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/auth/auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Palette.background,
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
            _TopBody(_controller),
            Gap(120.h),
            const _BottomBody(),
          ],
        ),
      ),
    );
  }
}

class _TopBody extends StatelessWidget {
  final TextEditingController _controller;
  _TopBody(this._controller);

  String? _emailErrorText;

  final _formKey = GlobalKey<FormState>();

  final FocusNode _focusNode = FocusNode();

  void _validateEmail(String value, BuildContext context) {
    final container = ProviderScope.containerOf(context);
    if (value.isEmpty) {
      container.read(passwordResetValidatorProvider.notifier).toggleOff();
      _emailErrorText = 'Email is required';
    } else if (!_isEmailValid(value)) {
      container.read(passwordResetValidatorProvider.notifier).toggleOff();
      _emailErrorText = 'Enter a valid email address';
    } else {
      container.read(passwordResetValidatorProvider.notifier).toggleOn();
      _emailErrorText = null;
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

  void _submitForm(BuildContext context) async {
    final container = ProviderScope.containerOf(context);
    if (_formKey.currentState!.validate()) {
      container.read(loadingProvider.notifier).toggleOn();
      _focusNode.unfocus();
      await AuthClient().forgotPassword(
        _controller.text.trim(),
      );

      if (context.mounted) {
        context.pushNamed(RouteName.confirmation,
            queryParameters: {'email': _controller.text.trim()});
        container.read(passwordResetValidatorProvider.notifier).toggleOff();
        container.read(loadingProvider.notifier).toggleOff();
        _controller.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
        ).w,
        child: Column(
          children: [
            ReadexProText(
              data: 'Password Reset',
              color: Palette.text,
              fontWeight: FontWeight.bold,
              fontSize: 30.sp,
            ),
            ReadexProText(
              data:
                  'Please enter your registered email address to reset your password',
              textAlign: TextAlign.center,
              color: Palette.text,
            ),
            Gap(30.h),
            AuthTextField(
              focusNode: _focusNode,
              controller: _controller,
              onChanged: (value) => _validateEmail(value, context),
              validator: (value) => _emailErrorText,
            ),
            Gap(100.h),
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
                  description: 'Continue',
                );
              },
            ),
            Gap(35.h),
            ReadexProText(
              data:
                  'By registering you accept our Terms & Conditions and Privacy Policy. Your data will be security encrypted with TLS',
              fontSize: 12.sp,
              color: Palette.secondary,
              textAlign: TextAlign.center,
            )
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
                  FederatedAuthProvider.facebook, context),
              radius: 10,
              size: const Size(48, 48),
              imagePath: ImageAsset.facebook,
            ),
            Gap(30.w),
            SocialSignInButton(
              onTap: () async => await AuthClient().loginWithFederatedProvider(
                  FederatedAuthProvider.google, context),
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
