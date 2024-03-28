import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_kash/presentation/utils/utils.dart';
import 'package:free_kash/presentation/widgets/widgets.dart';

typedef Validaor = String? Function(String? value)?;

class AuthTextField extends StatelessWidget {
  final TextEditingController? _controller;

  final Widget? prefixIcon;

  final String? Function(String? value)? _validator;

  final String labelDescription;

  final void Function(String value)? _onChanged;
  const AuthTextField(
      {super.key,
      this.prefixIcon,
      this.labelDescription = 'Email address',
      Validaor validator,
      TextEditingController? controller,
      void Function(String value)? onChanged})
      : _controller = controller,
        _validator = validator,
        _onChanged = onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      child: TextFormField(
        controller: _controller,
        onChanged: (_onChanged == null) ? null : (value) => _onChanged(value),
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10).r,
              borderSide: BorderSide(
                color: Palette.primary,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10).r,
              borderSide: BorderSide(
                color: Palette.primary,
                width: 1,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10).r,
              borderSide: BorderSide(
                color: Palette.primary,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10).r,
              borderSide: BorderSide(
                color: Palette.primary,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10).r,
              borderSide: BorderSide(
                color: Palette.primary,
                width: 1,
              ),
            ),
            prefixIcon: prefixIcon ??
                Icon(
                  Icons.mail_outline_outlined,
                  color: Palette.primary,
                  size: 18.h,
                ),
            label: ReadexProText(
              data: labelDescription,
              color: Palette.secondary,
              fontSize: 12.sp,
            ),
            fillColor: Palette.surface,
            filled: true),
        validator: (_validator == null) ? null : (value) => _validator(value),
      ),
    );
  }
}
