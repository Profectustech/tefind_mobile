import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:te_find/app/bottom_nav/nav_service.dart';
import 'package:te_find/app/orders/my_orders.dart';
import 'package:te_find/app/home/categories_page.dart';
import 'package:te_find/app/home/home_page.dart';
import 'package:te_find/app/profile/profile_page.dart';
import 'package:te_find/providers/product_provider.dart';
import 'package:te_find/providers/provider.dart';
import 'package:te_find/utils/app_colors.dart';

import '../home/Sell/sell-stepper.dart';
import '../home/Sell/sell_onboarding.dart';
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
    SteperExistingCustomer(),
    MyOrders(),
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
                activeIcon:  SvgPicture.asset(
                    "assets/images/activeHome.svg") ,
                icon: SvgPicture.asset(
                  "assets/images/inactiveHome.svg",
                  // color: navStateProvider.currentTabIndex == 0
                  //     ? AppColors.primaryColor
                  //     : AppColors.grey,
                  width: 23.0,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                activeIcon:  SvgPicture.asset(
                    "assets/images/activeSearch.svg") ,
                icon: SvgPicture.asset(
                  "assets/images/inactiveSearch.svg",
                  // color: navStateProvider.currentTabIndex == 1
                  //     ? AppColors.primaryColor
                  //     : null,
                  width: 23.0,
                ),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/shop.svg",
                  color: navStateProvider.currentTabIndex == 2
                      ? AppColors.primaryColor
                      : null,
                  width: 23.0,
                ),
                label: 'Sell',
              ),
              BottomNavigationBarItem(
                activeIcon:  SvgPicture.asset(
                    "assets/images/activeOrder.svg") ,
                icon: productProvider.cartModel?.data?.isEmpty ?? true
                    ? SvgPicture.asset(
                        "assets/images/inactiveOrder.svg",
                        // color: navStateProvider.currentTabIndex == 3
                        //     ? AppColors.primaryColor
                        //     : null,
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
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                activeIcon:  SvgPicture.asset(
                    "assets/images/user.svg") ,
                icon: SvgPicture.asset(
                  "assets/images/profile.svg",
                  // color: navStateProvider.currentTabIndex == 4
                  //     ? AppColors.primaryColor
                  //     : null,
                  width: 23.0,
                ),
                label: 'Profile',

              ),
            ]));
  }
}
