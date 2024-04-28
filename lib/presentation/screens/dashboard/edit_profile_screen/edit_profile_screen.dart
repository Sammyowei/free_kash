// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_kash/data/auth/auth.dart';
import 'package:free_kash/data/db/_db_config.dart';
import 'package:free_kash/data/models/user/user.dart';
import 'package:free_kash/presentation/presentations.dart';

import 'package:free_kash/provider/provider.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, required this.user});

  final User user;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController _firstNameController;

  late TextEditingController _lastNameController;

  late TextEditingController _middletNameController;

  late TextEditingController _emailController;

  late TextEditingController _mobileNumberController;

  @override
  void initState() {
    final user = widget.user;

    _firstNameController = TextEditingController.fromValue(
      TextEditingValue(text: user.firstName ?? ''),
    );

    _middletNameController = TextEditingController.fromValue(
      TextEditingValue(text: user.middleName ?? ''),
    );

    _lastNameController = TextEditingController.fromValue(
      TextEditingValue(text: user.lastName ?? ''),
    );

    _emailController = TextEditingController.fromValue(
      TextEditingValue(text: user.emailAddress ?? ''),
    );

    _mobileNumberController = TextEditingController.fromValue(
      TextEditingValue(text: user.mobileNumber ?? ''),
    );
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _middletNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  void _validate(BuildContext context) {
    final user = widget.user;

    final ref = ProviderScope.containerOf(context);
    if (user.firstName != _firstNameController.text.trim() ||
        user.middleName != _middletNameController.text.trim() ||
        user.lastName != _lastNameController.text.trim() ||
        user.emailAddress != _emailController.text.trim() ||
        user.mobileNumber != _mobileNumberController.text.trim()) {
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
          data: "Edit Profile",
          color: Palette.text,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15).w,
          child: Column(children: [
            AuthTextField(
              controller: _firstNameController,
              labelDescription: 'First name',
              onChanged: (value) => _validate(context),
            ),
            Gap(10.h),
            AuthTextField(
              controller: _middletNameController,
              labelDescription: 'Middle name',
              onChanged: (value) => _validate(context),
            ),
            Gap(10.h),
            AuthTextField(
              controller: _lastNameController,
              labelDescription: 'Last name',
              onChanged: (value) => _validate(context),
            ),
            Gap(10.h),
            AuthTextField(
              controller: _emailController,
              onChanged: (value) => _validate(context),
            ),
            Gap(10.h),
            AuthTextField(
              controller: _mobileNumberController,
              labelDescription: 'Mobile number',
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
                          ref.read(loadingProvider.notifier).toggleOn();
                          final _authClient = AuthClient();
                          if (widget.user.emailAddress !=
                              _emailController.text.trim()) {
                            try {
                              await _authClient.instance.currentUser!
                                  .verifyBeforeUpdateEmail(
                                _emailController.text.trim(),
                              );
                            } on FirebaseAuthException catch (e) {
                              debugPrint("AN ERROR OCCURED HERE ${e.message}");
                              ref.read(loadingProvider.notifier).toggleOff();
                              ref
                                  .read(editProfileStateProvider.notifier)
                                  .toggleOn();

                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Palette.red,
                                    content: ReadexProText(
                                      data: '${e.message}',
                                    ),
                                  ),
                                );
                              }

                              return;
                            }
                          }

                          final user = widget.user;

                          user
                            ..emailAddress = _emailController.text.trim()
                            ..firstName = _firstNameController.text.trim()
                            ..middleName = _middletNameController.text.trim()
                            ..lastName = _lastNameController.text.trim()
                            ..mobileNumber =
                                _mobileNumberController.text.trim();

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
                  description: 'Update Profile',
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
