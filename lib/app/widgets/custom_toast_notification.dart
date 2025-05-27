import 'package:flutter/material.dart';
import 'package:saleko/services/navigation/navigator_service.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

enum ToastType { success, error, warning }

class CustomToastNotification {
  static show(String title,
      {ToastType type = ToastType.success,
      bool isFilled = true,
      bool? bottomPosition = false,
      Duration? duration}) async {
    return showTopSnackBar(
        Overlay.of(NavigatorService.navigationKey_.currentContext!),
        CustomSnackBar.info(
          backgroundColor: getToastColor(type),
          message: title,
        ));
  }

  static showBottomToast(BuildContext context, String title) async {
    showToast(
      title,
      context: context,
      position: StyledToastPosition.bottom,
      animation: StyledToastAnimation.fade,
      reverseAnimation: StyledToastAnimation.fade,
      animDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 4),
      backgroundColor: AppColors.transparentBlack,
      textStyle: const TextStyle(fontSize: 12.5, color: AppColors.white),
    );
  }

  static Color getToastColor(ToastType type) {
    switch (type) {
      case ToastType.success:
        return AppColors.darkGreen2;
      case ToastType.error:
        return AppColors.error;
      case ToastType.warning:
        return AppColors.warning;

      default:
        return AppColors.darkGreen2;
    }
  }

  // static String getToastIcon(ToastType type) {
  //   switch (type) {
  //     case ToastType.success:
  //       return SvgIcons.successToast;
  //     case ToastType.error:
  //       return SvgIcons.errorToast;
  //     case ToastType.warning:
  //       return SvgIcons.warningToast;

  //     default:
  //       return SvgIcons.successToast;
  //   }
  // }

  // static Color getToastColor(ToastType type) {
  //   switch (type) {
  //     case ToastType.success:
  //       return AppColors.successGreen;
  //     case ToastType.error:
  //       return AppColors.errorRed;
  //     case ToastType.warning:
  //       return AppColors.orangeWarning;

  //     default:
  //       return AppColors.successGreen;
  //   }
  // }
}
