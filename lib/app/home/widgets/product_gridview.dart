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

class ProductGridview extends ConsumerStatefulWidget {
  ProductGridview({
    super.key,
    required this.newProducts,
  });
  final Products newProducts;
  @override
  ConsumerState<ProductGridview> createState() => _PostTileState();
}

class _PostTileState extends ConsumerState<ProductGridview>
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
            productProvider.addWishlist(widget.newProducts.productId ?? 0);
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
              height: 242.h,
              width: 154.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.white),
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              child: Stack(
                children: [
                  SizedBox(height: 8.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      CachedNetworkImage(
                        // imageUrl:
                        //     widget.newProducts.imageUrls?[0].localUrl ?? "",
                        imageUrl: widget.newProducts.imageUrls?.isNotEmpty ??
                                false
                            ? widget.newProducts.imageUrls![0].localUrl ?? ""
                            : "",
                        imageBuilder: (context, imageProvider) => ClipRRect(
                          borderRadius: BorderRadius.circular(15.r),
                          child: Container(
                            height: 130.h,
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
                          height: 130.h,
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
                      SizedBox(height: 8.h),
                      Text(
                        "${widget.newProducts.name}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blackTextColor),
                      ),
                      widget.newProducts.qty! < 10
                          ? Text(
                              // allProducts[index].title
                              "FEW ITEMS LEFT ${widget.newProducts.qty!}",
                              style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.red),
                            )
                          : Container(
                              height: 10.h,
                            ),
                      Row(
                        children: [
                          widget.newProducts.specialPrice != "0.0000"
                              ? Text(
                                  "${currencyFormat.format(double.parse(widget.newProducts.price ?? "0.0"))}",
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: AppColors.greyText,
                                      decorationThickness: 2,
                                      color: AppColors.greyText,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400),
                                )
                              : Container(),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            widget.newProducts.specialPrice != "0.0000"
                                ? "${currencyFormat.format(double.parse(widget.newProducts.specialPrice ?? "0.0"))}"
                                : "${currencyFormat.format(double.parse(widget.newProducts.price ?? "0.0"))}",
                            // "#${widget.newProducts.price}",
                            style: GoogleFonts.roboto(
                                color: AppColors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      InkWell(
                        onTap: () {
                          productProvider.addToCart(
                              widget.newProducts.sku ?? '', 1);
                        },
                        child: Center(
                            child: Container(
                          width: 120.w,
                          height: 26.h,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
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
                                "Add To Cart",
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
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite_border,
                        color: AppColors.primaryColor,
                      ),
                      onPressed: () {
                        _controller.forward(from: 0.0);
                        productProvider
                            .addWishlist(widget.newProducts.productId ?? 0);
                      },
                    ),
                  ),

                  //---------Discount Widget-----------------//
                  widget.newProducts.percentageDiscount != 0
                      ? Positioned(
                          top: 7,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.red,
                            ),
                            padding: EdgeInsets.only(
                                top: 5, right: 8, bottom: 4, left: 8),
                            child: Text(
                              "${widget.newProducts.percentageDiscount}% off",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      : Container(),
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
