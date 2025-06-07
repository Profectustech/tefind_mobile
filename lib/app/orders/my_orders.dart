import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/app/bottom_nav/nav_service.dart';
import 'package:te_find/app/home/check_out.dart';
import 'package:te_find/app/home/products/product_detail_fullScreen.dart';
import 'package:te_find/app/widgets/custom_button.dart';
import 'package:te_find/providers/payment_provider.dart';
import 'package:te_find/providers/provider.dart';
import 'package:te_find/services/navigation/route_names.dart';
import 'package:te_find/utils/assets_manager.dart';
import 'package:te_find/utils/helpers.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:te_find/app/widgets/search_box.dart';
import 'package:te_find/providers/product_provider.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/progress_bar_manager/appbar.dart';

import '../../providers/account_provider.dart';
import 'active_order_widget.dart';
import 'new_order_widget.dart';
import 'order_completed_widget.dart';

class MyOrders extends ConsumerStatefulWidget {
  MyOrders({super.key});

  @override
  ConsumerState<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends ConsumerState<MyOrders> {
  late AccountProvider accountProvider;
  late ProductProvider productProvider;
  late PaymentProvider paymentProvider;
  late NavStateProvider navStateProvider;
  final NavigatorService _navigation = NavigatorService();
  List<String> items = [
    "Buyer",
    "Seller",
  ];
  int current = 0;
  void signUp() {
    _navigation.navigateTo(signupScreenRoute);
  }

  @override
  void initState() {
    Future.microtask(() {
      productProvider.loopCartToAuth();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // when the cart provider is set i will use it
    // final cartsProduct = ref.watch(productsProvider);
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    productProvider = ref.watch(RiverpodProvider.productProvider);
    navStateProvider = ref.watch(RiverpodProvider.navStateProvider);
    paymentProvider = ref.watch(RiverpodProvider.paymentProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'My Orders',
          style: GoogleFonts.roboto(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              NavigatorService().navigateTo(notificationPage);
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.2), // corrected method
                        spreadRadius: 0.2,
                        blurRadius: 0.2,
                        offset: Offset(0, 0.2),
                      ),
                    ],
                  ),
                  child: Center(
                    child:
                    SvgPicture.asset(
                      "assets/images/searchIcon.svg",
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
        ],
        centerTitle: false,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 50,
              child: Container(
                height: 44,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.greyLight,
                    borderRadius: BorderRadius.circular(26)),
                child: ListView.builder(
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
                        height: 36.h,
                        // margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding:
                            EdgeInsets.symmetric(horizontal: 60.w, vertical: 0),
                        decoration: BoxDecoration(
                          color: current == index
                              ? AppColors.white
                              : AppColors.greyLight,
                          borderRadius: BorderRadius.circular(26.r),
                        ),
                        child: Center(
                          child: Text(
                            items[index],
                            style: GoogleFonts.roboto(
                              color: current == index
                                  ? Colors.black
                                  : AppColors.lightTextBlack,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            IndexedStack(index: current, children: [
              DefaultTabController(
                length: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: TabBar(
                        padding: EdgeInsets.zero,
                        labelPadding: EdgeInsets.zero,
                        labelStyle: GoogleFonts.roboto(
                            fontSize: 14, fontWeight: FontWeight.w400),
                        labelColor: AppColors.primaryColor,
                        unselectedLabelColor: AppColors.grey,
                        indicatorColor: AppColors.primaryColor,
                        tabs: const [
                          Tab(
                            text: 'Active',
                          ),
                          Tab(text: 'Completed'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 520.h,
                      child: TabBarView(
                        children: [
                          // Tab 1 Content
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 20.h),
                            child: Column(
                              children: [
                                ActiveOrderWidget(),
                              ],
                            ),
                          ),

                          // Completed
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 20.h),
                            child: Column(
                              children: [
                                OrderCompletedWidget(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //---Seller----//
              DefaultTabController(
                length: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: TabBar(
                        padding: EdgeInsets.zero,
                        labelPadding: EdgeInsets.zero,
                        labelStyle: GoogleFonts.roboto(
                            fontSize: 14, fontWeight: FontWeight.w400),
                        labelColor: AppColors.primaryColor,
                        unselectedLabelColor: AppColors.grey,
                        indicatorColor: AppColors.primaryColor,
                        tabs: const [
                          Tab(
                            text: 'New Orders',
                          ),
                          Tab(text: 'Order History'),
                          Tab(text: 'Offers'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 520.h,
                      child: TabBarView(
                        children: [
                          // New Orders
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 20.h),
                            child: Column(
                              children: [
                                // NewOrderWidget(),
                                ActiveOrderWidget(),
                              ],
                            ),
                          ),

                          // Completed
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 20.h),
                            child: Column(
                              children: [
                                ActiveOrderWidget(),
                              ],
                            ),
                          ),

                          // Offers
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 20.h),
                            child: Column(
                              children: [
                                NewOrderWidget(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ]),
        ),
      )),
    );
  }
}
