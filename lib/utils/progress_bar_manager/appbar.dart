import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/assets_manager.dart'; // Import for AppColors

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  bool centerTitle;
  final String text;
  bool? displayBack;
  void Function() onTap;
  CustomAppBar(
      {super.key,
      required this.centerTitle,
      required this.text,
      required this.onTap,
      this.displayBack = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: displayBack ?? true,
      centerTitle: centerTitle,
      title: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.black,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
