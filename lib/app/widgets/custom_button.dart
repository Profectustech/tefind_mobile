import 'package:flutter/material.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final void Function()? disabledOnPressed;
  final String label;
  final bool enabled;
  final bool loading;
  final bool secondary;
  final Color? fillColor;
  final Color? buttonTextColor;
  final Color borderColor;

  const CustomButton({
    super.key,
    this.onPressed,
    this.disabledOnPressed,
    this.label = 'Button',
    this.enabled = true,
    this.loading = false,
    this.secondary = false,
    this.fillColor,
    this.buttonTextColor = const Color(0xffFFFFFF),
    this.borderColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onPressed : disabledOnPressed ?? () {},
      child: Container(
        width: 327.w,
        height: 45.h,
        decoration: BoxDecoration(
            color: fillColor ??
                (secondary
                    ? null
                    : enabled
                        ? AppColors.primaryColor
                        : AppColors.buttonDisabled.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: borderColor)),
        child: Center(
          child: loading
              ? SizedBox(
                  height: 16.h,
                  width: 16.w,
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      color: AppColors.whiteTextColor,
                    ),
                  ),
                )
              : Text(
                  label,
                  style: TextStyle(
                    color: buttonTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
      ),
    );
  }
}
