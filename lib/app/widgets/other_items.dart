import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/app/home/products/product_detail.dart';
import 'package:te_find/models/Products.dart';
import 'package:te_find/models/productModel.dart';
import 'package:te_find/providers/account_provider.dart';
import 'package:te_find/providers/product_provider.dart';
import 'package:te_find/providers/provider.dart';
import 'package:te_find/services/navigation/route_names.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/assets_manager.dart';
import 'package:te_find/utils/helpers.dart';
import '../../../services/navigation/navigator_service.dart';

class OtherItems extends ConsumerStatefulWidget {
  OtherItems({
    super.key,
    //  required this.newProducts,
  });
  // final Products newProducts;
  @override
  ConsumerState<OtherItems> createState() => _OtherItemsState();
}

class _OtherItemsState extends ConsumerState<OtherItems>
    with SingleTickerProviderStateMixin {
  late ProductProvider productProvider;
  late AccountProvider accountProvider;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    // Future.microtask(() {
    //   productProvider.fetchCart();
    // });
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _scaleAnimation =
        Tween<double>(begin: 0.0, end: 1.5).animate(CurvedAnimation(
          parent: _controller,
          curve: Curves.elasticOut,
        ));

    _fadeAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOut,
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    productProvider = ref.watch(RiverpodProvider.productProvider);
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: GestureDetector(
          onDoubleTap: () {
            //  productProvider.addWishlist(widget.newProducts.productId ?? 0);
            _controller.forward(from: 0.0);
            // widget.onLikeToggle();
          },
          onTap: () {
            NavigatorService().navigateTo(
              productDetailScreenRoute,
              // arguments: widget.newProducts,
            );
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => ProductDetail()));
          },
          child: Stack(alignment: Alignment.center, children: [
            Container(
              height: 176.h,
              width: 160.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.white),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 120.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12)),
                          color: AppColors.primaryColor,
                          image: DecorationImage(
                            image: AssetImage('assets/images/bag.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 5.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Luxury Leather Handbag",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.blackTextColor),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              "₦18,000",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor),
                            ),
                            SizedBox(height: 2.h),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Row(
                            //       spacing: 5,
                            //       children: [
                            //         Container(
                            //           height: 16.h,
                            //           width: 16.w,
                            //           decoration: BoxDecoration(
                            //             shape: BoxShape.circle,
                            //             image: DecorationImage(
                            //               image: AssetImage('assets/images/bag.png'),
                            //               fit: BoxFit.cover,
                            //             ),
                            //           ),
                            //         ),
                            //         Text(
                            //           "Amara",
                            //           overflow: TextOverflow.ellipsis,
                            //           style: GoogleFonts.roboto(
                            //               fontSize: 12,
                            //               fontWeight: FontWeight.w400,
                            //               color: AppColors.grey),
                            //         ),
                            //       ],
                            //     ),
                            //     InkWell(
                            //       onTap: () {
                            //         // productProvider.addToCart(
                            //         //     widget.newProducts.sku ?? '', 1);
                            //       },
                            //       child: Center(
                            //           child: Container(
                            //             width: 66.w,
                            //             height: 20.h,
                            //             decoration: BoxDecoration(
                            //                 color: AppColors.containerWhite,
                            //                 borderRadius: BorderRadius.circular(10)),
                            //             child: Row(
                            //               mainAxisAlignment: MainAxisAlignment.center,
                            //               children: [
                            //                 Text(
                            //                   "Add To Cart",
                            //                   style: GoogleFonts.roboto(
                            //                       fontSize: 10,
                            //                       fontWeight: FontWeight.w600,
                            //                       color: AppColors.primaryColor),
                            //                 )
                            //               ],
                            //             ),
                            //           )),
                            //     )
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Positioned(
                  //   top: 70,
                  //   left: 0,
                  //   right: 0,
                  //   child: InkWell(
                  //     onTap: () {
                  //       // productProvider.addToCart(
                  //       //     widget.newProducts.sku ?? '', 1);
                  //     },
                  //     child: Container(
                  //       width: double.infinity,
                  //       height: 30.h,
                  //       decoration: BoxDecoration(
                  //         color: Colors.black.withOpacity(0.5),
                  //       ),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Icon(
                  //             Icons.add,
                  //             color: AppColors.white,
                  //             size: 16,
                  //           ),
                  //           SizedBox(
                  //             width: 5.w,
                  //           ),
                  //           Text(
                  //             "Add To Cart",
                  //             style: GoogleFonts.roboto(
                  //                 fontSize: 12,
                  //                 fontWeight: FontWeight.w400,
                  //                 color: AppColors.white),
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Positioned(
                    bottom: 63,
                    left: 5,
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                      decoration: BoxDecoration(
                          color: AppColors.orange,
                          borderRadius: BorderRadius.circular(28.r)),
                      child: Text(
                        "Like New",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white),
                      ),
                    ),
                  ),
                  // Positioned(
                  //   top: 8,
                  //   right: 8,
                  //   child:  InkWell(
                  //     onTap: (){
                  //       _controller.forward(from: 0.0);
                  //     },
                  //     child: Container(
                  //       height: 32,
                  //       width: 32,
                  //       decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         shape: BoxShape.circle,
                  //       ),
                  //       child: Center(
                  //         child: Icon(
                  //           Icons.favorite_border_outlined,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            ScaleTransition(
              scale: _scaleAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: const Icon(
                  Icons.favorite,
                  color: Colors.pink,
                  size: 40,
                ),
              ),
            ),
          ])),
    );
  }
}