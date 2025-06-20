import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/app/home/widgets/property_filter.dart';
import 'package:te_find/app/settings/setting_page.dart';
import 'package:te_find/app/widgets/custom_button.dart';
import 'package:te_find/app/widgets/pin_input_field.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/services/navigation/route_names.dart';
import 'package:te_find/utils/assets_manager.dart';

import '../../models/Products.dart';
import '../../providers/account_provider.dart';
import '../../providers/provider.dart';
import '../../utils/app_colors.dart';
import '../home/filter_page.dart';
import '../home/widgets/category_filter.dart';
import '../home/widgets/item_condition.dart';
import '../home/widgets/price_range.dart';
import 'custom_text_form_field.dart';

RangeValues _priceRange = const RangeValues(0, 50000);

final double _minPrice = 0;
final double _maxPrice = 100000;
class BottomModals {

  static validatePasswordPin({
    required BuildContext context,
    required AccountProvider accountProvider,
  }) {
    return showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        int countdownSeconds = 63; // 1:03 in seconds
        Timer? timer;
        return StatefulBuilder(
          builder: (context, setState) {
            void startTimer() {
              timer?.cancel(); // Cancel any existing timer
              timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
                if (countdownSeconds > 0) {
                  setState(() {
                    countdownSeconds--;
                  });
                } else {
                  t.cancel();
                }
              });
            }

            // Start the timer only once when the sheet is built
            if (timer == null || !timer!.isActive) {
              startTimer();
            }

            String formatTime(int seconds) {
              int m = seconds ~/ 60;
              int s = seconds % 60;
              String mm = m.toString();
              String ss = s.toString().padLeft(2, '0');
              return "$mm:$ss";
            }

            return Container(
              width: double.infinity,
              height: 500.h,
              padding: EdgeInsets.symmetric(horizontal: 0.w),
              margin: EdgeInsets.only(bottom: 4.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 50.0.h,
                  horizontal: 50.0.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 30.h),
                    Center(
                      child: Column(
                        children: [
                          PinInputField(
                            pinController: accountProvider.signUpPinController,
                            pinNumber: 6,
                            onCompleted: (pin) async {
                              bool success =
                              await accountProvider.verifyOtpCode(pin);
                              if (success) {
                                timer?.cancel();
                                Navigator.pop(context);
                                NavigatorService().navigateTo(completeSignUp);
                              }
                            },
                          ),
                          SizedBox(height: 30.h),
                          Text(
                            'We’ve sent a verification code to',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            '${accountProvider.signUpEmailController.text}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(height: 40.h),
                          Text(
                            formatTime(countdownSeconds),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(height: 40.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Didn’t receive OTP? ",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black,
                                ),
                              ),
                              GestureDetector(
                                onTap: countdownSeconds == 0
                                    ? () async {
                                  timer?.cancel();
                                  setState(() {
                                    countdownSeconds = 63;
                                  });
                                  startTimer();
                                  await accountProvider.resentOTP();
                                  accountProvider.signUpPinController.clear();

                                }
                                    : null,
                                child: Text(
                                  'Resend OTP',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: countdownSeconds == 0
                                        ? AppColors.primaryColor
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).whenComplete((){
      accountProvider.signUpPinController.clear();
    });
  }

  static validateForgotPasswordPin({
    required BuildContext context,
    required AccountProvider accountProvider,
  }) {
    return showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        int countdownSeconds = 63; // 1:03 in seconds
        Timer? timer;
        return StatefulBuilder(
          builder: (context, setState) {
            void startTimer() {
              timer?.cancel(); // Cancel any existing timer
              timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
                if (countdownSeconds > 0) {
                  setState(() {
                    countdownSeconds--;
                  });
                } else {
                  t.cancel();
                }
              });
            }

            // Start the timer only once when the sheet is built
            if (timer == null || !timer!.isActive) {
              startTimer();
            }

            String formatTime(int seconds) {
              int m = seconds ~/ 60;
              int s = seconds % 60;
              String mm = m.toString();
              String ss = s.toString().padLeft(2, '0');
              return "$mm:$ss";
            }

            return Container(
              width: double.infinity,
              height: 510.h,
              padding: EdgeInsets.symmetric(horizontal: 0.w),
              margin: EdgeInsets.only(bottom: 4.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 50.0.h,
                  horizontal: 50.0.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 30.h),
                    Center(
                      child: Column(
                        children: [
                          PinInputField(
                            pinController: accountProvider.forgotPasswordPinController,
                            pinNumber: 6,
                            onCompleted: (pin) async {
                              bool success =
                              await accountProvider.verifyForgotPassOtpCode(pin);
                              if (success) {
                                timer?.cancel();
                                Navigator.pop(context);
                                NavigatorService().navigateTo(setNewPasswordRoute);
                              }
                            },
                          ),
                          SizedBox(height: 30.h),
                          Text(
                            'We’ve sent a verification code to',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            '${accountProvider.forgotPasswordEmailController.text}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(height: 50.h),
                          Text(
                            formatTime(countdownSeconds),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(height: 50.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Didn’t receive OTP? ",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black,
                                ),
                              ),
                              GestureDetector(
                                onTap: countdownSeconds == 0
                                    ? () async {
                                  timer?.cancel();
                                  setState(() {
                                    countdownSeconds = 63;
                                  });
                                  startTimer();
                                  await accountProvider.resentForgotPassOTP();
                                  accountProvider.forgotPasswordPinController.clear();
                                }
                                    : null,
                                child: Text(
                                  'Resend OTP',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: countdownSeconds == 0
                                        ? AppColors.primaryColor
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).whenComplete((){
    });
  }


  //---price---//
  static condition({required BuildContext context}) {
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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10.0.h,
              horizontal: 10.0.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [Condition()],
            ),
          ),
        ),
      ),
    );
  }

  //---- conditional modal ----//
  static priceModal({required BuildContext context}) {
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
          padding: EdgeInsets.symmetric(
            vertical: 10.0.h,
            horizontal: 20.0.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [PriceModalContent()],
          ),
        ),
      ),
    );
  }

  //---- categories modal ----//
  static categoryModal({required BuildContext context}) {
    return showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        width: double.infinity,
        height: 700.h,
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        margin: EdgeInsets.only(bottom: 4.h, left: 0.w, right: 0.w),
        decoration: BoxDecoration(
          color: Colors.white, //ColorThemes.normalBorderColor50,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10.0.h,
              horizontal: 20.0.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [CategoryFilter()],
            ),
          ),
        ),
      ),
    );
  }

