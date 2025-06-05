import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';

Widget profileListTile(
  String image,
  String title,
  Function()? onPressed, {
  bool addSpacer = true,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      height: 48,
      color: Colors.transparent,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  height: 32.h,
                  width: 32.w,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(64, 210, 161, 0.1), shape: BoxShape.circle),
                  child: Center(child: SvgPicture.asset(image, color: AppColors.primaryColor, height: 15,))),
              SizedBox(width: 15.w),
              Text(
                title,
                style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              Spacer(),
              IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
