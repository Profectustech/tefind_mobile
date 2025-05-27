import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../services/navigation/navigator_service.dart';
import '../../services/navigation/route_names.dart';
import '../../utils/app_colors.dart';

class SeeAllProduct extends StatelessWidget {
  final Function()? onTap;
  const SeeAllProduct({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      //_navigation.navigateTo(allFashionScreenRoute);},
      child: Container(
        // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.only(
          left: 20,
        ),
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
              "See all product",
              style: TextStyle(color: AppColors.white, fontSize: 14),
            ),
            IconButton(
                onPressed: () {
                  if (onTap != null) {
                    onTap!();
                  }
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.white,
                  size: 12.h,
                ))
          ],
        ),
      ),
    );
  }
}
