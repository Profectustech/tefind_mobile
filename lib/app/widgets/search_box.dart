import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:te_find/app/widgets/bottom_modals.dart';
import 'package:te_find/providers/account_provider.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/assets_manager.dart';

import '../../providers/provider.dart';

class SearchBox extends ConsumerWidget {
  final String hint;
  final TextEditingController? controller;
  final Color? backgroundColor;
  final Function(String)? onChanged;

  SearchBox(
      {super.key,
      required this.hint,
      this.backgroundColor,
      this.onChanged,
      this.controller});
  late AccountProvider accountProvider;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      height: 40.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      child: Row(
        children: [
          Row(
            spacing: 5.w,
            children: [
              SvgPicture.asset(Assets.location),
              Text(
               accountProvider.currentAddress?.state ?? "",
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              VerticalDivider(
                color: AppColors.greenLighter,
                indent: 6,
                endIndent: 6,
                thickness: 1,
              ),
            ],
          ),
          Expanded(
            child: SearchBar(
              controller: controller,
              elevation: MaterialStateProperty.all(0.0),
              backgroundColor: MaterialStateProperty.all(
                backgroundColor ?? AppColors.white,
              ),
              padding: MaterialStateProperty.all(
                EdgeInsets.only(left: 10.0, right: 0),
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
          ),
          GestureDetector(
              onTap: () {
                BottomModals.homePageFilter(context: context);
              },
              child: SvgPicture.asset(Assets.filter)),
        ],
      ),
    );
  }
}
