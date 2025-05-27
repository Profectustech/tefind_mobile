import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saleko/app/profile/sellers/seller_store_page.dart';
import 'package:saleko/services/navigation/navigator_service.dart';
import 'package:saleko/services/navigation/route_names.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:saleko/utils/assets_manager.dart';

import '../../../models/BestSellerModel.dart';

class StoreCard extends ConsumerStatefulWidget {
  final BestSellerModel sellerProduct;
  const StoreCard({Key? key, required this.sellerProduct}) : super(key: key);

  @override
  ConsumerState<StoreCard> createState() => _StoreCardState();
}

class _StoreCardState extends ConsumerState<StoreCard> {

  NavigatorService _navigatorService = NavigatorService();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _navigatorService.navigateTo(
            sellersStorePage, arguments: widget.sellerProduct);
      },
      child: Container(
        height: 206,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background image

            Positioned(
              child: CachedNetworkImage(
                imageUrl: widget.sellerProduct.bannerImageUrl ?? "",
                imageBuilder: (context, imageProvider) => ClipRRect(
                  // borderRadius: BorderRadius.circular(15.r),
                  child: Container(
                    height: 129,
                    decoration: BoxDecoration(
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

              // ClipRRect(
              //   borderRadius: BorderRadius.circular(5.4.r),
              //   child: Container(
              //     height: 129,
              //     child: Image.asset(
              //       "assets/images/sellerID.png",
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
            ),
            // Category badge
            // Positioned(
            //   top: 8,
            //   left: 8,
            //   child: Container(
            //     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            //     decoration: BoxDecoration(
            //       color: AppColors.primaryColor,
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //     child: Text(
            //       "${widget.sellerProduct.}",
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 9,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //   ),
            // ),
            // Store icon
            Positioned(
              bottom: 40,
              left: 15,
              child: CachedNetworkImage(
                imageUrl: widget.sellerProduct.logoImageUrl ?? "",
                imageBuilder: (context, imageProvider) => ClipRRect(
                  // borderRadius: BorderRadius.circular(15.r),
                  child: Container(
                    height: 60,
                    width: 60,
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
            ),
            // Store name
            Positioned(
              bottom: 18,
              left: 12,
              child: Text(
                "${widget.sellerProduct.shopTitle}",
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            // Visit store button
            Positioned(
              bottom: 15,
              right: 5,
             // right: 0,
              child: GestureDetector(
                onTap: () {
                  _navigatorService.navigateTo(sellersStorePage, arguments: widget.sellerProduct);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Visit store",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
