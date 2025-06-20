import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/app/home/products/featured_product.dart';
import 'package:te_find/app/home/products/learn_more_content.dart';
import 'package:te_find/app/home/widgets/categoryTile.dart';
import 'package:te_find/app/home/widgets/category_grid.dart';
import 'package:te_find/app/home/widgets/featured_product_detail.dart';
import 'package:te_find/app/home/widgets/product_gridview.dart';
import 'package:te_find/models/Products.dart';
import 'package:te_find/providers/provider.dart';
import 'package:te_find/services/navigation/route_names.dart';
import 'package:te_find/utils/assets_manager.dart';
import 'package:te_find/utils/helpers.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:te_find/app/widgets/search_box.dart';
import 'package:te_find/providers/product_provider.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/locator.dart';
import 'package:te_find/utils/progress_bar_manager/appbar.dart';
import '../../models/BestSellerModel.dart';
import '../../models/CategoriesModel.dart';
import '../../providers/account_provider.dart';
import '../../utils/enums.dart';
import '../../utils/helpers.dart' as Responsive;
import '../widgets/loader_widget.dart';
import '../widgets/top_seller_gride.dart';

// Create a provider to manage the current page index
final currentIndexProvider = StateProvider<int>((ref) => 0);

class HomePage extends ConsumerStatefulWidget {
  HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
  final NavigatorService _navigation = NavigatorService();
}

class _HomePageState extends ConsumerState<HomePage> {
  TextEditingController _searchController = TextEditingController();

  late AccountProvider accountProvider;
  late ProductProvider productProvider;
  final NavigatorService _navigation = NavigatorService();
  void signUp() {
    _navigation.navigateTo(signupScreenRoute);
  }

  bool isLoading = false;
  int selectedOption = 0;

  @override
  void initState() {
    super.initState();
    String query = _searchController.text.trim();
    Future.microtask(() {
      if (accountProvider.currentAddress?.state == null ||
          accountProvider.currentAddress?.state == '') {
      //  accountProvider.getUserLocationAndAddress();
         accountProvider.initUserLocation();
        accountProvider.startListeningToLocation();
      }
      accountProvider.getUserProfile();
      productProvider.setMyProduct();

    });
  }

  @override
  Widget build(BuildContext context) {
    productProvider = ref.watch(RiverpodProvider.productProvider);
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    final currentPageIndex = ref.watch(currentIndexProvider);

    return Scaffold(
      // backgroundColor: Color(0xFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.only(bottom: 30, top: 20.h, left: 15.w, right: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          spacing: 5.w,
                          children: [
                            Text('Hello',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                )),
                            Text('${accountProvider.currentUser.name}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text('What do you want to do today 🤗',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            )),
                      ],
                    ),
                    Row(
                      spacing: 8.w,
                      children: [
                        InkWell(
                          onTap: () {
                            accountProvider.initUserLocation();
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
                                      SvgPicture.asset(Assets.notificationIcon),
                                ),
                              ),
                              // Badge positioned at the top right corner
                              Positioned(
                                top: -4,
                                right: -4,
                                child: Container(
                                  padding: EdgeInsets.all(
                                      4), // Padding inside badge circle
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white, width: 1.5),
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 16,
                                    minHeight: 16,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '3',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            NavigatorService().navigateTo(cartPageScreen);
                          },
                          child: Container(
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
                              child: SvgPicture.asset(Assets.cart),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                SearchBox(
                  controller: _searchController,
                  hint: 'Search for Items',
                  onChanged: (query) {
                    debounce(const Duration(milliseconds: 500), () {
                      productProvider.setMySearchProduct(query);
                    });
                    // setState(() {});
                  },
                ),

                _searchController.text.isNotEmpty
                    ? FutureBuilder<List<Products>>(
                        future: productProvider.searchProduct,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Column(
                              children: [
                                SizedBox(height: 40.h,),
                                Center(child: CircularProgressIndicator()),
                              ],
                            );
                          } else if (snapshot.data!.isNotEmpty) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: GridView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot
                                    .data!.length, //snapshot.data!.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 9,
                                  crossAxisSpacing: 6,
                                  childAspectRatio: 0.65,
                                ),
                                itemBuilder: (context, index) {
                                  Products product = snapshot.data![index];
                                  // return ProductGridview(
                                  //     // newProducts: product
                                  //     );
                                },
                              ),
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
                                    "No products found for the search,\nKindly shop through other product",
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
                      )
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text('Featured Items',
                          //         textAlign: TextAlign.center,
                          //         style: TextStyle(
                          //           fontSize: 16,
                          //           fontWeight: FontWeight.w600,
                          //         )),
                          //     Text('View All',
                          //         textAlign: TextAlign.center,
                          //         style: TextStyle(
                          //           fontSize: 14,
                          //           color: AppColors.primaryColor,
                          //           fontWeight: FontWeight.w500,
                          //         )),
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 20.h,
                          // ),
                          // SizedBox(
                          //   width: double.infinity,
                          //   height: 241.h,
                          //   child: ListView.builder(
                          //     padding: EdgeInsets.only(left: 5),
                          //     scrollDirection: Axis.horizontal,
                          //     itemCount: 4,
                          //     itemBuilder: (context, index) {
                          //       // Products negotiableProducts =
                          //       // productProvider
                          //       //     .negotiableProduct![index];
                          //       return FeaturedProductContainer();
                          //     },
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 30.h,
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Categories',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  )),
                              GestureDetector(
                                onTap: () {
                                  NavigatorService().navigateTo(categories);
                                },
                                child: Text('See All',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w500,
                                    )),
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
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Column(
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
                                              color: AppColors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      Text(
                                        "Men's",
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.roboto(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          LearnMoreContent(),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Recent Listings',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  )),
                              Row(
                                spacing: 8.w,
                                children: [
                                  Container(
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
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 5.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: Transform.scale(
                                            scale: 0.7,
                                            child: Radio<int>(
                                              value: 1,
                                              activeColor: AppColors.primaryColor,
                                              materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                              groupValue: selectedOption,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedOption = value!;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          'Sort',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
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
                                        itemCount: 8,
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
                                return GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot
                                      .data!.length, //snapshot.data!.length,
                                  gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                        mainAxisSpacing: 9,
                                        crossAxisSpacing: 6,
                                         childAspectRatio: 0.72,
                                  ),
                                  itemBuilder: (context, index) {
                                    Products product = snapshot.data![index];
                                    return ProductGridview(
                                      newProducts: product
                                    );
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

                          SizedBox(height: 10),
                          // GridView.builder(
                          //   shrinkWrap: true,
                          //   physics: NeverScrollableScrollPhysics(),
                          //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          //     crossAxisCount: 2,
                          //     mainAxisSpacing: 9,
                          //     crossAxisSpacing: 6,
                          //     childAspectRatio: 0.72,
                          //   ),
                          //   itemCount: 8,
                          //   itemBuilder: (context, index) {
                          //     //  final feed = productProvider.allProduct![index];
                          //     return ProductGridview();
                          //   },
                          // ),



                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
