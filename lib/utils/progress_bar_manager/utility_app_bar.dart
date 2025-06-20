import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/app/bottom_nav/nav_service.dart';
import 'package:te_find/providers/product_provider.dart';
import 'package:te_find/providers/provider.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/services/navigation/route_names.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/assets_manager.dart';
import 'package:te_find/utils/helpers.dart';

class UtilityAppBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  final bool centerTitle;
  final String text;
  final bool hasActions;

  const UtilityAppBar({
    Key? key,
    this.centerTitle = true,
    required this.text,
    this.hasActions = true,
  }) : super(key: key);

  @override
  ConsumerState<UtilityAppBar> createState() => _UtilityAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _UtilityAppBarState extends ConsumerState<UtilityAppBar> {
  late ProductProvider productProvider;
  late NavStateProvider navStateProvider;
  final NavigatorService _navigation = NavigatorService();
  @override
  Widget build(BuildContext context) {
    productProvider = ref.watch(RiverpodProvider.productProvider);
    navStateProvider = ref.watch(RiverpodProvider.navStateProvider);
    return AppBar(
      backgroundColor: AppColors.white,
      centerTitle: widget.centerTitle,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: AppColors.black,
          size: 15,
        ),
      ),
      title: Text(
        widget.text,
        style:  GoogleFonts.roboto(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: widget.hasActions
          ? [
              // SvgPicture.asset(
              //   "assets/images/searchIcon.svg",
              //   color: Colors.white,
              // ),
              SizedBox(width: 15.h),
              productProvider.cartModel?.data?.isEmpty ?? true
                  ? InkWell(
                      onTap: () {
                        navStateProvider.setCurrentTabTo(newTabIndex: 0);
                        _navigation.pushAndRemoveUntil(bottomNavigationRoute);
                      },
                      child: SvgPicture.asset(
                        "assets/images/cartIcon.svg",
                        color: Colors.black,
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        navStateProvider.setCurrentTabTo(newTabIndex: 3);
                        _navigation.pushAndRemoveUntil(bottomNavigationRoute);
                      },
                      child: Badge(
                          backgroundColor: AppColors.white,
                          label: Text(
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              '${productProvider.cartModel?.data?.first.items?.length}'),
                          child: SvgPicture.asset(
                            "assets/images/cartIcon.svg",
                            color: Colors.black,
                          ))),
              SizedBox(width: 20.h),
            ]
          : null,
    );
  }
}
