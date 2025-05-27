import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:saleko/utils/app_colors.dart';

class SearchBox extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final Color? backgroundColor;
  final Function(String)? onChanged;

  const SearchBox({
    super.key,
    required this.hint,
    this.backgroundColor,
    this.onChanged,
    this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(11.42)),
      child: SearchBar(
        controller: controller ,
        elevation: MaterialStateProperty.all(0.0),
        backgroundColor: MaterialStateProperty.all(
          backgroundColor ?? AppColors.white,
        ),
        padding: MaterialStateProperty.all(
          EdgeInsets.only(left: 15.0, right: 0),
        ),
        leading: SvgPicture.asset(
          "assets/images/searchIcon.svg",
          color: AppColors.greenLighter,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11.42.r),
          ),
        ),
        onChanged: (v) {
          if (onChanged != null) {
            onChanged!(v);
          }
        },
        hintText: hint,
        hintStyle: MaterialStateProperty.all(
          TextStyle(
            color: AppColors.greenLighter,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
