import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:saleko/utils/app_styles.dart';

class CustomTextFormField extends StatelessWidget {
  final Function(String)? onChanged;
  final String? hint;
  final String? label;
  final int? maxLength;
  final int? maxLines;
  final dynamic validator;
  final bool? obscure;
  final bool? enable;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final Color? color;

  const CustomTextFormField({
    super.key,
    this.onChanged,
    this.hint,
    this.label,
    this.maxLength,
    this.maxLines,
    this.validator,
    this.obscure = false,
    this.enable = true,
    this.inputType,
    this.controller,
    this.suffixIcon,
    this.inputFormatters,
    this.color = AppColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      obscureText: obscure!,
      validator: validator != null ? validator : null,
      maxLength: maxLength != null ? maxLength : null,
      maxLines: maxLines != null ? maxLines : null,
      controller: controller,
      enabled: enable!,
      onChanged: (v) {
        if (onChanged != null) {
          onChanged!(v);
        }
      },
      keyboardType: inputType == null ? TextInputType.text : inputType,
      decoration: InputDecoration(
        fillColor: color,
        filled: true,
        labelText: label,
        hintText: hint,
        suffixIcon: suffixIcon ?? null,
        hintStyle: TextStyle(
          fontSize: 16,
          color: Color(0xff8391A1),
        ),
        labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xff8391A1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(3.5)),
          borderSide: BorderSide(width: 1.2, color: AppColors.primaryColor),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(3.5)),
          borderSide: BorderSide(width: 1.2, color: AppColors.greyFaint),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(3.5)),
          borderSide: BorderSide(
            color: AppColors.grey,
            width: 1.6.h,
          ),
        ),
        errorStyle: const TextStyle(color: AppColors.red),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3.5),
          borderSide: const BorderSide(),
        ),
      ),
    );
  }
}
