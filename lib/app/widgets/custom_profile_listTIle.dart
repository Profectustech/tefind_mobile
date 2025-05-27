import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

Widget profileListTile(String image, String title, Function()? onPressed, {bool addSpacer = true,} ) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      height: 48,
      color: Colors.transparent,
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(image),
              SizedBox(width: 20.w),
              Text(
                title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
               Spacer(),
              IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
              ),
            ],
          ),

        ],
      ),
    ),
  );
}