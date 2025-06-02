import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:te_find/app/home/market/all_market_page.dart';
import 'package:te_find/app/widgets/loader_widget.dart';
import 'package:te_find/app/widgets/market_widget.dart';
import 'package:te_find/models/MarketListModel.dart';
import 'package:te_find/utils/assets_manager.dart';
import 'package:te_find/utils/enums.dart';
import 'package:te_find/utils/network_error_screen.dart';
import 'package:te_find/utils/screen_size.dart';
import 'package:shimmer/shimmer.dart';
import 'package:te_find/providers/provider.dart';
import 'package:te_find/app/widgets/search_box.dart';
import 'package:te_find/providers/product_provider.dart';
import 'package:te_find/utils/app_colors.dart';

class MarketPage extends ConsumerStatefulWidget {
  MarketPage({super.key});

  @override
  ConsumerState<MarketPage> createState() => _HomePageState();
}
class _HomePageState extends ConsumerState<MarketPage> {
  late ProductProvider productProvider;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      productProvider.fetchMarket();
    });
    // _searchController.addListener(() {
    //   final searchText = _searchController.text.trim();
    //   productProvider.filterMarketItems(searchText);
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = ref.watch(RiverpodProvider.productProvider);
    final isSearching = _searchController.text.trim().isNotEmpty;
    final filteredMarkets = productProvider.filteredMarketList;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Text(
                "Markets",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 20.h),
              SearchBox(
                hint: 'Search for Markets',
                controller: _searchController,
                onChanged: (v){
                  productProvider.filterMarketItems(v);
                  setState(() {

                  });
                },
              ),
              SizedBox(height: 20.h),
              if (isSearching)
                filteredMarkets.isNotEmpty
                    ? SizedBox(
                  height: Responsive.height(context) / 1.3,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: filteredMarkets
                        .map((market) => MarketWidget(market: market))
                        .toList(),
                  ),
                )
                    : Center(
                  child: Text(
                    'No market found for ${_searchController.text}',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.black,
                    ),
                  ),
                )
              else
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
                        children:
                        [0, 1, 2, 3].map((_) => const LoaderWidget()).toList(),
                      ),
                    ),
                  ),
                )
                    : productProvider.loadingState == LoadingState.done
                    ? productProvider.packageList!.isNotEmpty
                    ? SizedBox(
                  height: Responsive.height(context) / 1.3,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: 12.h),
                        Column(
                          children: productProvider.packageList!
                              .map((feed) => MarketWidget(market: feed))
                              .toList(),
                        ),
                        const SizedBox(height: 30),
                        productProvider.fetchState == LoadingState.loading
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
                                children: [0, 1]
                                    .map((_) => const LoaderWidget())
                                    .toList(),
                              ),
                            ),
                          ),
                        )
                            : const SizedBox(height: 1),
                      ],
                    ),
                  ),
                )
                    : Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      SvgPicture.asset(
                        Assets.te_find,
                        color: Colors.white,
                      ),
                      const Text(
                        "No Market available",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                )
                    : NetworkErrorScreen(
                  title: 'Network error try again',
                  onPressed: () {
                    productProvider.fetchMarket();
                  },
                ),

              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}


