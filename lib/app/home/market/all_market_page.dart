import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:te_find/app/home/market/seller_filter.dart';
import 'package:te_find/utils/assets_manager.dart';
import 'package:te_find/utils/helpers.dart';
import 'package:te_find/utils/progress_bar_manager/utility_app_bar.dart';
import 'package:te_find/utils/toTitleCase.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/MarketListModel.dart';
import '../../../models/Products.dart';
import '../../../providers/product_provider.dart';
import '../../../providers/provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/screen_size.dart';
import '../../widgets/custom_bottom_sheet.dart';
import '../../widgets/custom_button.dart';
import '../filter_page.dart';
import '../widgets/product_gridview.dart';

class AllMarketPage extends ConsumerStatefulWidget {
  final MarketListModel model;
  AllMarketPage({super.key, required this.model});

  @override
  ConsumerState createState() => _AllMarketPageState();
}

class _AllMarketPageState extends ConsumerState<AllMarketPage> {
  final selectedSortBYProvider = StateProvider<String>((ref) => '');

  late ProductProvider productProvider;
  late Future<List<Products>> selectedMarketProduct;

  @override
  void initState() {
    Future.microtask(() {
      setState(() {
        productProvider.setMyMarket();
        productProvider.setMyMarketProduct(widget.model.marketId.toString());
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = ref.watch(RiverpodProvider.productProvider);
    final filterOption = ref.watch(selectedSortBYProvider);
    return Scaffold(
      appBar: UtilityAppBar(text: "Market"),
      body: Stack(children: [
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(children: [
              Container(
                // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: EdgeInsets.only(left: 10, right: 20),
                height: 37.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      Assets.customerService,
                      color: AppColors.white,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      (widget.model.name ?? "").toTitleCase(),
                      style: TextStyle(color: AppColors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              FutureBuilder<List<Products>>(
                future: productProvider.marketProduct,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                        height: 600,
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Center(
                            child: Shimmer.fromColors(
                          direction: ShimmerDirection.ltr,
                          period: const Duration(seconds: 10),
                          baseColor: AppColors.greyLight,
                          highlightColor: AppColors.primaryColor,
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 6,
                              childAspectRatio: 0.90,
                            ),
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 12.h,
                                      width: 100.w,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )));
                  } else if (snapshot.data!.isNotEmpty) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      // padding: EdgeInsets.only(left: 20),
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: 0.7),
                      itemBuilder: (context, index) {
                        Products  MarketProducts =
                        snapshot.data![index] as Products;
                         // return ProductGridview(
                         //   newProducts: MarketProducts,
                         // );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 100,
                        ),
                        Text(
                          'Network error',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Network error'),
                        SizedBox(
                          height: 100,
                        ),
                      ],
                    ));
                  } else {
                    return Center(
                        child: Column(
                      //  mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          "There is no product available in the Market",
                          style:
                              TextStyle(fontSize: 14, color: AppColors.black),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ));
                  }
                },
              ),
            ]),
          ),
        ),
        Positioned(
            bottom: 0, //Responsive.height(context) * 0.2,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    CustomBottomSheet.show(
                      context: context,
                      isDismissible: true,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sort By ",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.close))
                              ],
                            ),
                            Divider(),
                            SizedBox(
                              height: 10.0.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                ref
                                    .read(selectedSortBYProvider.notifier)
                                    .state = 'Low';
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Price: Low to High",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.black),
                                  ),
                                  Spacer(),
                                  Radio<String>(
                                    activeColor: AppColors.primaryColor,
                                    value: 'Low',
                                    groupValue: filterOption,
                                    onChanged: (value) {
                                      ref
                                          .read(selectedSortBYProvider.notifier)
                                          .state = value!;
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                ref
                                    .read(selectedSortBYProvider.notifier)
                                    .state = 'High';
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Price: High to low",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.black),
                                  ),
                                  Spacer(),
                                  Radio<String>(
                                    activeColor: AppColors.primaryColor,
                                    value: 'High',
                                    groupValue: filterOption,
                                    onChanged: (value) {
                                      ref
                                          .read(selectedSortBYProvider.notifier)
                                          .state = value!;
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.0.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                ref
                                    .read(selectedSortBYProvider.notifier)
                                    .state = 'A-Z';
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "From A-Z",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.black),
                                  ),
                                  Spacer(),
                                  Radio<String>(
                                    activeColor: AppColors.primaryColor,
                                    value: 'A-Z',
                                    groupValue: filterOption,
                                    onChanged: (value) {
                                      ref
                                          .read(selectedSortBYProvider.notifier)
                                          .state = value!;
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                ref
                                    .read(selectedSortBYProvider.notifier)
                                    .state = 'Z-A';
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "From Z-A",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.black),
                                  ),
                                  Spacer(),
                                  Radio<String>(
                                    activeColor: AppColors.primaryColor,
                                    value: 'Z-A',
                                    groupValue: filterOption,
                                    onChanged: (value) {
                                      ref
                                          .read(selectedSortBYProvider.notifier)
                                          .state = value!;
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.0.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                ref
                                    .read(selectedSortBYProvider.notifier)
                                    .state = 'Newest Release';
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Newest Releases",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.black),
                                  ),
                                  Spacer(),
                                  Radio<String>(
                                    activeColor: AppColors.primaryColor,
                                    value: 'Newest Release',
                                    groupValue: filterOption,
                                    onChanged: (value) {
                                      ref
                                          .read(selectedSortBYProvider.notifier)
                                          .state = value!;
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                ref
                                    .read(selectedSortBYProvider.notifier)
                                    .state = 'Popularity';
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Popularity",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.black),
                                  ),
                                  Spacer(),
                                  Radio<String>(
                                    activeColor: AppColors.primaryColor,
                                    value: 'Popularity',
                                    groupValue: filterOption,
                                    onChanged: (value) {
                                      ref
                                          .read(selectedSortBYProvider.notifier)
                                          .state = value!;
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomButton(
                                label: "Done",
                                fillColor: AppColors.primaryColor,
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      border: Border.all(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sort By",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        SvgPicture.asset(Assets.sortBy),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: Responsive.height(context) * 0.01,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SellerFilter(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      border: Border.all(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Filter",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        SvgPicture.asset(Assets.filter),
                      ],
                    ),
                  ),
                ),
              ],
            ))
      ]),
    );
  }
}
