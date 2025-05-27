import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saleko/app/home/widgets/categoryTile.dart';
import 'package:saleko/app/home/widgets/category_grid.dart';
import 'package:saleko/app/home/widgets/product_gridview.dart';
import 'package:saleko/app/widgets/market_widget.dart';
import 'package:saleko/models/brandListModel.dart';
import 'package:saleko/providers/provider.dart';
import 'package:saleko/services/navigation/route_names.dart';
import 'package:saleko/utils/assets_manager.dart';
import 'package:saleko/utils/progress_bar_manager/utility_app_bar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:saleko/app/widgets/search_box.dart';
import 'package:saleko/providers/product_provider.dart';
import 'package:saleko/services/navigation/navigator_service.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:saleko/utils/progress_bar_manager/appbar.dart';

import '../../models/MarketListModel.dart';
import '../../providers/account_provider.dart';
import '../widgets/brand_widget.dart';

class AllBrandPage extends ConsumerStatefulWidget {
  AllBrandPage({super.key});

  @override
  ConsumerState<AllBrandPage> createState() => _AllBrandPageState();
}
class _AllBrandPageState extends ConsumerState<AllBrandPage> {
  late ProductProvider productProvider;
  final NavigatorService _navigation = NavigatorService();

  @override
  void initState() {
    Future.microtask(() {
      setState(() {
        productProvider.setMyBrand();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = ref.watch(RiverpodProvider.productProvider);
    return Scaffold(
        appBar: UtilityAppBar(
          text: "Brand",
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
                      title: "Official Stores for Fashion",
                      showViewAll: false,
                     // routeName: topDealsFashionScreenRoute,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    FutureBuilder<List<BrandListModel>>(
                      future: productProvider.brand,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Container(
                              height: 600,
                              padding: const EdgeInsets.only(left: 20.0, right: 20),
                              child: Center(
                                  child: Shimmer.fromColors(
                                    direction: ShimmerDirection.ltr,
                                    period: const Duration(seconds: 10),
                                    baseColor: AppColors.greyLight,
                                    highlightColor: AppColors.primaryColor,
                                    child: GridView.builder(
                                      gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 6,
                                        childAspectRatio: 0.90,
                                      ),
                                      itemCount: 20,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 12.h,
                                                width: 100.w,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  )));
                        } else if (snapshot.data!.isNotEmpty) {
                          return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Expanded(
                                child: GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.length,
                                  gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 4,
                                    crossAxisSpacing: 5,
                                    childAspectRatio: 0.65,
                                  ),
                                  itemBuilder: (context, index) {
                                    BrandListModel brand = snapshot.data![index];
                                    return brand_widget(brand: brand);
                                  },
                                ),
                              )
                          );
                        } else if (snapshot.hasError) {
                          return const Center(
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 100,
                                  ),
                                  Text(
                                    'Network error',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Network error'),
                                  SizedBox(
                                    height: 100,
                                  ),
                                ],
                              ));
                        } else {
                          return Center(
                              child: Column(
                                //  mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  const Text(
                                    "There is no brand available",
                                    style: TextStyle(
                                        fontSize: 14, color: AppColors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ));
                        }
                      },
                    ),
                  ])),
        ));
  }
}

