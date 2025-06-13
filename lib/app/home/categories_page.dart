import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/app/home/products/selectedProduct.dart';
import 'package:te_find/app/home/top_deal_fashion.dart';
import 'package:te_find/app/widgets/see_all_product.dart';
import 'package:te_find/providers/provider.dart';
import 'package:te_find/app/widgets/search_box.dart';
import 'package:te_find/providers/product_provider.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/utils/app_colors.dart';
import '../../models/CategoriesModel.dart';
import '../../providers/account_provider.dart';
import '../../utils/assets_manager.dart';
import '../../utils/progress_bar_manager/appbar.dart';
import '../../utils/progress_bar_manager/utility_app_bar.dart';

// // Create a provider to manage the current page index
// final currentIndexProvider = StateProvider<int>((ref) => 0);
// final selectedCategoryProductChildrenProvider =
//     StateProvider<List<Children>?>((ref) => []);

class CategoriesPage extends ConsumerStatefulWidget {
  CategoriesPage({super.key});

  @override
  ConsumerState<CategoriesPage> createState() => _HomePageState();
}

TextEditingController searchController = TextEditingController();

class _HomePageState extends ConsumerState<CategoriesPage> {
  late AccountProvider accountProvider;
  late ProductProvider productProvider;
  final NavigatorService _navigation = NavigatorService();
  final List<String> tags = [
    '#SummerFashion',
    '#Minimalist',
    '#Vintage',
    '#Streetwear',
    '#Sustainable',
    '#Luxury',
    '#Casual',
    '#Formal',
    '#Athleisure',
    '#Boho',
    '#Handmade',
    '#Designer',
  ];

  @override
  void initState() {
    Future.microtask(() {
      // setState(() {
      //   productProvider.setMyCategories();
      // });
      productProvider.convertUsable();
      productProvider.loadFirstCategory();
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    productProvider = ref.watch(RiverpodProvider.productProvider);
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return Scaffold(
      appBar: UtilityAppBar(
        centerTitle: false,
        text: "Categories",
        hasActions: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Main Categories",
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  height: 120.h,
                  child: ListView.builder(
                    padding: EdgeInsets.only(left: 5),
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      // Products negotiableProducts =
                      // productProvider
                      //     .negotiableProduct![index];
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => TopDealFashion()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                            width: 103.66.w,
                            height: 132.h,
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(16)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onDoubleTap: () {},
                                  child: Container(
                                    height: 64.h,
                                    width: 64.w,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              AssetImage('assets/images/men.png'),
                                          fit: BoxFit.cover,
                                        ),
                                        shape: BoxShape.circle,
                                        color: AppColors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black
                                                  .withValues(alpha: 0.1),
                                              spreadRadius: 0.1,
                                              blurRadius: 0.1,
                                              offset: Offset(0, 1))
                                        ]),
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Text(
                                  "Men's",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "SubCategories",
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20.h),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 9,
                    crossAxisSpacing: 2,
                    childAspectRatio: 0.90,
                  ),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    //  final feed = productProvider.allProduct![index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        width: 103.66.w,
                        height: 132.h,
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onDoubleTap: () {},
                              child: Container(
                                height: 64.h,
                                width: 64.w,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/men.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    shape: BoxShape.circle,
                                    color: AppColors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black
                                              .withValues(alpha: 0.1),
                                          spreadRadius: 0.2,
                                          blurRadius: 0.2,
                                          offset: Offset(0, 2))
                                    ]),
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Text(
                              "Men's",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
            //     Text(
            //       "Popular Tags",
            //       style: GoogleFonts.roboto(
            //         fontSize: 16,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //     SizedBox(height: 20.h),
            // Wrap(
            //   spacing: 10, // space between items
            //   runSpacing: 10, // space between lines
            //   children: tags.map((tag) {
            //     return Container(
            //       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(30),
            //         border: Border.all(color: Colors.grey.shade300),
            //         boxShadow: [
            //           BoxShadow(
            //             color: Colors.black12,
            //             blurRadius: 2,
            //             offset: Offset(0, 1),
            //           )
            //         ],
            //       ),
            //       child: Text(
            //         tag,
            //         style: TextStyle(
            //           fontSize: 12.sp,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //     );
            //   }).toList(),),
            //     SizedBox(height: 20.h),
            //
            //     Text(
            //       "Trending Now",
            //       style: GoogleFonts.roboto(
            //         fontSize: 16,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //     SizedBox(height: 20.h),
            //     GridView.builder(
            //       shrinkWrap: true,
            //       physics: NeverScrollableScrollPhysics(),
            //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 2,
            //         mainAxisSpacing: 9,
            //         crossAxisSpacing: 15,
            //         childAspectRatio: 0.90,
            //       ),
            //       itemCount: 4,
            //       itemBuilder: (context, index) {
            //         //  final feed = productProvider.allProduct![index];
            //         return Container(
            //           padding: EdgeInsets.symmetric(
            //               horizontal: 10.h, vertical: 10.h),
            //           width: 103.66.w,
            //           height: 132.h,
            //           decoration: BoxDecoration(
            //               color: AppColors.white,
            //               borderRadius: BorderRadius.circular(16.r),
            //             image: DecorationImage(
            //               image: AssetImage(
            //                   'assets/images/cloth.png'),
            //               fit: BoxFit.cover,
            //             ),),
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.end,
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               SizedBox(
            //                 height: 15.h,
            //               ),
            //               Text(
            //                 "Sustainable",
            //                 overflow: TextOverflow.ellipsis,
            //                 style: GoogleFonts.roboto(
            //                   fontSize: 14.sp,
            //                   fontWeight: FontWeight.w500,
            //                   color: AppColors.white
            //                 ),
            //               ),
            //               SizedBox(
            //                 height: 5.h,
            //               ),
            //               Text(
            //                 "245 items",
            //                 overflow: TextOverflow.ellipsis,
            //                 style: GoogleFonts.roboto(
            //                   fontSize: 12.sp,
            //                   fontWeight: FontWeight.w400,
            //                   color: AppColors.grey
            //                 ),
            //               ),
            //             ],
            //           ),
            //         );
            //       },
            //     ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
