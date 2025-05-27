import 'package:flutter/material.dart';
import 'package:saleko/utils/app_colors.dart';

class paymentTextFormField extends StatelessWidget {
  const paymentTextFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Enter your coupon code",
        hintStyle: TextStyle(
            fontSize: 11, color: AppColors.grey, fontWeight: FontWeight.w400),
        fillColor: Colors.transparent,
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.red,
            width: 1.5,
          ),
        ),
      ),
      style: TextStyle(
          fontSize: 13, color: Colors.black, fontWeight: FontWeight.w600),
    );
  }
}
