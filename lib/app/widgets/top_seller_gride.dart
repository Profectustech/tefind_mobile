import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saleko/app/home/products/product_detail.dart';
import 'package:saleko/models/Products.dart';
import 'package:saleko/models/productModel.dart';
import 'package:saleko/providers/account_provider.dart';
import 'package:saleko/providers/product_provider.dart';
import 'package:saleko/providers/provider.dart';
import 'package:saleko/services/navigation/route_names.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:saleko/utils/assets_manager.dart';
import 'package:saleko/utils/helpers.dart';
import '../../../services/navigation/navigator_service.dart';
import '../../models/BestSellerModel.dart';

class TopSellerGride extends ConsumerStatefulWidget {
  TopSellerGride({
    super.key,
    required this.newProducts,
  });
  final BestSellerModel newProducts;
  @override
  ConsumerState<TopSellerGride> createState() => _PostTileState();
}

class _PostTileState extends ConsumerState<TopSellerGride>
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
  NavigatorService _navigatorService = NavigatorService();
  @override
  Widget build(BuildContext context) {
    productProvider = ref.watch(RiverpodProvider.productProvider);
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: GestureDetector(
          onDoubleTap: () {
          },
          onTap: () {
            _navigatorService.navigateTo(sellersStorePage, arguments: widget.newProducts);
          },
          child: Stack(alignment: Alignment.center, children: [
            Container(
              height: 220.h,
              width: 154.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.white),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Stack(
                children: [
                  SizedBox(height: 8.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Center(
                        child: CachedNetworkImage(
                          imageUrl: widget.newProducts.logoImageUrl ?? "",
                          imageBuilder: (context, imageProvider) => ClipRRect(
                            borderRadius: BorderRadius.circular(15.r),
                            child: Container(
                              height: 100.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.greenLightest,
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Container(
                            width: 130.w,
                            height: 130.h,
                            decoration: BoxDecoration(
                                color: AppColors.greenLightest,
                                shape: BoxShape.circle),
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
                            height: 100.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                              color: AppColors.greenLightest,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                Assets.shop,
                                height: 50.h,
                                width: 50.w,
                                color: AppColors.primaryColor,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "${widget.newProducts.shopTitle}",
                              style: TextStyle(
                                  // decoration: TextDecoration.lineThrough,
                                  decorationColor: AppColors.greyText,
                                  decorationThickness: 2,
                                  color: AppColors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "${widget.newProducts.commodities} Orders", // "#${widget.newProducts.price}",
                              style: GoogleFonts.roboto(
                                  color: AppColors.greyText,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      InkWell(
                        onTap: () {
                          _navigatorService.navigateTo(sellersStorePage, arguments: widget.newProducts);
                        },
                        child: Center(
                            child: Container(
                          width: 120.w,
                          height: 26.h,
                          decoration: BoxDecoration(
                              color: AppColors.secondaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart,
                                color: AppColors.white,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                "View Store",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.white),
                              )
                            ],
                          ),
                        )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ])),
    );
  }
}
