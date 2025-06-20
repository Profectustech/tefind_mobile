import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:te_find/app/widgets/bottom_modals.dart';
import 'package:te_find/providers/provider.dart';

import '../../models/Products.dart';
import '../../providers/product_provider.dart';
import '../../utils/app_colors.dart';
import '../home/widgets/listings_gride_view.dart';

class ListingViewAll extends ConsumerStatefulWidget {
  final List<Products> newProducts;
  const ListingViewAll({super.key, required this.newProducts});

  @override
  ConsumerState createState() => _ListingViewAllState();
}

class _ListingViewAllState extends ConsumerState<ListingViewAll> {
  List<String> items = ["All", "Active", "Sold", "Hidden", ];
  int current = 0;
late ProductProvider productProvider;
  @override
  Widget build(BuildContext context) {
    productProvider = ref.watch(RiverpodProvider.productProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Listings',
          style:
              GoogleFonts.roboto(fontSize: 18.sp, fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  ListView.builder(
                    itemCount: items.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (cxt, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            current = index;
                          });
                        },
                        child: Container(
                          height: 32.h,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 3),
                          padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 0),
                          decoration: BoxDecoration(
                            color: current == index
                                ? AppColors.primaryColor
                                : AppColors.greyLight,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Center(
                            child: Text(
                              items[index],
                              style: GoogleFonts.roboto(
                                color: current == index
                                    ? Colors.white
                                    : AppColors.lightTextBlack,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 10.w,),
                  InkWell(
                    onTap: (){
                      BottomModals.sortingModal(context: context );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      height: 32.h,
                      width: 77.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Newest',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.lightTextBlack
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.lightTextBlack,)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            IndexedStack(index: current, children: [
              Column(
                children: [
                  SizedBox(height: 20.h,),
                  FutureBuilder<List<Products>>(
                    future: productProvider.products,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container(
                          height: 230,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Center(
                            child: Shimmer.fromColors(
                              direction: ShimmerDirection.ltr,
                              period: const Duration(seconds: 10),
                              baseColor: AppColors.greyLight,
                              highlightColor: AppColors.primaryColor,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
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
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      } else if (snapshot.data!.isNotEmpty) {
                        // final products = snapshot.data!;
                        return Column(
                          children: [
                            GridView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 7,
                                crossAxisSpacing: 7,
                                childAspectRatio: 0.80,
                              ),
                              itemBuilder: (context, index) {
                                Products product = snapshot.data![index];
                                return ListingsGrideView(
                                    newProducts: product
                                );
                              },
                            )],
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
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              const Text(
                                "No products found",
                                style: TextStyle(
                                    fontSize: 14, color: AppColors.black),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              //---water----//

              //---Waste----//

            ]),


          ],
        ),),
      )),
    );
  }
}
