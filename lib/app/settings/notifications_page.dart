import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:saleko/utils/assets_manager.dart';

import '../../utils/progress_bar_manager/utility_app_bar.dart';

class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({super.key});

  @override
  ConsumerState createState() => _NotificationsPageState();
}
bool isPushedOn = false;
bool isOfferOn = false;
bool isEmailOn = false;
class _NotificationsPageState extends ConsumerState<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UtilityAppBar(text: "Notifications", hasActions: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order Updates",
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Key events as they happen and messages from support and couriers related to your order",
              style: TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(Assets.notificationPhone, height: 18, width: 18,),
                SizedBox(
                  width: 5.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Push Notifications",
                      style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),

                      decoration: BoxDecoration(color: AppColors.greenLightest, borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "Recommended",
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ), 
                    
                  ],
                ),
                Spacer(),
                FlutterSwitch(
                  activeColor: AppColors.green,
                  width: 51.w,
                    height: 28.h,
                    valueFontSize: 12,
                    toggleSize: 30,
                    borderRadius: 22,
                    showOnOff: true,
                    value: isPushedOn, onToggle: (value) {
                  setState(() {
                    isPushedOn = value ?? false;
                  });
                }),
              ],
            ),
            SizedBox(height: 30.h,),
            Text(
              "Offers",
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Discounts, promotions and vouchers for you",
              style: TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.notificationPhone, height: 18, width: 18,),
                SizedBox(
                  width: 5.h,
                ),
                Text(
                  "Push Notifications",
                  style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),

                Spacer(),
                FlutterSwitch(
                    activeColor: AppColors.green,
                    width: 51.w,
                    height: 28.h,
                    valueFontSize: 12,
                    toggleSize: 30,
                    borderRadius: 22,
                    showOnOff: true,
                    value: isOfferOn, onToggle: (value) {
                  setState(() {
                    isOfferOn = value ?? false;
                  });
                }),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.notificationMail),
                SizedBox(
                  width: 5.h,
                ),
                Text(
                  "Personalized emails",
                  style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),

                Spacer(),
                FlutterSwitch(
                    activeColor: AppColors.green,
                    width: 51.w,
                    height: 28.h,
                    valueFontSize: 12,
                    toggleSize: 30,
                    borderRadius: 22,
                    showOnOff: true,
                    value: isEmailOn, onToggle: (value) {
                  setState(() {
                    isEmailOn = value ?? false;
                  });
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
