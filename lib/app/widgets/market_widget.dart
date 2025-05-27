import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:saleko/models/MarketListModel.dart';
import 'package:saleko/providers/product_provider.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:saleko/utils/assets_manager.dart';
import 'package:saleko/utils/helpers.dart';
import 'package:saleko/utils/toTitleCase.dart';

import '../../providers/provider.dart';
import '../../services/navigation/navigator_service.dart';
import '../../services/navigation/route_names.dart';

class MarketWidget extends ConsumerWidget {
  final MarketListModel market;
  MarketWidget({
    super.key,
    required this.market,
    // required this.onTap
  });

  late ProductProvider productProvider;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    productProvider = ref.watch(RiverpodProvider.productProvider);
    return InkWell(
      // onTap: () {
      //   NavigatorService().navigateTo(allMarketPage, arguments: market);

      // },
      onTap: () async {
        final products = await productProvider
            .selectedMarketProduct(market.marketId.toString());
        if (products != null) {
          productProvider.pushToAllScreen("Market", products,
              id: market.marketId.toString());
        }
      },
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        margin: EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Market Image
            CachedNetworkImage(
              imageUrl: market.image ?? '',
              imageBuilder: (context, imageProvider) => ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Container(
                  height: 130,
                  width: double.infinity,
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
                  child: const CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Image.asset(
                  Assets.abojuMarket,
                  height: 115,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        (market.name ?? "").toTitleCase(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Icon(Icons.info_outline, color: AppColors.grey),
                      Spacer(),
                      Icon(Icons.share_outlined, color: AppColors.primaryColor),
                    ],
                  ),
                  // SizedBox(height: 4),
                  // Text(
                  //   '${market.description}',
                  //   style: TextStyle(fontSize: 12, color: AppColors.grey),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
