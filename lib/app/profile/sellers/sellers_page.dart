import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saleko/app/home/market/seller_filter.dart';
import 'package:saleko/app/profile/sellers/sellers_option.dart';
import 'package:saleko/app/widgets/search_box.dart';
import 'package:saleko/providers/product_provider.dart';
import 'package:saleko/providers/provider.dart';
import 'package:saleko/utils/assets_manager.dart';
import 'package:saleko/utils/progress_bar_manager/utility_app_bar.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/BestSellerModel.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/screen_size.dart';
import '../../home/filter_page.dart';
import '../../widgets/custom_bottom_sheet.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/top_seller_gride.dart';

class SellersPage extends ConsumerStatefulWidget {
  const SellersPage({super.key,});

  @override
  ConsumerState createState() => _SellersPageState();
}
final selectedSortBYProvider = StateProvider<String>((ref) => '');
 late ProductProvider productProvider;
class _SellersPageState extends ConsumerState<SellersPage> {
  @override
  Widget build(BuildContext context) {
    final paymentOption = ref.watch(selectedSortBYProvider);
    productProvider = ref.watch(RiverpodProvider.productProvider);
    return Scaffold(
      appBar: UtilityAppBar(
        text: "Sellers",
      ),
      body: Stack(
        children: [SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  height: 100.78.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13.7.r),
                    image: DecorationImage(
                        image: AssetImage(Assets.sellerContainer)),
                  ),
                  child: Text(
                    "Explore amazing\n stores close to you",
                    style: TextStyle(fontSize: 19.2, fontWeight: FontWeight.w700, color: AppColors.white),
                  ),
                ),
                // SizedBox(height: 20.h,),
                // SearchBox(hint: "Search for product or sellers"),
                SizedBox(height: 20.h,),
                FutureBuilder<List<BestSellerModel>>(
                  future: productProvider.bestSeller,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                          height: 230,
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20),
                          child: Center(
                              child: Shimmer.fromColors(
                                direction: ShimmerDirection.ltr,
                                period: const Duration(seconds: 10),
                                baseColor: AppColors.greyLight,
                                highlightColor: AppColors.primaryColor,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 8,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                      const EdgeInsets.all(8.0),
                                      child: Container(
                                        padding:
                                        const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(
                                              10.0),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                              )));
                    } else if (snapshot.data!.isNotEmpty) {
                      final bestseller = snapshot.data!;
                      return Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: bestseller.length,
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8.0,
                                childAspectRatio: 0.9
                            ),
                            itemBuilder: (context, index) {
                              return StoreCard(
                                sellerProduct:  bestseller[index],

                              );

                            },
                          ),
                        ],
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
                                "There is no product available",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.black),
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



                // GridView.builder(
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   itemCount: widget.sellerProduct?.length,
                //   gridDelegate:
                //   const SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 2,
                //     mainAxisSpacing: 8,
                //     crossAxisSpacing: 8.0,
                //       childAspectRatio: 0.9
                //
                //   ),
                //   itemBuilder: (context, index) {
                //     return StoreCard();
                //
                //   },
                // ),

              ],
            ),

          ),
        ),
          // Positioned(
          //     bottom: Responsive.height(context) * 0.02,
          //     left: 0,
          //     right: 0,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         GestureDetector(
          //           onTap: () {
          //             CustomBottomSheet.show(
          //               context: context,
          //               isDismissible: true,
          //               child: Padding(
          //                 padding: const EdgeInsets.symmetric(
          //                     horizontal: 20.0, vertical: 10.0),
          //                 child: Column(
          //                   children: [
          //                     Row(
          //                       mainAxisAlignment:
          //                       MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         Text(
          //                           "Sort By ",
          //                           style:
          //                           TextStyle(fontWeight: FontWeight.w600),
          //                         ),
          //                         IconButton(
          //                             onPressed: () {
          //                               Navigator.pop(context);
          //                             },
          //                             icon: Icon(Icons.close))
          //                       ],
          //                     ),
          //
          //                     Divider(),
          //                     SizedBox(
          //                       height: 10.0.h,
          //                     ),
          //                     GestureDetector(
          //                       onTap: () {
          //                         ref
          //                             .read(selectedSortBYProvider
          //                             .notifier)
          //                             .state = 'Low';
          //                       },
          //                       child: Row(
          //                         crossAxisAlignment:
          //                         CrossAxisAlignment.start,
          //                         children: [
          //
          //                           Text(
          //                             "Price: Low to High",
          //                             style: TextStyle(
          //                                 fontSize: 18,
          //                                 fontWeight:
          //                                 FontWeight.w600,
          //                                 color: AppColors.black),
          //                           ),
          //
          //                           Spacer(),
          //                           Radio<String>(
          //                             activeColor:
          //                             AppColors.primaryColor,
          //                             value: 'Low',
          //                             groupValue: paymentOption,
          //                             onChanged: (value) {
          //                               ref
          //                                   .read(
          //                                   selectedSortBYProvider
          //                                       .notifier)
          //                                   .state = value!;
          //                               Navigator.pop(context);
          //                             },
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                     SizedBox(height: 10.h,),
          //                     GestureDetector(
          //                       onTap: () {
          //                         ref
          //                             .read(selectedSortBYProvider
          //                             .notifier)
          //                             .state = 'High';
          //                       },
          //                       child: Row(
          //                         crossAxisAlignment:
          //                         CrossAxisAlignment.start,
          //                         children: [
          //
          //                           Text(
          //                             "Price: High to low",
          //                             style: TextStyle(
          //                                 fontSize: 18,
          //                                 fontWeight:
          //                                 FontWeight.w600,
          //                                 color: AppColors.black),
          //                           ),
          //
          //                           Spacer(),
          //                           Radio<String>(
          //                             activeColor:
          //                             AppColors.primaryColor,
          //                             value: 'High',
          //                             groupValue: paymentOption,
          //                             onChanged: (value) {
          //                               ref
          //                                   .read(
          //                                   selectedSortBYProvider
          //                                       .notifier)
          //                                   .state = value!;
          //                               Navigator.pop(context);
          //                             },
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                     SizedBox(
          //                       height: 10.0.h,
          //                     ),
          //                     GestureDetector(
          //                       onTap: () {
          //                         ref
          //                             .read(selectedSortBYProvider
          //                             .notifier)
          //                             .state = 'A-Z';
          //                       },
          //                       child: Row(
          //                         crossAxisAlignment:
          //                         CrossAxisAlignment.start,
          //                         children: [
          //
          //                           Text(
          //                             "From A-Z",
          //                             style: TextStyle(
          //                                 fontSize: 18,
          //                                 fontWeight:
          //                                 FontWeight.w600,
          //                                 color: AppColors.black),
          //                           ),
          //
          //                           Spacer(),
          //                           Radio<String>(
          //                             activeColor:
          //                             AppColors.primaryColor,
          //                             value: 'A-Z',
          //                             groupValue: paymentOption,
          //                             onChanged: (value) {
          //                               ref
          //                                   .read(
          //                                   selectedSortBYProvider
          //                                       .notifier)
          //                                   .state = value!;
          //                               Navigator.pop(context);
          //                             },
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                     SizedBox(height: 10.h,),
          //                     GestureDetector(
          //                       onTap: () {
          //                         ref
          //                             .read(selectedSortBYProvider
          //                             .notifier)
          //                             .state = 'Z-A';
          //                       },
          //                       child: Row(
          //                         crossAxisAlignment:
          //                         CrossAxisAlignment.start,
          //                         children: [
          //
          //                           Text(
          //                             "From Z-A",
          //                             style: TextStyle(
          //                                 fontSize: 18,
          //                                 fontWeight:
          //                                 FontWeight.w600,
          //                                 color: AppColors.black),
          //                           ),
          //
          //                           Spacer(),
          //                           Radio<String>(
          //                             activeColor:
          //                             AppColors.primaryColor,
          //                             value: 'Z-A',
          //                             groupValue: paymentOption,
          //                             onChanged: (value) {
          //                               ref
          //                                   .read(
          //                                   selectedSortBYProvider
          //                                       .notifier)
          //                                   .state = value!;
          //                               Navigator.pop(context);
          //                             },
          //                           ),
          //                         ],
          //                       ),
          //                     ),SizedBox(
          //                       height: 10.0.h,
          //                     ),
          //                     GestureDetector(
          //                       onTap: () {
          //                         ref
          //                             .read(selectedSortBYProvider
          //                             .notifier)
          //                             .state = 'Newest Release';
          //                       },
          //                       child: Row(
          //                         crossAxisAlignment:
          //                         CrossAxisAlignment.start,
          //                         children: [
          //
          //                           Text(
          //                             "Newest Releases",
          //                             style: TextStyle(
          //                                 fontSize: 18,
          //                                 fontWeight:
          //                                 FontWeight.w600,
          //                                 color: AppColors.black),
          //                           ),
          //
          //                           Spacer(),
          //                           Radio<String>(
          //                             activeColor:
          //                             AppColors.primaryColor,
          //                             value: 'Newest Release',
          //                             groupValue: paymentOption,
          //                             onChanged: (value) {
          //                               ref
          //                                   .read(
          //                                   selectedSortBYProvider
          //                                       .notifier)
          //                                   .state = value!;
          //                               Navigator.pop(context);
          //                             },
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                     SizedBox(height: 10.h,),
          //                     GestureDetector(
          //                       onTap: () {
          //                         ref
          //                             .read(selectedSortBYProvider
          //                             .notifier)
          //                             .state = 'Popularity';
          //                       },
          //                       child: Row(
          //                         crossAxisAlignment:
          //                         CrossAxisAlignment.start,
          //                         children: [
          //
          //                           Text(
          //                             "Popularity",
          //                             style: TextStyle(
          //                                 fontSize: 18,
          //                                 fontWeight:
          //                                 FontWeight.w600,
          //                                 color: AppColors.black),
          //                           ),
          //
          //                           Spacer(),
          //                           Radio<String>(
          //                             activeColor:
          //                             AppColors.primaryColor,
          //                             value: 'Popularity',
          //                             groupValue: paymentOption,
          //                             onChanged: (value) {
          //                               ref
          //                                   .read(
          //                                   selectedSortBYProvider
          //                                       .notifier)
          //                                   .state = value!;
          //                               Navigator.pop(context);
          //                             },
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                     SizedBox(height: 10.h,),
          //                     CustomButton(
          //                         label: "Done",
          //                         fillColor: AppColors.primaryColor,
          //                         onPressed: (){Navigator.pop(context);}),
          //                     SizedBox(height: 20.h,),
          //
          //                   ],
          //
          //
          //                 ),
          //               ),
          //             );
          //           },
          //           child: Container(
          //             padding:
          //             EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          //             decoration: BoxDecoration(
          //               color: AppColors.primaryColor,
          //               border: Border.all(color: AppColors.primaryColor),
          //               borderRadius: BorderRadius.circular(8),
          //             ),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Text(
          //                   "Sort By",
          //                   style: TextStyle(
          //                     fontSize: 14,
          //                     color: AppColors.white,
          //                     fontWeight: FontWeight.w600,
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   width: 8,
          //                 ),
          //                 SvgPicture.asset(Assets.sortBy),
          //
          //                 // Icon(Icons.arrow_upward, color: AppColors.white, size: 18,),
          //                 // Icon(Icons.arrow_downward, color: AppColors.white, size: 18,)
          //               ],
          //             ),
          //           ),
          //         ),
          //         SizedBox(
          //           width: Responsive.height(context) * 0.01,
          //         ),
          //         GestureDetector(
          //           onTap: (){ Navigator.pushReplacement(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => SellerFilter(),
          //             ),
          //           );},
          //           child: Container(
          //             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          //             decoration: BoxDecoration(
          //               color: AppColors.primaryColor,
          //               border: Border.all(color: AppColors.primaryColor),
          //               borderRadius: BorderRadius.circular(8),
          //             ),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Text(
          //                   "Filter",
          //                   style: TextStyle(
          //                     fontSize: 14,
          //                     color: AppColors.white,
          //                     fontWeight: FontWeight.w600,
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   width: 8,
          //                 ),
          //                 SvgPicture.asset(Assets.filter),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ],
          //     ))
      ],
      ),

    );
  }
}
