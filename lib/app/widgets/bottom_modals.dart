import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:te_find/app/widgets/pin_input_field.dart';

import '../../utils/app_colors.dart';

class BottomModals {
  static validatePasswordPin({required BuildContext context}) {
    return showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        width: double.infinity,
        height: 510.h,
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        margin: EdgeInsets.only(bottom: 4.h, left: 0.w, right: 0.w),
        decoration: BoxDecoration(
          color: Colors.white, //ColorThemes.normalBorderColor50,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(
            vertical: 50.0.h,
            horizontal: 50.0.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 30.h,
              ),
              Center(
                  child: Column(
                children: [
                  PinInputField(
                    pinNumber: 4,
                    //  pinController: accountProvider.forgotOtpPinController,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text('We’ve sent a verification code to',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black)),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text('email@gmail.com',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black)),
                  SizedBox(
                    height: 50.h,
                  ),
                  Text('1:03',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black)),
                  SizedBox(
                    height: 50.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 5.w,
                    children: [
                      Text("Didn\'t receive OTP?",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black)),
                      Text('Click here',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black)),
                    ],
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
