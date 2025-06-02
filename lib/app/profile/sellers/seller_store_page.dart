import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:te_find/app/widgets/loader_widget.dart';
import 'package:te_find/app/widgets/search_box.dart';
import 'package:te_find/models/BestSellerModel.dart';
import 'package:te_find/providers/product_provider.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/enums.dart';
import 'package:te_find/utils/network_error_screen.dart';
import 'package:te_find/utils/progress_bar_manager/utility_app_bar.dart';
import 'package:shimmer/shimmer.dart';

import '../../../providers/provider.dart';
import '../../../utils/assets_manager.dart';
import '../../../utils/screen_size.dart';
import '../../home/widgets/product_gridview.dart';

class SellerStorePage extends ConsumerStatefulWidget {
  final BestSellerModel product;
  const SellerStorePage({super.key, required this.product});

  @override
  ConsumerState createState() => _SellerStorePageState();
}

class _SellerStorePageState extends ConsumerState<SellerStorePage>
    with SingleTickerProviderStateMixin {
  //late TabController _tabController;

  // @override
  // void initState() {
  //   super.initState();
  //   _tabController = TabController(length: 2, vsync: this); // Two tabs
  // }
  late ProductProvider productProvider;
  ScrollController? controller = ScrollController();
  @override
  void initState() {
    Future.microtask(() async {
      final products = await productProvider
          .selectedProductBySeller(widget.product.merchantId!);
      productProvider.productSellerLoad(
        id: widget.product.merchantId!,
        products,
      );

      controller!.addListener(() {
        productProvider.paginateAllScreen('Product Seller', controller);
      });
    });
    super.initState();
  }

  // @override
  // void dispose() {
  //   _tabController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // accountProvider = ref.watch(RiverpodProvider.accountProvider);
    productProvider = ref.watch(RiverpodProvider.productProvider);
    return Scaffold(
        appBar: UtilityAppBar(
          text: "${widget.product.shopTitle}",
          hasActions: true,
        ),
        body: SingleChildScrollView(
          controller: controller,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.product.bannerImageUrl ?? "",
                      imageBuilder: (context, imageProvider) => ClipRRect(
                      //   borderRadius: BorderRadius.circular(15.r),
                        child: Container(
                          height: 128.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.27.r),
                            border: Border.all(color: AppColors.white, width: 3.w),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        height: 60.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                            color: AppColors.greenLightest, shape: BoxShape.circle),
                        child: Center(
                          child: SizedBox(
                            width: 30.w,
                            height: 30.h,
                            child: const CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 128.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.greenLightest,
                          borderRadius: BorderRadius.circular(14.27.r),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            Assets.shop,
                            height: 50,
                            width: 50,
                            color: AppColors.primaryColor,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                      height: 150.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(14.27.r),
                      ),
                      child: Column(
                        children: [
                          Row(
                            spacing: 20.w,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CachedNetworkImage(
                                imageUrl: widget.product.logoImageUrl ?? "",
                                imageBuilder: (context, imageProvider) => ClipRRect(
                                  child: Container(
                                    height: 98,
                                    width: 98,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: AppColors.white, width: 3),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => Container(
                                  height: 60.h,
                                  width: 60.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.greenLightest,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                      width: 30.w,
                                      height: 30.h,
                                      child: const CircularProgressIndicator(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  height: 129,
                                  decoration: BoxDecoration(
                                    color: AppColors.greenLightest,
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      Assets.shop,
                                      height: 50,
                                      width: 50,
                                      color: AppColors.primaryColor,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(width: 10.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${widget.product.shopTitle}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      "${widget.product.ordersCount} orders",
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Row(
                                      children: [
                                        SvgPicture.asset(Assets.storeLocation),
                                        SizedBox(width: 5.w),
                                        Expanded(
                                          child: Text(
                                            "${widget.product.marketInfo?.name}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                              : productProvider.loadingState ==
                                      LoadingState.done
                                  ? productProvider.allProduct!.isNotEmpty
                                      ? SizedBox(
                                          child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,

                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          // shrinkWrap: true,
                                          child: Column(
                                            children: [
                                              GridView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  mainAxisSpacing: 9,
                                                  crossAxisSpacing: 6,
                                                  childAspectRatio: 0.65,
                                                ),
                                                itemCount: productProvider
                                                    .allProduct!.length,
                                                itemBuilder: (context, index) {
                                                  final feed = productProvider
                                                      .allProduct![index];
                                                  // return ProductGridview(
                                                  //     newProducts: feed);
                                                },
                                              ),
                                              const SizedBox(height: 30),
                                              productProvider.fetchState ==
                                                      LoadingState.loading
                                                  ? Container(
                                                      height: 400,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20.0),
                                                      child: Center(
                                                        child:
                                                            Shimmer.fromColors(
                                                                direction:
                                                                    ShimmerDirection
                                                                        .ltr,
                                                                period: const Duration(
                                                                    seconds: 2),
                                                                baseColor:
                                                                    AppColors
                                                                        .white,
                                                                highlightColor:
                                                                    AppColors
                                                                        .primaryColor,
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
                                      onPressed: () async {
                                        final products = await productProvider
                                            .selectedProductBySeller(
                                                widget.product.merchantId!);
                                        productProvider.productSellerLoad(
                                          id: widget.product.merchantId!,
                                          products,
                                        );
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
                    // Container(
                    //   child:
                    //   Column(children: [
                    //     TabBar(
                    //       labelStyle:
                    //       TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    //       controller: _tabController,
                    //       indicatorColor: AppColors.primaryColor,
                    //       labelColor: AppColors.primaryColor,
                    //       unselectedLabelColor: AppColors.grey,
                    //       tabs: [
                    //         Tab(
                    //           text: "Products",
                    //         ),
                    //         Tab(text: "About seller"),
                    //       ],
                    //     ),
                    //
                    //     Container(
                    //       height: 1500,
                    //       child: TabBarView(controller: _tabController, children: [
                    //         //Products Screen
                    //         Padding(
                    //           padding: const EdgeInsets.symmetric(vertical: 20),
                    //           child: Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //
                    //               SearchBox(hint: "Search for products or sellers"),
                    //               SizedBox(height: 20.h,),
                    //               GridView.builder(
                    //                 shrinkWrap: true,
                    //                 physics: NeverScrollableScrollPhysics(),
                    //                 // padding: EdgeInsets.only(left: 20),
                    //                 scrollDirection: Axis.vertical,
                    //                 itemCount: 10,
                    //                 gridDelegate:
                    //                 const SliverGridDelegateWithFixedCrossAxisCount(
                    //                     crossAxisCount: 2,
                    //                     mainAxisSpacing: 16,
                    //                     crossAxisSpacing: 16,
                    //                     childAspectRatio: 0.7),
                    //                 itemBuilder: (context, index) {
                    //                   // return productGridview();
                    //                 },
                    //               ),
                    //
                    //             ],
                    //           ),
                    //         ),
                    //
                    //         //about sellers screen
                    //         Padding(
                    //           padding: const EdgeInsets.all(16.0),
                    //           child: Text(
                    //             "The sellers details comes in here. ",
                    //             style: TextStyle(
                    //               fontSize: 14,
                    //               color: AppColors.black,
                    //             ),
                    //           ),
                    //         ),
                    //       ]),
                    //     )
                    //
                    //   ],)
                    // ),
                  ])),
        ));
  }
}
