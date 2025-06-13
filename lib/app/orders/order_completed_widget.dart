import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/services/navigation/route_names.dart';

import '../../utils/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';

class OrderCompletedWidget extends StatelessWidget {
  const OrderCompletedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      height: 240.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(16)),
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
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.greyLight,
                  borderRadius: BorderRadius.circular(26.r),
                ),
                child: Center(
                  child: Text(
                    'Delivered',
                    style: GoogleFonts.roboto(
                      color: AppColors.grey,
                      fontSize: 11.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          Divider(),
          SizedBox(
            height: 4.h,
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
            height: 8.h,
          ),
          CustomButton(
            onPressed: (){
              NavigatorService().navigateTo(orderDetailScreen);
            },
            label: 'View Details',
            buttonTextColor: Colors.black,
            fillColor: AppColors.greyLight,
          ),
          SizedBox(
            height: 8.h,
          ),
          CustomButton(
            onPressed: () => _leaveReview(context),
            label: 'Leave a review',
            buttonTextColor: Colors.black,
            fillColor: AppColors.white,
            borderColor: AppColors.greyLight,
          )
        ],
      ),
    );
  }
}

void _leaveReview(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Review Seller',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  IconButton(onPressed: () {
                    Navigator.pop(context);
                  }, icon: Icon(Icons.close))
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Amara',
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          if (index < 4) {
                            return const Icon(Icons.star,
                                color: Colors.amber, size: 18);
                          } else {
                            return const Icon(Icons.star_half,
                                color: Colors.amber, size: 18);
                          }
                        }),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Text(
                'Leave a Review',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextFormField(
                maxLines: 6,
                //controller: accountProvider.lastNameController,
                hint: 'Type your message here',
                // validator: Validators().isSignUpEmpty,
              ),
              SizedBox(height: 20.h),
              CustomButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                fillColor: AppColors.primaryColor,
                label: 'Send Review',
                buttonTextColor: AppColors.white,
              )
            ],
          ),
        ),
      );
    },
  );
}
