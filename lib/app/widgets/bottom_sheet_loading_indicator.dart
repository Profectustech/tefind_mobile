import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:saleko/utils/app_styles.dart';

class BottomSheetLoadingIndicator extends StatefulWidget {
  const BottomSheetLoadingIndicator({
    super.key,
  });

  @override
  State<BottomSheetLoadingIndicator> createState() =>
      _BottomSheetLoadingIndicatorState();
}

class _BottomSheetLoadingIndicatorState
    extends State<BottomSheetLoadingIndicator> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 177.w,
          height: 181.h,
          decoration: BoxDecoration(
            color: AppColors.secondaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(1000.r),
          ),
        ),
        Container(
          width: 117.w,
          height: 121.h,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(1000.r),
          ),
        ),
        // loading
        //     ?

        Text(
          'Please wait',
          style: AppStyles.createNormalTextStyle(textColor: AppColors.white),
        ),
        // : Text(
        //     'Done',
        //     style:
        //         AppStyles.createNormalTextStyle(textColor: AppColors.white),
        //   ),

        SizedBox(
          width: 137.w,
          height: 141.h,
          child: const CircularProgressIndicator(
            color: AppColors.primaryColor,
            strokeWidth: 2.0,
          ),
        ),
      ],
    );
  }
}
