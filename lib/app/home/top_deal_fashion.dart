import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saleko/app/home/widgets/categoryTile.dart';
import 'package:saleko/app/home/widgets/product_gridview.dart';
import 'package:saleko/providers/provider.dart';
import 'package:saleko/services/navigation/route_names.dart';
import 'package:saleko/utils/assets_manager.dart';
import 'package:saleko/utils/progress_bar_manager/utility_app_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:saleko/app/widgets/search_box.dart';
import 'package:saleko/providers/product_provider.dart';
import 'package:saleko/services/navigation/navigator_service.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:saleko/utils/progress_bar_manager/appbar.dart';

import '../../providers/account_provider.dart';

// Create a provider to manage the current page index
final currentIndexProvider = StateProvider<int>((ref) => 0);

class TopDealFashion extends ConsumerStatefulWidget {
  TopDealFashion({super.key});

  @override
  ConsumerState<TopDealFashion> createState() => _HomePageState();
  final NavigatorService _navigation = NavigatorService();
}

class _HomePageState extends ConsumerState<TopDealFashion> {
  late AccountProvider accountProvider;
  final NavigatorService _navigation = NavigatorService();
  //navigation
  void signUp() {
    _navigation.navigateTo(signupScreenRoute);
  }

  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);

    return Scaffold(
        appBar: UtilityAppBar(
          text: "Fashion",
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                SizedBox(
                  height: 20.h,
                ),
                CategoryTile(
                  navigation: _navigation,
                  title: "Top deals for Fashion",
                  showViewAll: false,
                ),
                SizedBox(
                  height: 16.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    // padding: EdgeInsets.only(left: 20),
                    scrollDirection: Axis.vertical,
                    itemCount: 8,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                            childAspectRatio: 0.75),
                    itemBuilder: (context, index) {
                      // return productGridview();
                    },
                  ),
                ),
              ])),
        ));
  }
}
