import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/utils/app_colors.dart';

class CustomBottomSheet {
  static show(
      {BuildContext? context,
      required Widget child,
      TextStyle? titleStyle,
      bool? isDismissible,
        bool? isScrollControlled,
      }) {
    return showModalBottomSheet<void>(
      isDismissible: isDismissible ?? true,
      context: NavigatorService.navigationKey_.currentContext!,
      isScrollControlled: isScrollControlled ?? true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
            top:5.h,
           // bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for the keyboard
          ),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.90,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0.r),
              topRight: Radius.circular(8.0.r),
            ),
          ),
          child: Column(
           // mainAxisSize: MainAxisSize.min,
            children: [
              // Center(
              //   child: Container(
              //     height: 5.h,
              //     width: 32.w,
              //     decoration: BoxDecoration(
              //       color: AppColors.primaryColor,
              //       borderRadius: BorderRadius.circular(20.r),
              //     ),
              //   ),
              // ),
              child,
            ],
          ),
        );
      },
    );
  }
}
