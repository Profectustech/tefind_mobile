import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/app/widgets/custom_button.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/services/navigation/route_names.dart';

import '../../utils/app_colors.dart';

class SuccessfulTransaction extends ConsumerStatefulWidget {
  const SuccessfulTransaction({super.key});

  @override
  ConsumerState createState() => _SuccessfulTransactionState();
}

class _SuccessfulTransactionState extends ConsumerState<SuccessfulTransaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/sucessListing.svg'),
              SizedBox(height: 20.h),
              Text(
                'Order Confirmed',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                textAlign: TextAlign.center,
                'Your order #25874 has been placed successfully.\nYou will receive a confirmation email shortly.',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.lightTextBlack),
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomButton(
                onPressed: () {
                  NavigatorService()
                      .navigateReplacementTo(bottomNavigationRoute);
                },
                label: 'Continue Shopping',
                buttonTextColor: AppColors.white,
                fillColor: AppColors.primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
