import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:te_find/app/home/filter_page.dart';
import 'package:te_find/app/home/widgets/categoryTile.dart';
import 'package:te_find/app/home/widgets/category_grid.dart';
import 'package:te_find/app/home/widgets/product_gridview.dart';
import 'package:te_find/app/widgets/custom_bottom_sheet.dart';
import 'package:te_find/app/widgets/market_widget.dart';
import 'package:te_find/models/brandListModel.dart';
import 'package:te_find/providers/provider.dart';
import 'package:te_find/services/navigation/route_names.dart';
import 'package:te_find/utils/assets_manager.dart';
import 'package:te_find/utils/progress_bar_manager/utility_app_bar.dart';
import 'package:te_find/utils/screen_size.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:te_find/app/widgets/search_box.dart';
import 'package:te_find/providers/product_provider.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/progress_bar_manager/appbar.dart';

import '../../../models/MarketListModel.dart';
import '../../../providers/account_provider.dart';
import '../../widgets/brand_widget.dart';
import '../../widgets/custom_button.dart';

class AllFashionProduct extends ConsumerStatefulWidget {
  AllFashionProduct({super.key});

  @override
  ConsumerState<AllFashionProduct> createState() => _HomePageState();
}


class _HomePageState extends ConsumerState<AllFashionProduct> {
  final selectedSortBYProvider = StateProvider<String>((ref) => '');
  late AccountProvider accountProvider;
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
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    final filterOption = ref.watch(selectedSortBYProvider);

    return Scaffold(
      appBar: UtilityAppBar(
        text: "Fashion",
      ),
      body: SafeArea(
        child: Stack(children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                CategoryTile(
                  navigation: _navigation,
                  title: "Official Stores for Fashion",
                  showViewAll: true,
                  onTap: (){
                  //  brandAvailableScreenRoute
                    //productProvider.pushToAllScreen('header', products, );
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                FutureBuilder<List<BrandListModel>>(
                  future: productProvider.brand,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                          height: 200,
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
                              itemCount: 8,
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
                              itemCount: snapshot.data!.length >= 8
                                  ? 8
                                  : snapshot.data!.length,
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
                          ));
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
                            style:
                                TextStyle(fontSize: 14, color: AppColors.black),
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
                CategoryTile(
                  navigation: _navigation,
                  title: "Top deals for Fashion",
                  showViewAll: true,
                 // routeName: topDealsFashionScreenRoute,
                ),
                SizedBox(
                  height: 16.h,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 241.h,
                  child: ListView.builder(
                    padding: EdgeInsets.only(left: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      // return productGridview();
                    },
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                CategoryTile(
                  navigation: _navigation,
                  title: "More Products",
                  showViewAll: false,
                ),
                SizedBox(
                  height: 16.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    // padding: EdgeInsets.only(left: 20),
                    scrollDirection: Axis.vertical,
                    itemCount: 8,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.7),
                    itemBuilder: (context, index) {
                      // return productGridview();
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              bottom: Responsive.height(context) * 0.02,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      CustomBottomSheet.show(
                        context: context,
                        isDismissible: true,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Sort By ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.close))
                                ],
                              ),

                              Divider(),
                              SizedBox(
                                height: 10.0.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  ref
                                      .read(selectedSortBYProvider
                                      .notifier)
                                      .state = 'Low';
                                },
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                      "Price: Low to High",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight:
                                          FontWeight.w600,
                                          color: AppColors.black),
                                    ),

                                    Spacer(),
                                    Radio<String>(
                                      activeColor:
                                      AppColors.primaryColor,
                                      value: 'Low',
                                      groupValue: filterOption,
                                      onChanged: (value) {
                                        ref
                                            .read(
                                            selectedSortBYProvider
                                                .notifier)
                                            .state = value!;
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.h,),
                              GestureDetector(
                                onTap: () {
                                  ref
                                      .read(selectedSortBYProvider
                                      .notifier)
                                      .state = 'High';
                                },
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                      "Price: High to low",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight:
                                          FontWeight.w600,
                                          color: AppColors.black),
                                    ),

                                    Spacer(),
                                    Radio<String>(
                                      activeColor:
                                      AppColors.primaryColor,
                                      value: 'High',
                                      groupValue: filterOption,
                                      onChanged: (value) {
                                        ref
                                            .read(
                                            selectedSortBYProvider
                                                .notifier)
                                            .state = value!;
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.0.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  ref
                                      .read(selectedSortBYProvider
                                      .notifier)
                                      .state = 'A-Z';
                                },
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                      "From A-Z",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight:
                                          FontWeight.w600,
                                          color: AppColors.black),
                                    ),

                                    Spacer(),
                                    Radio<String>(
                                      activeColor:
                                      AppColors.primaryColor,
                                      value: 'A-Z',
                                      groupValue: filterOption,
                                      onChanged: (value) {
                                        ref
                                            .read(
                                            selectedSortBYProvider
                                                .notifier)
                                            .state = value!;
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.h,),
                              GestureDetector(
                                onTap: () {
                                  ref
                                      .read(selectedSortBYProvider
                                      .notifier)
                                      .state = 'Z-A';
                                },
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                      "From Z-A",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight:
                                          FontWeight.w600,
                                          color: AppColors.black),
                                    ),

                                    Spacer(),
                                    Radio<String>(
                                      activeColor:
                                      AppColors.primaryColor,
                                      value: 'Z-A',
                                      groupValue: filterOption,
                                      onChanged: (value) {
                                        ref
                                            .read(
                                            selectedSortBYProvider
                                                .notifier)
                                            .state = value!;
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),SizedBox(
                                height: 10.0.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  ref
                                      .read(selectedSortBYProvider
                                      .notifier)
                                      .state = 'Newest Release';
                                },
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                      "Newest Releases",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight:
                                          FontWeight.w600,
                                          color: AppColors.black),
                                    ),

                                    Spacer(),
                                    Radio<String>(
                                      activeColor:
                                      AppColors.primaryColor,
                                      value: 'Newest Release',
                                      groupValue: filterOption,
                                      onChanged: (value) {
                                        ref
                                            .read(
                                            selectedSortBYProvider
                                                .notifier)
                                            .state = value!;
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.h,),
                              GestureDetector(
                                onTap: () {
                                  ref
                                      .read(selectedSortBYProvider
                                      .notifier)
                                      .state = 'Popularity';
                                },
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                      "Popularity",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight:
                                          FontWeight.w600,
                                          color: AppColors.black),
                                    ),

                                    Spacer(),
                                    Radio<String>(
                                      activeColor:
                                      AppColors.primaryColor,
                                      value: 'Popularity',
                                      groupValue: filterOption,
                                      onChanged: (value) {
                                        ref
                                            .read(
                                            selectedSortBYProvider
                                                .notifier)
                                            .state = value!;
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.h,),
                              CustomButton(
                                  label: "Done",
                                  fillColor: AppColors.primaryColor,
                                  onPressed: (){Navigator.pop(context);}),
                              SizedBox(height: 20.h,),

                            ],


                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        border: Border.all(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sort By",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          SvgPicture.asset(Assets.sortBy),

                          // Icon(Icons.arrow_upward, color: AppColors.white, size: 18,),
                          // Icon(Icons.arrow_downward, color: AppColors.white, size: 18,)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Responsive.height(context) * 0.01,
                  ),
                  GestureDetector(
                    onTap: (){ Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FilterPage(),
                      ),
                    );},
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        border: Border.all(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Filter",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          SvgPicture.asset(Assets.filter),
                        ],
                      ),
                    ),
                  ),
                ],
              ))
        ]),
      ),
    );
  }
}
