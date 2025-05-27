
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget closeAccountListTile(String image, String title, Function()? onPressed, {bool addSpacer = true,} ) {
  return GestureDetector(
    onTap: onPressed,
    child: Row(
      children: [
        SvgPicture.asset(image),
        SizedBox(width: 20.w),
        Flexible(
          child: Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ),
        if (addSpacer) Spacer(),
        IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.arrow_forward_ios,
            size: 18,
          ),
        ),
      ],
    ),
  );
}