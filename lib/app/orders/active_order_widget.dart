
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/services/navigation/navigator_service.dart';

import '../../services/navigation/route_names.dart';
import '../../utils/app_colors.dart';
import '../widgets/custom_button.dart';

class ActiveOrderWidget extends StatelessWidget {
  const ActiveOrderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 10.h, horizontal: 10.w),
      height: 189.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 5.w,
            children: [
              Container(
                height: 64.h,
                width: 64.w,
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/cloth.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
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
                padding: EdgeInsets.symmetric(
                    horizontal: 5.w, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.lightYellow,
                  borderRadius:
                  BorderRadius.circular(26.r),
                ),
                child: Center(
                  child: Text(
                    'Pending',
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
          Divider(),
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
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
          CustomButton(
            onPressed: (){
              NavigatorService().navigateTo(orderDetailScreen);
            },
            label: 'View Details',
            buttonTextColor: Colors.black,
            fillColor: AppColors.greyLight,
          )
        ],
      ),
    );
  }
}
