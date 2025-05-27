import 'package:flutter/material.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(
            width: 110.h,
          ),
          Image.asset(
            "assets/images/svg.logo.png",
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
