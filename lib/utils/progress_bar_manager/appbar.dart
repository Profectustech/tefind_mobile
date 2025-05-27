import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:saleko/utils/assets_manager.dart'; // Import for AppColors

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
      title: SvgPicture.asset(
        Assets.salekoWhite,
        color: AppColors.primaryColor,
      ),
      actions: [
        TextButton(
          onPressed: onTap,
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
        ),
        const SizedBox(width: 5),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
