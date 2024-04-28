// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_kash/data/auth/auth.dart';
import 'package:free_kash/data/data.dart';
import 'package:free_kash/data/db/_db_config.dart';
import 'package:free_kash/data/models/user/user.dart';
import 'package:free_kash/presentation/presentations.dart';
import 'package:free_kash/provider/provider.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

class WithdrawalScreen extends StatefulWidget {
  const WithdrawalScreen({super.key, required this.user});

  final User user;
  @override
  State<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  late TextEditingController _amountController;

  @override
  void initState() {
    _amountController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  final _key = GlobalKey<FormState>();

  String? errorText;

  void _validate(String value, BuildContext context) {
    final ref = ProviderScope.containerOf(context);
    if (value.isEmpty) {
      errorText = 'Withdrawal amount is required';
      ref.read(withdrawalFormVAlidatorProvider.notifier).toggleOff();
    } else if (!isValid(value)) {
      errorText = 'Invalid format';
      ref.read(withdrawalFormVAlidatorProvider.notifier).toggleOff();
    } else if (!_isMinimum(value)) {
      errorText = "Minimum withdrawal amount is ₣10,000 point";
      ref.read(withdrawalFormVAlidatorProvider.notifier).toggleOff();
    } else {
      errorText = null;
      ref.read(withdrawalFormVAlidatorProvider.notifier).toggleOn();
    }
  }

  bool _isMinimum(String value) {
    const minimumAmount = 10000.0;

    final valueAmount = double.parse(value);

    if (valueAmount < minimumAmount) {
      return false;
    } else {
      return true;
    }
  }

  bool isValid(String value) {
    final numbersOnly = RegExp(r'^[0-9]+$');
    return numbersOnly.hasMatch(value);
  }

  void _submit(BuildContext context) async {
    if (_key.currentState!.validate()) {
      final ref = ProviderScope.containerOf(context);
      final credential = widget.user.credentials;

      ref.read(loadingProvider.notifier).toggleOn();
      final _id = AuthClient().userID;

      final user = widget.user;

      final withdrawal = Withdrawal(
        accountId: _id!,
        amount: double.parse(_amountController.text.trim()),
        createdAt: DateTime.now(),
        status: 'Pending',
        description: "FreeKash Earning Withdrawal",
        credentials: credential!,
        uuid: const Uuid().v1(),
      );

      if (user.wallet!.walletBalance < withdrawal.amount) {
        ref.read(loadingProvider.notifier).toggleOff();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: ReadexProText(
                data: 'Insufficient balance.',
                color: Palette.surface,
              ),
              backgroundColor: Palette.red,
            ),
          );
        }

        return;
      }

      user.withdraw(withdrawal.amount);
      user.addToWithdrawalHistory(withdrawal);

      final db = DbConfig(dbStore: 'users');

      await db.update(user.toJson(), _id);

      final withdrawalDb = DbConfig(dbStore: 'withdrawals');

      final uid = const Uuid().v1();
      await withdrawalDb.create(withdrawal.toJson(), '$_id-$uid');

      ref.read(loadingProvider.notifier).toggleOff();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: ReadexProText(
              data:
                  'You have Successfully withdrawed ₣${withdrawal.amount}, and your withdrawal is processing',
              color: Palette.surface,
            ),
            backgroundColor: Palette.green,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        backgroundColor: Palette.background,
        title: ReadexProText(
          data: 'Withdraw',
          color: Palette.text,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15).w,
          child: Column(
            children: [
              ReadexProText(
                data:
                    'Note: All Withdrawals will be processed by the end of every month and the minimum withdrawal is ₣10,000 FreeKash Points.',
                color: Palette.secondary,
                fontSize: 16.sp,
                textAlign: TextAlign.center,
              ),
              Gap(30.h),
              Form(
                key: _key,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: AuthTextField(
                  controller: _amountController,
                  prefixIcon: Icon(
                    Icons.numbers_rounded,
                    color: Palette.primary,
                    size: 18.h,
                  ),
                  labelDescription: 'Amount',
                  validator: (value) => errorText,
                  onChanged: (value) => _validate(value, context),
                ),
              ),
              Gap(30.h),
              Consumer(
                builder: (context, ref, child) {
                  final isL = ref.watch(withdrawalFormVAlidatorProvider);

                  final isLoading = ref.watch(loadingProvider);
                  return CustomButton(
                    size: Size(MediaQuery.sizeOf(context).width, 45),
                    color: isL ? Palette.primary : Palette.outline,
                    outlineColor: isL ? Palette.primary : Palette.outline,
                    textColor: isL ? Palette.surface : Palette.secondary,
                    description: 'Withdraw',
                    widget: isLoading
                        ? CircularProgressIndicator(
                            color: Palette.surface,
                            strokeWidth: 2,
                            strokeCap: StrokeCap.round,
                          )
                        : null,
                    onTap: isL ? () => _submit(context) : null,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
