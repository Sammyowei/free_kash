// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_kash/data/auth/auth.dart';
import 'package:free_kash/data/data.dart';
import 'package:free_kash/data/db/user_db_config.dart';
import 'package:free_kash/presentation/presentations.dart';
import 'package:free_kash/presentation/routes/go_router/route_name.dart';
import 'package:free_kash/provider/provider.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../provider/providers/user_provider.dart';

class BankOnboardingDetail extends StatefulWidget {
  const BankOnboardingDetail({super.key});

  @override
  State<BankOnboardingDetail> createState() => _BankOnboardingDetailState();
}

class _BankOnboardingDetailState extends State<BankOnboardingDetail> {
  late TextEditingController _bankNameController;
  late TextEditingController _accountNumberController;
  late TextEditingController _accountNameController;

  @override
  void initState() {
    _bankNameController = TextEditingController();

    _accountNumberController = TextEditingController();
    _accountNameController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final ref = ProviderScope.containerOf(context);

      final user = ref.read(userProvider);
      _accountNameController.text =
          '${user.firstName}${user.middleName != null ? ' ${user.middleName} ' : ' '}${user.lastName}';
    });

    super.initState();
  }

  @override
  void dispose() {
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _accountNameController.dispose();

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
              bankNameController: _bankNameController,
              accountNameController: _accountNameController,
              accountNumberController: _accountNumberController,
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBody extends StatelessWidget {
  final TextEditingController bankNameController;
  final TextEditingController accountNumberController;
  final TextEditingController accountNameController;

  _TopBody({
    super.key,
    required this.bankNameController,
    required this.accountNumberController,
    required this.accountNameController,
  });

  String? _bankNameTextError;

  String? _accountNameTextError;

  String? _accountNumberTextError;

  void _validateBankName(String value, BuildContext context) {
    final ref = ProviderScope.containerOf(context);

    if (value.isEmpty) {
      _bankNameTextError = 'Bank name is required';
      ref.read(bankValidatorStateNotifierProvider.notifier).toggleOff();
    } else if (accountNumberController.text.isEmpty ||
        accountNameController.text.isEmpty) {
      ref.read(bankValidatorStateNotifierProvider.notifier).toggleOff();
    } else {
      _bankNameTextError = null;
      ref.read(bankValidatorStateNotifierProvider.notifier).toggleOn();
    }
  }

  void _validateAccountName(String value, BuildContext context) {
    final ref = ProviderScope.containerOf(context);
    if (value.isEmpty) {
      _accountNameTextError = 'Require this field';

      ref.read(bankValidatorStateNotifierProvider.notifier).toggleOff();
    } else if (accountNumberController.text.isEmpty ||
        bankNameController.text.isEmpty) {
      ref.read(bankValidatorStateNotifierProvider.notifier).toggleOff();
    } else {
      _accountNameTextError = null;
      ref.read(bankValidatorStateNotifierProvider.notifier).toggleOn();
    }
  }

  void _validateAccountNumber(String value, BuildContext context) {
    final ref = ProviderScope.containerOf(context);
    if (value.isEmpty) {
      _accountNumberTextError = 'Account number is required';
      ref.read(bankValidatorStateNotifierProvider.notifier).toggleOff();
    } else if (!_validateNumber(value)) {
      _accountNameTextError = 'Invalid format';

      ref.read(bankValidatorStateNotifierProvider.notifier).toggleOff();
    } else if (value.length < 8) {
      _accountNumberTextError = 'Incomplete account number';

      ref.read(bankValidatorStateNotifierProvider.notifier).toggleOff();
    } else if (accountNameController.text.isEmpty ||
        bankNameController.text.isEmpty) {
      ref.read(bankValidatorStateNotifierProvider.notifier).toggleOff();
    } else {
      _accountNumberTextError = null;

      ref.read(bankValidatorStateNotifierProvider.notifier).toggleOn();
    }
  }

  bool _validateNumber(String value) {
    final numbersOnly = RegExp(r'^[0-9]+$');

    return numbersOnly.hasMatch(value);
  }

  void _submit(BuildContext context) async {
    final ref = ProviderScope.containerOf(context);
    ref.read(loadingProvider.notifier).toggleOn();
    final userID = AuthClient().userID;
    final user = ref.read(userProvider);

    final credential = Credentials(
        accountName: accountNameController.text.trim(),
        accountNumber: accountNumberController.text.trim(),
        bankName: bankNameController.text.trim());

    user
      ..addCredentials(credential)
      ..referralCode = userID;

    print(ref.read(userProvider).toJson());

    // ref.read(onboardingIndexProvider.notifier).back();

    final db = UserDbConfig();

    final res = await db.addUser(user, userID!);

    res;

    final id = AuthClient().userID;

    if (context.mounted) {
      ref.read(loadingProvider.notifier).toggleOff();
      context.goNamed(
        RouteName.dashboard,
        pathParameters: {
          'id': id!,
        },
      );
    }
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
              data: 'Bank Details',
              color: Palette.text,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
            Gap(5.h),
            ReadexProText(
              data:
                  'Please update your bank details to recieve your rewards 🎉',
              color: Palette.text,
              fontSize: 13.sp,
            ),
            Gap(20.h),
            AuthTextField(
              controller: bankNameController,
              onChanged: (value) => _validateBankName(value, context),
              validator: (value) => _bankNameTextError,
              labelDescription: 'Bank name',
              prefixIcon: Icon(
                Icons.account_balance_outlined,
                color: Palette.primary,
                size: 18.h,
              ),
            ),
            Gap(10.h),
            AuthTextField(
              isEnabled: false,
              controller: accountNameController,
              onChanged: (value) => _validateAccountName(value, context),
              validator: (value) => _accountNameTextError,
              labelDescription: 'Account name',
              prefixIcon: Icon(
                Icons.account_circle_outlined,
                color: Palette.primary,
                size: 18.h,
              ),
            ),
            Gap(10.h),
            AuthTextField(
              controller: accountNumberController,
              validator: (value) => _accountNumberTextError,
              onChanged: (value) => _validateAccountNumber(value, context),
              labelDescription: 'Account number',
              prefixIcon: Icon(
                Icons.numbers_rounded,
                color: Palette.primary,
                size: 18.h,
              ),
            ),
            Gap(60.h),
            Consumer(
              builder: (context, ref, child) {
                // final index = ref.watch(onboardingIndexProvider);

                final loadingIndicator = ref.watch(loadingProvider);

                final notifier = ref.watch(bankValidatorStateNotifierProvider);

                final value = (notifier == true);
                return CustomButton(
                  onTap: () => _submit(context),
                  size: Size(MediaQuery.sizeOf(context).width, 45),
                  color: value ? Palette.primary : Palette.outline,
                  outlineColor: value ? Palette.primary : Palette.outline,
                  textColor: value ? Palette.surface : Palette.secondary,
                  description: 'Completed',
                  widget: loadingIndicator
                      ? CircularProgressIndicator(
                          color: Palette.surface,
                          strokeCap: StrokeCap.round,
                          strokeWidth: 2)
                      : null,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
