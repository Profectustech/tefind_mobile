import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/utils/app_colors.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required NavigatorService navigation,
    required this.title,
    this.showViewAll = true,
    this.onTap,
    this.imagePath,
    this.arguments,
  }) : _navigation = navigation;

  final NavigatorService _navigation;
  final String title;
  final bool showViewAll;
  final Function? onTap;
  final String? imagePath;
  final Object? arguments; // ✅ This was missing

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.only(left: 20, right: 20),
        height: 37.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(color: AppColors.white, fontSize: 14),
            ),
            if (showViewAll)
              Text(
                "View all",
                style: TextStyle(color: AppColors.white, fontSize: 14),
              ),
          ],
        ),
      ),
    );
  }
}
