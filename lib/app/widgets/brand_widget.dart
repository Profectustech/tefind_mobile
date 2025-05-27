import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/brandListModel.dart';
import '../../utils/app_colors.dart';
import '../../utils/assets_manager.dart';

class brand_widget extends StatelessWidget {
  const brand_widget({
    super.key,
    required this.brand,
  });

  final BrandListModel brand;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80.h,
          width: 100.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.blueGrey.withOpacity(0.05),
          ),
          child: Image.asset(
            Assets.adidasLogo,
            width: 50,
            height: 50,
          ),

        ),
        SizedBox(height: 10.h,),
        Text(
          brand.name ?? "",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400
            ,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}
