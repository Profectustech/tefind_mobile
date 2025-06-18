import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:te_find/app/home/products/selectedProduct.dart';
import 'package:te_find/app/widgets/loader_widget.dart';
import 'package:te_find/providers/product_provider.dart';
import 'package:te_find/providers/provider.dart';
import 'package:te_find/services/navigation/route_names.dart';
import 'package:te_find/utils/enums.dart';
import 'package:te_find/utils/network_error_screen.dart';
import 'package:te_find/utils/progress_bar_manager/utility_app_bar.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:shimmer/shimmer.dart';
import '../../../models/CategoriesModel.dart';
import '../../../models/Products.dart';
import '../../../providers/account_provider.dart';
import '../../../utils/assets_manager.dart';
import '../../../utils/screen_size.dart';
import '../../widgets/see_all_product.dart';
import '../widgets/product_gridview.dart';

class ViewAllProducts extends ConsumerStatefulWidget {
  final String headerName;
  ViewAllProducts({super.key, required this.headerName});

  @override
  ConsumerState<ViewAllProducts> createState() => _ViewAllProductState();
}

class _ViewAllProductState extends ConsumerState<ViewAllProducts> {
  late AccountProvider accountProvider;
  late ProductProvider productProvider;
  final NavigatorService _navigation = NavigatorService();
  ScrollController? controller = ScrollController();
  @override
  void initState() {
    Future.microtask(() {
      controller!.addListener(() {
        productProvider.paginateAllScreen(widget.headerName, controller );
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    productProvider = ref.watch(RiverpodProvider.productProvider);
    return Scaffold(
        appBar: UtilityAppBar(
          text: widget.headerName,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              productProvider.loadingState == LoadingState.loading
                  ? Container(
                      height: 400,
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Shimmer.fromColors(
                            direction: ShimmerDirection.ltr,
                            period: const Duration(seconds: 2),
                            baseColor: AppColors.white,
                            highlightColor: AppColors.primaryColor,
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              // shrinkWrap: true,
                              children: [0, 1, 2, 3]
                                  .map((_) => const LoaderWidget())
                                  .toList(),
                            )),
                      ),
                    )
                  : productProvider.loadingState == LoadingState.done
                      ? productProvider.allProduct!.isNotEmpty
                          ? SizedBox(
                              height: Responsive.height(context) / 1.3,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                controller: controller,
                                physics: const BouncingScrollPhysics(),
                                // shrinkWrap: true,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    GridView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 9,
                                        crossAxisSpacing: 6,
                                        childAspectRatio: 0.65,
                                      ),
                                      itemCount:
                                          productProvider.allProduct!.length,
                                      itemBuilder: (context, index) {
                                        final feed =
                                            productProvider.allProduct![index];
                                        // return ProductGridview(
                                        //     newProducts: feed);
                                      },
                                    ),
                                    const SizedBox(height: 30),
                                    productProvider.fetchState ==
                                            LoadingState.loading
                                        ? Container(
                                            height: 400,
                                            padding: const EdgeInsets.all(20.0),
                                            child: Center(
                                              child: Shimmer.fromColors(
                                                  direction:
                                                      ShimmerDirection.ltr,
                                                  period: const Duration(
                                                      seconds: 2),
                                                  baseColor: AppColors.white,
                                                  highlightColor:
                                                      AppColors.primaryColor,
                                                  child: ListView(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    // shrinkWrap: true,
                                                    children: [
                                                      0,
                                                      1,
                                                    ]
                                                        .map((_) =>
                                                            const LoaderWidget())
                                                        .toList(),
                                                  )),
                                            ),
                                          )
                                        : const SizedBox(height: 1)
                                  ],
                                ),
                              ))
                          : Center(
                              child: Column(
                              //  mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                SvgPicture.asset(
                                  Assets.te_find,
                                  color: Colors.white,
                                ),
                                const Text(
                                  "No Product available",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ))
                      : NetworkErrorScreen(
                          title: 'Network error try again',
                          onPressed: () {
                           // productProvider.fetchMarket();
                          },
                        ),
              SizedBox(height: 50.h),

              // productProvider.allProduct?.isNotEmpty
              //     ? GridView.builder(
              //   physics: NeverScrollableScrollPhysics(),
              //   shrinkWrap: true,
              //   padding: const EdgeInsets.symmetric(vertical: 10),
              //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 2,
              //     mainAxisSpacing: 9,
              //     crossAxisSpacing: 6,
              //     childAspectRatio: 0.65,
              //   ),
              //   itemCount: productProvider.allProduct.length,
              //   itemBuilder: (context, index) {
              //     final product = productProvider.allProduct[index];
              //     return ProductGridview(newProducts: product);
              //   },
              // )
              //     : Center(
              //   child: Column(
              //     children: [
              //       const SizedBox(height: 50),
              //       const Text(
              //         "There is no product available",
              //         style: TextStyle(fontSize: 14, color: AppColors.black),
              //         textAlign: TextAlign.center,
              //       ),
              //       const SizedBox(height: 30),
              //     ],
              //   ),
              // ),
            ]),
          )),
        ));
  }
}