  //---- save search ----//
  static saveSearch({required BuildContext context}) {
    return showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        bool isChecked = false;
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              width: double.infinity,
              height: 310.h,
              padding: EdgeInsets.symmetric(horizontal: 0.w),
              margin: EdgeInsets.only(bottom: 4.h, left: 0.w, right: 0.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0.h,
                    horizontal: 15.0.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Save Search',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black)),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close),
                          )
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Text('Search Name',
                          style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.lightTextBlack)),
                      SizedBox(height: 10.h),
                      TextFormField(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: AppColors.greyLight),
                            hintText: 'Summer Dress',
                            fillColor: Colors.transparent,
                            filled: true,
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(
                                  width: 1, color: AppColors.primaryColor),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(
                                  width: 1, color: AppColors.greyLight),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(
                                color: AppColors.greyLight,
                                width: 1.w,
                              ),
                            ),
                            errorStyle: const TextStyle(color: AppColors.red),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(),
                            ),
                          ),
                          onChanged: (v) {},
                          keyboardType: TextInputType.text,
                          style: const TextStyle(color: Colors.black),
                          cursorColor: AppColors.greyLight),
                      SizedBox(height: 5.h),
                      Row(
                        children: [
                          Checkbox(
                            activeColor: AppColors.primaryColor,
                            value: isChecked,
                            onChanged: (val) {
                              setState(() {
                                isChecked = val ?? false;
                              });
                            },
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: Text(
                              'Notify me when new items match',
                              style: GoogleFonts.roboto(
                                  fontSize: 14.sp, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Text(
                          "You'll receive notifications when new items matching your search criteria are listed.",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.lightTextBlack)),
                      SizedBox(height: 10.h),
                      CustomButton(
                        onPressed: () {
                          // Handle save search logic
                          print('Search saved: Notify = $isChecked');
                          Navigator.pop(context);
                        },
                        label: 'Save Search',
                        fillColor: AppColors.primaryColor,
                        buttonTextColor: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  //---- manage search ----//
  static manageSearch({required BuildContext context}) {
    return showModalBottomSheet(
      context: context,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        bool isChecked = false;
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              width: double.infinity,
              height: 350.h,
              padding: EdgeInsets.symmetric(horizontal: 0.w),
              margin: EdgeInsets.only(bottom: 4.h, left: 0.w, right: 0.w),
              decoration: BoxDecoration(
                color: Color.fromRGBO(250, 250, 250, 1), //Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0.h,
                    horizontal: 15.0.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Manage Saved Search',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black)),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close),
                          )
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset('assets/images/badge.svg'),
                                SizedBox(width: 8),
                                Text(
                                  'Designer bags under ₦50,000',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  // onTap: ()=>showMakeOfferDialog(context),
                                  child: Container(
                                      height: 32.h,
                                      width: 32.w,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.greyLight),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          Assets.deleteIcon,
                                          color: AppColors.grey,
                                          height: 15.h,
                                          width: 15.w,
                                        ),
                                      )),
                                ),
                                Transform.scale(
                                  scale: 0.8,
                                  child: Switch.adaptive(
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    value: true,
                                    activeTrackColor: AppColors.primaryColor,
                                    activeColor: Colors.white,
                                    inactiveTrackColor: Colors.grey[300],
                                    inactiveThumbColor: Colors.white,
                                    onChanged: (value) {},
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.greyLight,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                'Designer',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  static listingMoreOption({required BuildContext context, required Products product, required WidgetRef ref}) {
    return showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        bool isChecked = false;
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              width: double.infinity,
              height: 320.h,
              padding: EdgeInsets.symmetric(horizontal: 0.w),
              margin: EdgeInsets.only(bottom: 4.h, left: 0.w, right: 0.w),
              decoration: BoxDecoration(
                color: Color.fromRGBO(250, 250, 250, 1), //Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.0.h,
                    horizontal: 15.0.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Container(
                          height: 4,
                          width: 48,
                          decoration: BoxDecoration(
                              color: AppColors.greyLight,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          //ref.read(RiverpodProvider.productProvider).prepareProductForEdit(product);
                          NavigatorService().navigateTo(
                            sellItemScreens,
                            arguments: product,
                          );
                        },
                        child: Row(
                          spacing: 10.w,
                          children: [
                            Icon(Icons.edit),
                            Text('Edit Listing',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.black)),
                          ],
                        ),
                      ),
                      SizedBox(height: 22.h),
                      Row(
                        spacing: 10.w,
                        children: [
                          Icon(Icons.visibility_off),
                          Text('Hide Listing',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black)),
                        ],
                      ),
                      SizedBox(height: 22.h),
                      Row(
                        spacing: 10.w,
                        children: [
                          Icon(Icons.share),
                          Text('Share Listing',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black)),
                        ],
                      ),
                      SizedBox(height: 22.h),
                      Row(
                        spacing: 10.w,
                        children: [
                          SvgPicture.asset(
                            Assets.deleteIcon,
                            color: AppColors.red,
                          ),
                          Text('Delete Listing',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.red)),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      CustomButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        fillColor: AppColors.greyLight,
                        label: 'Cancel',
                        buttonTextColor: Colors.black,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  static sortingModal({required BuildContext context}) {
    return showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        String selectedOption = 'Newest';
        return StatefulBuilder(
          builder: (context, setState) {
            Widget buildOption(String title) {
              final bool isSelected = selectedOption == title;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedOption = title;
                  });
                },
                child: Container(
                  height: 40.h,
                  color: Colors.transparent,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          ),
                        ),
                        if (isSelected)
                          Icon(
                            Icons.check,
                            color: AppColors.primaryColor,
                            size: 18,
                          )
                      ],
                    ),
                  ),
                ),
              );
            }

            return Container(
              width: double.infinity,
              height: 320.h,
              margin: EdgeInsets.only(bottom: 4.h),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(250, 250, 250, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.0.h,
                    horizontal: 15.0.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Container(
                          height: 4,
                          width: 48,
                          decoration: BoxDecoration(
                            color: AppColors.greyLight,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Sort By',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      buildOption('Newest'),
                      buildOption('Price: Low to High'),
                      buildOption('Price: High to Low'),
                      buildOption('Most Newest'),
                      SizedBox(height: 15.h),
                      CustomButton(
                        onPressed: () {
                          Navigator.pop(context, selectedOption); // return the selected option
                        },
                        fillColor: AppColors.greyLight,
                        label: 'Cancel',
                        buttonTextColor: Colors.black,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
  static homePageFilter({required BuildContext context}) {
    return showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        width: double.infinity,
        height: 700.h,
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        margin: EdgeInsets.only(bottom: 4.h, left: 0.w, right: 0.w),
        decoration: BoxDecoration(
          color: Colors.white, //ColorThemes.normalBorderColor50,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10.0.h,
              horizontal: 20.0.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [FilterPage()],
            ),
          ),
        ),
      ),
    );
  }
  static propertyFilter({required BuildContext context}) {
    return showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        width: double.infinity,
        height: 450.h,
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        margin: EdgeInsets.only(bottom: 4.h, left: 0.w, right: 0.w),
        decoration: BoxDecoration(
          color: Colors.white, //ColorThemes.normalBorderColor50,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10.0.h,
              horizontal: 20.0.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [PropertyFilter()],
            ),
          ),
        ),
      ),
    );
  }


}


