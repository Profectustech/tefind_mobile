import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/app/home/widgets/categoryTile.dart';
import 'package:te_find/app/home/widgets/product_gridview.dart';
import 'package:te_find/app/widgets/bottom_modals.dart';
import 'package:te_find/providers/provider.dart';
import 'package:te_find/services/navigation/route_names.dart';
import 'package:te_find/utils/assets_manager.dart';
import 'package:te_find/utils/progress_bar_manager/utility_app_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:te_find/app/widgets/search_box.dart';
import 'package:te_find/providers/product_provider.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/progress_bar_manager/appbar.dart';

import '../../providers/account_provider.dart';

// Create a provider to manage the current page index
final currentIndexProvider = StateProvider<int>((ref) => 0);

class TopDealFashion extends ConsumerStatefulWidget {
  TopDealFashion({super.key});

  @override
  ConsumerState<TopDealFashion> createState() => _HomePageState();
  final NavigatorService _navigation = NavigatorService();
}

class _HomePageState extends ConsumerState<TopDealFashion> {
  late AccountProvider accountProvider;
  final NavigatorService _navigation = NavigatorService();
  //navigation
  void signUp() {
    _navigation.navigateTo(signupScreenRoute);
  }

  int selectedOption = 0;

  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return Scaffold(
        appBar: UtilityAppBar(
          centerTitle: false,
          text: "Women's",
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 20.h),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                    // height: 26,
                    // width: 64,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      spacing: 4,
                      children: [
                        Text('Latest',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            )),
                        Icon(
                          Icons.keyboard_arrow_down_outlined,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    spacing: 8.w,
                    children: [
                      InkWell(
                        onTap: (){
                          BottomModals.propertyFilter(context: context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 5.h),
                          // height: 26,
                          // width: 64,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16)),
                          child: Row(
                            spacing: 4,
                            children: [
                              Icon(
                                Icons.filter_list,
                                size: 15,
                              ),
                              Text('Filter',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(child: SvgPicture.asset('assets/images/window.svg', height: 17.h,),)
                          ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
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
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TopDealFashion()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
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
                                    border: Border.all(
                                        width: 1, color: AppColors.greyLight)),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              "Tops",
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
              ),
              SizedBox(
                height: 20.h,
              ),
              // Text('Featured Collections',
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //       fontSize: 16,
              //       fontWeight: FontWeight.w600,
              //     )),
              // SizedBox(height: 20.h,),
              //     Container(
              //       padding: EdgeInsets.symmetric(
              //           horizontal: 10.h, vertical: 10.h),
              //       width: double.infinity,
              //       height: 160.h,
              //       decoration: BoxDecoration(
              //         color: AppColors.white,
              //         borderRadius: BorderRadius.circular(16.r),
              //         image: DecorationImage(
              //           image: AssetImage(
              //               'assets/images/cloth.png'),
              //           fit: BoxFit.cover,
              //         ),),
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.end,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           SizedBox(
              //             height: 15.h,
              //           ),
              //           Text(
              //             "Summer Essentials",
              //             overflow: TextOverflow.ellipsis,
              //             style: GoogleFonts.roboto(
              //                 fontSize: 14.sp,
              //                 fontWeight: FontWeight.w500,
              //                 color: AppColors.white
              //             ),
              //           ),
              //           SizedBox(
              //             height: 5.h,
              //           ),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Text(
              //                 "245 items",
              //                 overflow: TextOverflow.ellipsis,
              //                 style: GoogleFonts.roboto(
              //                     fontSize: 12.sp,
              //                     fontWeight: FontWeight.w400,
              //                     color: AppColors.grey
              //                 ),
              //               ),
              //               Container(
              //                 padding:
              //                 EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
              //                 decoration: BoxDecoration(
              //                     color: AppColors.white,
              //                     borderRadius: BorderRadius.circular(28.r)),
              //                 child: Text(
              //                   "Shop now",
              //                   overflow: TextOverflow.ellipsis,
              //                   style: GoogleFonts.roboto(
              //                       fontSize: 12.sp,
              //                       fontWeight: FontWeight.w400,
              //                       color: AppColors.black),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ),SizedBox(height: 20.h,),
              //     Container(
              //       padding: EdgeInsets.symmetric(
              //           horizontal: 10.h, vertical: 10.h),
              //       width: double.infinity,
              //       height: 160.h,
              //       decoration: BoxDecoration(
              //         color: AppColors.white,
              //         borderRadius: BorderRadius.circular(16.r),
              //         image: DecorationImage(
              //           image: AssetImage(
              //               'assets/images/cloth.png'),
              //           fit: BoxFit.cover,
              //         ),),
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.end,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           SizedBox(
              //             height: 15.h,
              //           ),
              //           Text(
              //             "Office Edit",
              //             overflow: TextOverflow.ellipsis,
              //             style: GoogleFonts.roboto(
              //                 fontSize: 14.sp,
              //                 fontWeight: FontWeight.w500,
              //                 color: AppColors.white
              //             ),
              //           ),
              //           SizedBox(
              //             height: 5.h,
              //           ),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Text(
              //                 "245 items",
              //                 overflow: TextOverflow.ellipsis,
              //                 style: GoogleFonts.roboto(
              //                     fontSize: 12.sp,
              //                     fontWeight: FontWeight.w400,
              //                     color: AppColors.grey
              //                 ),
              //               ),
              //               Container(
              //                 padding:
              //                 EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
              //                 decoration: BoxDecoration(
              //                     color: AppColors.white,
              //                     borderRadius: BorderRadius.circular(28.r)),
              //                 child: Text(
              //                   "Shop now",
              //                   overflow: TextOverflow.ellipsis,
              //                   style: GoogleFonts.roboto(
              //                       fontSize: 12.sp,
              //                       fontWeight: FontWeight.w400,
              //                       color: AppColors.black),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text('Trending Now',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(height: 20.h,),
                  Container(
                    height: 276.h,
                    width: double.infinity,
                 //   240.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.white),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 192.h,
                              //    width: 240.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(26),
                                    topRight: Radius.circular(26)),
                                color: AppColors.primaryColor,
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/bag.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Mango",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors
                                            .grey),
                                  ),
                                  SizedBox(height: 5.h),
                                  Text(
                                    "Luxury Leather Handbag",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors
                                            .blackTextColor),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text(
                                        "₦45,000",
                                        overflow:
                                        TextOverflow.ellipsis,
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            fontWeight:
                                            FontWeight.w600,),
                                      ),
                                      Row(
                                        spacing: 4.w,
                                        children: [
                                          Icon(Icons.star, color: Colors.yellow,),
                                          Text(
                                            "4",
                                            overflow: TextOverflow
                                                .ellipsis,
                                            style:
                                            GoogleFonts.roboto(
                                              fontSize: 12,
                                              fontWeight:
                                              FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                          ],
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: []),
                            child: Center(
                              child: Icon(
                                Icons.favorite_border_outlined,
                              ),
                            ),
                          ),
                        ),
                        // Positioned(
                        //   bottom: 110.h,
                        //   left: 0,
                        //   right: 0,
                        //   child: Container(
                        //     height: 40.h,
                        //     decoration: BoxDecoration(
                        //       color: AppColors.black.withOpacity(0.7),
                        //     ),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Icon(Icons.add, color: Colors.white, size: 16),
                        //         SizedBox(width: 6.w),
                        //         Text(
                        //           "Add to Cart",
                        //           style: GoogleFonts.roboto(
                        //             fontSize: 12,
                        //             fontWeight: FontWeight.w500,
                        //             color: Colors.white,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),

                      ],
                    ),
                  ),
              SizedBox(height: 20.h,),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                // padding: EdgeInsets.only(left: 20),
                scrollDirection: Axis.vertical,
                itemCount: 8,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 9,
                    crossAxisSpacing: 6,
                    childAspectRatio: 0.72),
                itemBuilder: (context, index) {
                  // return ProductGridview();
                },
              ),
            ]),
          )),
        ));
  }
}
