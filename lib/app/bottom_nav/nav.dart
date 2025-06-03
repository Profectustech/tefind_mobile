import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:te_find/app/bottom_nav/nav_service.dart';
import 'package:te_find/app/home/cart_page.dart';
import 'package:te_find/app/home/categories_page.dart';
import 'package:te_find/app/home/home_page.dart';
import 'package:te_find/app/home/market/market_page.dart';
import 'package:te_find/app/profile/profile_page.dart';
import 'package:te_find/providers/product_provider.dart';
import 'package:te_find/providers/provider.dart';
import 'package:te_find/utils/app_colors.dart';

import '../search/search_page.dart';

class BottomNav extends ConsumerStatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  ConsumerState<BottomNav> createState() => _NavState();
}

class _NavState extends ConsumerState<BottomNav> {
  late NavStateProvider navStateProvider;
  late ProductProvider productProvider;

  int pageIndex = 0;
  final pages = [
    HomePage(),
    SearchPage(),
    MarketPage(),
    CartPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    navStateProvider = ref.watch(RiverpodProvider.navStateProvider);
    productProvider = ref.watch(RiverpodProvider.productProvider);

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        backgroundColor: Colors.white,
        body: pages[navStateProvider.currentTabIndex],
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (newTab) {
              navStateProvider.setCurrentTabTo(newTabIndex: newTab);
            },
            currentIndex: navStateProvider.currentTabIndex,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/home.svg",
                  color: navStateProvider.currentTabIndex == 0
                      ? AppColors.primaryColor
                      : AppColors.grey,
                  width: 23.0,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/dashboard.svg",
                  color: navStateProvider.currentTabIndex == 1
                      ? AppColors.primaryColor
                      : null,
                  width: 23.0,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/shop.svg",
                  color: navStateProvider.currentTabIndex == 2
                      ? AppColors.primaryColor
                      : null,
                  width: 23.0,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: productProvider.cartModel?.data?.isEmpty ?? true
                    ? SvgPicture.asset(
                        "assets/images/cart.svg",
                        color: navStateProvider.currentTabIndex == 3
                            ? AppColors.primaryColor
                            : null,
                        width: 23.0,
                      )
                    : Badge(
                        backgroundColor: AppColors.primaryColor,
                        label: Text(
                            '${productProvider.cartModel?.data?.first.items?.length}'),
                        child: SvgPicture.asset(
                          "assets/images/cart.svg",
                          color: navStateProvider.currentTabIndex == 3
                              ? AppColors.primaryColor
                              : null,
                          width: 23.0,
                        )),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/profile.svg",
                  color: navStateProvider.currentTabIndex == 4
                      ? AppColors.primaryColor
                      : null,
                  width: 23.0,
                ),
                label: '',
              ),
            ]));
  }
}
