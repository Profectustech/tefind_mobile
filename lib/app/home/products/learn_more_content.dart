
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../services/navigation/navigator_service.dart';
import '../../../services/navigation/route_names.dart';
import '../../../utils/app_colors.dart';

class LearnMoreContent extends StatelessWidget {
  const LearnMoreContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigatorService().navigateTo(carouselContent);
      },
      child: Container(
        height: 130.h,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/carouselImage.png',
                ),
                fit: BoxFit.cover)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 10.w, vertical: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Shop Sustainably',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white)),
              Row(
                children: [
                  Text(
                      'Give fashion a second life &\nsave the planet',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.white)),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.w, vertical: 5.w),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius:
                        BorderRadius.circular(16)),
                    child: Center(
                      child: Text(
                          'Learn More',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryColor)),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
