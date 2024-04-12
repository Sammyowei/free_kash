import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_kash/data/auth/auth_client.dart';
import 'package:free_kash/presentation/presentations.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/db/_db_config.dart';
import '../../../../data/models/user/user.dart';
import '../../../../provider/provider.dart';

class EditBankDetails extends StatefulWidget {
  const EditBankDetails({super.key, required this.user});

  final User user;

  @override
  State<EditBankDetails> createState() => _EditBankDetailsState();
}

class _EditBankDetailsState extends State<EditBankDetails> {
  late TextEditingController _accountNameController;

  late TextEditingController _bankNameController;

  late TextEditingController _accountNumberController;

  @override
  void initState() {
    final user = widget.user;

    print(user.credentials?.toJson());
    _accountNameController = TextEditingController.fromValue(
      TextEditingValue(text: user.credentials?.accountName ?? ''),
    );

    _accountNumberController = TextEditingController.fromValue(
      TextEditingValue(text: user.credentials?.accountNumber ?? ''),
    );

    _bankNameController = TextEditingController.fromValue(
      TextEditingValue(text: user.credentials?.bankName ?? ''),
    );

    super.initState();
  }

  @override
  void dispose() {
    _accountNameController.dispose();
    _accountNumberController.dispose();
    _bankNameController.dispose();

    super.dispose();
  }

  void _validate(BuildContext context) {
    final user = widget.user;

    final ref = ProviderScope.containerOf(context);
    if (user.credentials?.accountName != _accountNameController.text.trim() ||
        user.credentials?.accountNumber !=
            _accountNumberController.text.trim() ||
        user.credentials?.bankName != _bankNameController.text.trim()) {
      ref.read(editProfileStateProvider.notifier).toggleOn();
    } else {
      ref.read(editProfileStateProvider.notifier).toggleOff();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        backgroundColor: Palette.background,
        title: ReadexProText(
          data: 'Edit Bank Details',
          color: Palette.text,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15).w,
          child: Column(children: [
            AuthTextField(
              controller: _accountNameController,
              labelDescription: 'Account Name',
              isEnabled: false,
              onChanged: (value) => _validate(context),
            ),
            Gap(10.h),
            AuthTextField(
              controller: _accountNumberController,
              labelDescription: 'Account Number',
              onChanged: (value) => _validate(context),
            ),
            Gap(10.h),
            AuthTextField(
              controller: _bankNameController,
              labelDescription: 'Bank Name',
              onChanged: (value) => _validate(context),
            ),
            Gap(50.h),
            Consumer(
              builder: (context, ref, child) {
                final editProfileNotifier = ref.watch(editProfileStateProvider);

                final isLoading = ref.watch(loadingProvider);

                return CustomButton(
                  onTap: editProfileNotifier == false
                      ? null
                      : () async {
                          // TODO: Check if the email Changed then update it in the Auth Server.
                          final AuthClient _authClient = AuthClient();
                          ref.read(loadingProvider.notifier).toggleOn();

                          final user = widget.user;

                          final crendential = user.credentials;

                          crendential
                            ?..accountName = _accountNameController.text.trim()
                            ..accountNumber =
                                _accountNumberController.text.trim()
                            ..bankName = _bankNameController.text.trim();

                          print(user.toJson());
                          final _dbConfig = DbConfig(dbStore: 'users');

                          await _dbConfig.update(
                              user.toJson(), _authClient.userID);

                          ref.read(loadingProvider.notifier).toggleOff();

                          ref
                              .read(editProfileStateProvider.notifier)
                              .toggleOff();
                        },
                  size: Size(MediaQuery.sizeOf(context).width, 40),
                  color:
                      editProfileNotifier ? Palette.primary : Palette.outline,
                  textColor:
                      editProfileNotifier ? Palette.surface : Palette.secondary,
                  outlineColor:
                      editProfileNotifier ? Palette.primary : Palette.outline,
                  description: 'Update',
                  widget: isLoading
                      ? CircularProgressIndicator(
                          color: Palette.surface,
                          strokeWidth: 2,
                          strokeCap: StrokeCap.round,
                        )
                      : null,
                );
              },
            ),
          ]),
        ),
      ),
    );
  }
}
