import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saleko/utils/app_colors.dart';

class feature_widget extends StatelessWidget {
  final String title;
  const feature_widget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          decoration:
              BoxDecoration(color: AppColors.greenFade, shape: BoxShape.circle),
          child: Center(
            child: Icon(
              Icons.check,
              color: AppColors.primaryColor,
              size: 20,
            ),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.greyText),
          ),
        )
      ],
    );
  }
}
