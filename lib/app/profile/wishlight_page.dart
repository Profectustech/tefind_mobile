import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:saleko/providers/product_provider.dart';
import 'package:saleko/providers/provider.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:saleko/utils/assets_manager.dart';
import 'package:saleko/utils/progress_bar_manager/utility_app_bar.dart';
import 'package:saleko/utils/screen_size.dart';

import '../home/products/product_detail_fullScreen.dart';

class WishlistPage extends ConsumerStatefulWidget {
  const WishlistPage({super.key});

  @override
  ConsumerState<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends ConsumerState<WishlistPage> {
  final balanceVisibilityProvider = StateProvider<bool>((ref) => false);
  late ProductProvider productProvider;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      productProvider.setMyWishList();
    });
  }

  @override
  Widget build(BuildContext context) {
    productProvider = ref.watch(RiverpodProvider.productProvider);

    return Scaffold(
      appBar: UtilityAppBar(text: "Wishlist", hasActions: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (productProvider.wishListProduct?.isNotEmpty ?? false)
                  ? ListView.builder(
                      itemCount: productProvider.wishListProduct!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final wishListProduct =
                            productProvider.wishListProduct?[index];

                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => FullScreenImagePage(
                                            imageUrl: wishListProduct
                                                    ?.images?.first ??
                                                '',
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 80.h,
                                      width: 80.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            Colors.blueGrey.withOpacity(0.05),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            wishListProduct?.images?.first ??
                                                '',
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) => Center(
                                          child: SizedBox(
                                            width: 30.w,
                                            height: 30.h,
                                            child:
                                                const CircularProgressIndicator(
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                          child: Image.asset(
                                            Assets.laptopPowerbank,
                                            height: 115,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                wishListProduct
                                                        ?.product
                                                        ?.productCategory
                                                        ?.categoryType ??
                                                    "",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 31.67.h,
                                              width: 31.67.w,
                                              decoration: BoxDecoration(
                                                color: AppColors.lightPink,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                child: SvgPicture.asset(
                                                  Assets.deleteWishlist,
                                                  height: 16,
                                                  width: 16,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        // SizedBox(height: 5.h),
                                        // Text(
                                        //   "₦20,000.35",
                                        //   style: TextStyle(
                                        //     fontSize: 10,
                                        //     color: AppColors.grey,
                                        //     fontWeight: FontWeight.w200,
                                        //   ),
                                        // ),
                                        SizedBox(height: 5.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              wishListProduct?.price
                                                      .toString() ??
                                                  "",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: AppColors.red,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                productProvider.addToCart(
                                                  wishListProduct
                                                          ?.product?.sku ??
                                                      '',
                                                  1,
                                                );
                                              },
                                              child: Container(
                                                width: 99.w,
                                                height: 26.h,
                                                decoration: BoxDecoration(
                                                  color: AppColors.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.shopping_cart,
                                                      color: AppColors.white,
                                                      size: 16,
                                                    ),
                                                    SizedBox(width: 5.w),
                                                    Text(
                                                      "Add To Cart",
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppColors.white,
                                                      ),
                                                    )
                                                  ],
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
                              SizedBox(height: 10.h),
                              Divider(),
                            ],
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Column(
                        children: [
                          SizedBox(height: 50),
                          Image.asset(
                            Assets.wishListEmpty,
                            height: 200,
                            width: 200,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Your wishlist is feeling lonely.',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Show it some love!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: AppColors.grey,
                            ),
                          ),
                          SizedBox(height: 30),
                          // Add "Start Shopping" button here if needed
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
