import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';
import '../widgets/custom_button.dart';

class NewOrderWidget extends StatelessWidget {
  const NewOrderWidget({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 5.h),
      // height: 411.h,
      // width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              Container(
                height: 48.h,
                width: 48.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor,
                  image: DecorationImage(
                    image: AssetImage('assets/images/bag.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                'Oluwaseun Adebayo',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.lightYellow,
                  borderRadius: BorderRadius.circular(26.r),
                ),
                child: Center(
                  child: Text(
                    'New Order',
                    style: GoogleFonts.roboto(
                      color: AppColors.orange,
                      fontSize: 11.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            height: 150.h,
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.greyLight2,
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi, I'm interested in this lamp. Would you consider offering a discount if I order two units? I really love the design.",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400, fontSize: 12.sp),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  spacing: 8,
                  children: [
                    Text(
                      "Original:",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: AppColors.grey),
                    ),
                    Text(
                      "₦22,500",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: AppColors.black),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: AppColors.grey,
                    ),
                    Text(
                      "Offered:",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: AppColors.grey),
                    ),
                    Text(
                      "₦22,500",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            height: 189.h,
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 5.w,
                  children: [
                    Container(
                      height: 64.h,
                      width: 64.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: AssetImage('assets/images/cloth.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Floral Summer Dress',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Quantity: 1',
                          style: GoogleFonts.roboto(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey),
                        ),
                        Text(
                          '₦22,500',
                          style: GoogleFonts.roboto(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Divider(),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order #ORD-2025052601',
                      style: GoogleFonts.roboto(
                        color: AppColors.grey,
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      'May 26, 2025',
                      style: GoogleFonts.roboto(
                        color: AppColors.grey,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  spacing: 5.w,
                  children: [
                    Expanded(
                      child: CustomButton(
                        label: 'Decline',
                        buttonTextColor: Colors.black,
                        fillColor: AppColors.greyLight,
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        onPressed: () => _acceptOrder(context),
                        label: 'Accept',
                        buttonTextColor: Colors.white,
                        fillColor: AppColors.primaryColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _acceptOrder(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/images/sucessListing.svg'),
              SizedBox(height: 10.h),
              Text(
                'Order Approved',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                spacing: 7.w,
                children: [
                  Container(
                    height: 64.h,
                    width: 64.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage('assets/images/cloth.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Floral Summer Dress',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Quantity: 1',
                        style: GoogleFonts.roboto(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.grey),
                      ),
                      Text(
                        '₦22,500',
                        style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order #ORD-2025052502",
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: AppColors.lightTextBlack),
                  ),
                  Text(
                    'May 25, 2025',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.lightTextBlack),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              CustomButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                fillColor: AppColors.primaryColor,
                label: 'Send Package',
                buttonTextColor: AppColors.white,
              )
            ],
          ),
        ),
      );
    },
  );
}
