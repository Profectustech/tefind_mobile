import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/services/navigation/route_names.dart';
import 'package:te_find/utils/app_colors.dart';

import '../../../models/CategoriesModel.dart';
import '../../../utils/assets_manager.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem({
    super.key,
    required this.categories,
  });

  final CategoriesModel categories;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            NavigatorService().navigateTo(
              fashionScreenRoute,
              arguments: categories,
            );
          },
          child: Container(
            height: 80.h,
            width: 80.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.blueGrey.withOpacity(0.05),
            ),
            child: CachedNetworkImage(
              imageUrl: categories.image ?? '',
              imageBuilder: (context, imageProvider) => ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Container(
                  height: 115,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              placeholder: (context, url) => Center(
                child: SizedBox(
                  width: 30.w,
                  height: 30.h,
                  child: const CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Image.asset(
                  Assets.laptopPowerbank,
                  height: 115,
                  width: double.infinity,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          categories.name ?? "",
          style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: AppColors.blackTextColor),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
