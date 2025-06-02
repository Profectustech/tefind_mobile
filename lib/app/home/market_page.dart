import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:te_find/app/widgets/market_widget.dart';
import 'package:te_find/models/MarketListModel.dart';
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
    Future.microtask(() {
      setState(() {
        productProvider.setMyMarket();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = ref.watch(RiverpodProvider.productProvider);

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 30,
          ),
          Text(
            "Markets",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor),
          ),
          SizedBox(
            height: 20.h,
          ),
          SearchBox(
            hint: 'Search for Markets',
            controller: _searchController,
            onChanged: (v){

            }
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
              child: FutureBuilder<List<MarketListModel>>(
                  future: productProvider.market,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                          height: 200,
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Center(
                            child: Shimmer.fromColors(
                                direction: ShimmerDirection.ltr,
                                period: const Duration(seconds: 2),
                                baseColor: AppColors.greyLight,
                                highlightColor: AppColors.primaryColor,
                                child: ListView(
                                  scrollDirection: Axis.vertical,
                                  // shrinkWrap: true,
                                  children: [0, 1, 2, 3, 4, 5]
                                      .map((_) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 30.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 0.0),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: double.infinity,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 2.0),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 2.0),
                                                      ),
                                                      Container(
                                                        width: 40.0,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ))
                                      .toList(),
                                )),
                          ));
                    } else if (snapshot.data!.isNotEmpty) {
                      return ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          //physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          // shrinkWrap: true,

                          children: snapshot.data!
                              .map((feed) => MarketWidget(market: feed))
                              .toList());
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
                            "There is no market available",
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
                  })),
        ]),
      )),
    );
  }
}
