import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:te_find/utils/app_colors.dart';

// TODO: Add font family.
class AppStyles {
  static TextStyle largeTitleTextStyle = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.blackTextColor,
  );

  static TextStyle createTitleTextStyle({
    Color textColor = AppColors.blackTextColor,
  }) {
    return TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: textColor,
    );
  }

  static TextStyle createLargeTextStyle(
      {Color textColor = AppColors.blackTextColor,
      FontWeight fontWeight = FontWeight.w500}) {
    return TextStyle(
      fontSize: 16.sp,
      fontWeight: fontWeight,
      color: textColor,
    );
  }

  static TextStyle createNormalTextStyle(
      {Color textColor = AppColors.blackTextColor,
      FontWeight fontWeight = FontWeight.w400}) {
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: fontWeight,
      color: textColor,
    );
  }

  static TextStyle createSmallTextStyle(
      {Color textColor = AppColors.blackTextColor,
      FontWeight fontWeight = FontWeight.w300}) {
    return TextStyle(
      fontSize: 12.sp,
      fontWeight: fontWeight,
      color: textColor,
    );
  }

  static TextStyle createTinyTextStyle({
    Color textColor = AppColors.blackTextColor,
  }) {
    return TextStyle(
      fontSize: 11.sp,
      fontWeight: FontWeight.w400,
      color: textColor,
    );
  }

  static TextStyle tinyTextStyle = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.blackTextColor,
  );
}
