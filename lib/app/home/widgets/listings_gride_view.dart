import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/app/home/products/product_detail.dart';
import 'package:te_find/app/widgets/bottom_modals.dart';
import 'package:te_find/models/Products.dart';
import 'package:te_find/models/productModel.dart';
import 'package:te_find/providers/account_provider.dart';
import 'package:te_find/providers/product_provider.dart';
import 'package:te_find/providers/provider.dart';
import 'package:te_find/services/navigation/route_names.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/assets_manager.dart';

import '../../../services/navigation/navigator_service.dart';
import '../../widgets/global.dart';

class ListingsGrideView extends ConsumerStatefulWidget {
  ListingsGrideView({
    super.key,
      required this.newProducts,
  });
   final Products newProducts;
  @override
  ConsumerState<ListingsGrideView> createState() => _PostTileState();
}

class _PostTileState extends ConsumerState<ListingsGrideView>
    with SingleTickerProviderStateMixin {
  late ProductProvider productProvider;
  late AccountProvider accountProvider;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void openCartDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

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
               arguments: widget.newProducts,
            );
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => ProductDetail()));
          },
          child: Stack(alignment: Alignment.center, children: [
            Container(
              height: 216.h,
              width: 165.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.2), // corrected method
                      spreadRadius: 0.2,
                      blurRadius: 0.2,
                      offset: Offset(0, 0.2),
                    ),
                  ],
                  color: AppColors.white),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        // imageUrl:
                        //     widget.newProducts.imageUrls?[0].localUrl ?? "",
                        imageUrl: widget.newProducts.images?.isNotEmpty ??
                            false
                            ? widget.newProducts.images[0] ?? ""
                            : "",
                        imageBuilder: (context, imageProvider) => ClipRRect(
                          borderRadius: BorderRadius.circular(15.r),
                          child: Container(
                            height: 140.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Container(
                          width: double.infinity, // 50.w,
                          height: 140.h,
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
                        errorWidget: (context, url, error) => ClipRRect(
                          borderRadius: BorderRadius.circular(15.r),
                          child: Image.asset(
                            Assets.laptopPowerbank,
                            height: 130.h,
                            width: double.infinity,
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
                              widget.newProducts.name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.blackTextColor),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              "₦${widget.newProducts.price}",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              "${formatDate("${widget.newProducts.createdAt}")}",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 85,
                    left: 5,
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                      decoration: BoxDecoration(
                          color: AppColors.orange,
                          borderRadius: BorderRadius.circular(28.r)),
                      child: Text(
                        "Good",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child:  InkWell(
                      onTap: (){
                        BottomModals.listingMoreOption(context: context, product: widget.newProducts, ref: ref );
                        // _controller.forward(from: 0.0);
                      },
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.more_vert,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ])),
    );
  }
}