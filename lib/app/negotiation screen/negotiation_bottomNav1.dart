import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/app_colors.dart';
import '../../utils/assets_manager.dart';
import '../widgets/custom_bottom_sheet.dart';
import '../widgets/custom_button.dart';

class InitialBottomNavigator extends StatelessWidget {
  final VoidCallback accept;
  final VoidCallback cancel;

  InitialBottomNavigator({
    super.key,
    required this.accept,
    required this.cancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 130,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Enter bid price",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey,
                ),
              ),
              SizedBox(width: 5.w),
              Expanded(
                child: TextField(
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.white,
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 11,
                      color: AppColors.grey,
                    ),
                    hintText: 'Enter Bid Price e.g ₦350,000',
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15.w),
              Container(
                height: 37,
                width: 90,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(2.71.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Send",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    SvgPicture.asset(Assets.sendIcon)
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          GestureDetector(
            onTap: () {
              CustomBottomSheet.show(
                context: context,
                isDismissible: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Accept Negotiation",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.close)),
                        ],
                      ),
                      Divider(),
                      SizedBox(height: 30.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 121,
                            width: 121,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.55, color: AppColors.grey)),
                            child: Image.asset(
                              Assets.laptopPowerbank,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "NP Sound Speaker NPFKJSK",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryColor),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                "Qty: 3",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.grey),
                              ),
                              SizedBox(height: 5.h),
                              Row(
                                children: [
                                  Text(
                                    "#\900,00",
                                    style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: AppColors.grey,
                                        decorationThickness: 2,
                                        color: AppColors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    "#\650,000",
                                    style: TextStyle(
                                        color: AppColors.red,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 70.h),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              borderColor: AppColors.primaryColor,
                              buttonTextColor: AppColors.primaryColor,
                              label: "Cancel ",
                              fillColor: Colors.transparent,
                              onPressed: cancel,
                            ),
                          ),
                          SizedBox(width: 52.w),
                          Expanded(
                            child: CustomButton(
                              label: "Accept ",
                              fillColor: AppColors.primaryColor,
                              onPressed: accept,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1, color: AppColors.primaryColor)),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Accept Offer",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Icon(
                      Icons.check,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
