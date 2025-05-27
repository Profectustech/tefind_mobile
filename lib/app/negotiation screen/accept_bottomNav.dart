import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import '../../utils/assets_manager.dart';
import '../widgets/custom_bottom_sheet.dart';
import '../widgets/custom_button.dart';

class AcceptBottomnav extends StatelessWidget {
  AcceptBottomnav({
    super.key,
  });

  bool negotiationExpired = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Negotiated Price:",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black),
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                "₦705,000.00",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.red),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Row(
            children: [
              Text(
                "Quantity:",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black),
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                "x3",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          negotiationExpired == false ?  Container(
            height: 41.h,
            decoration: BoxDecoration(
                color: AppColors.greyButton,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(
                  "Bid Expired",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppColors.greyButtonText),
                ),
              ],
            ),
          ) : Container(
            height: 41.h,
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart,
                  color: AppColors.white,
                  size: 16,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "Add To Cart",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white),
                ),
              ],
            ),
          ) ,
          SizedBox(
            height: 10.h,
          ),
          Expanded(
              child: Text(
            "This negotiated price would last till: 2023-05-05 05:04pm. Kindly purchase the product before the expiry time, otherwise the price would be reversed to the actual price.",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 10,
                color: AppColors.grey),
            textAlign: TextAlign.justify,
          ))
        ],
      ),
    );
  }
}
