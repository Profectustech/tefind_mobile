import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saleko/utils/app_colors.dart';

class PageIndicator extends ConsumerWidget {
  final bool isCurrentPage;

  const PageIndicator({super.key, required this.isCurrentPage});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return isCurrentPage
        ? Container(
            margin: EdgeInsets.only(left: 8.w),
            height: 7.h,
            width: 7.w,
            decoration: BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadius.circular(10.w),
            ),
          )
        : Container(
            margin: EdgeInsets.only(left: 8.w),
            height: 7.h,
            width: 7.w,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10.w),
            ),
          );
  }
}
