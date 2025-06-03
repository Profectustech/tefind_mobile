import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/app/widgets/custom_button.dart';
import 'package:te_find/app/widgets/pin_input_field.dart';
import 'package:te_find/utils/assets_manager.dart';

import '../../utils/app_colors.dart';
import '../home/widgets/category_filter.dart';
import '../home/widgets/item_condition.dart';
import '../home/widgets/price_range.dart';
import 'custom_text_form_field.dart';

RangeValues _priceRange = const RangeValues(0, 50000);

final double _minPrice = 0;
final double _maxPrice = 100000;

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
          padding: EdgeInsets.symmetric(
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
                            hintStyle:
                            const TextStyle(color: AppColors.greyLight),
                            hintText: 'Summer Dress',
                            fillColor: Colors.transparent,
                            filled: true,
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(
                                  width: 1, color: AppColors.primaryColor),
                            ),
                            disabledBorder: const OutlineInputBorder(
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
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),
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
      isDismissible: true,
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
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                              padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 2),
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


}
