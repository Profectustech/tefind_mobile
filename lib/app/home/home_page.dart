import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/app/home/widgets/categoryTile.dart';
import 'package:te_find/app/home/widgets/category_grid.dart';
import 'package:te_find/app/home/widgets/featured_product_detail.dart';
import 'package:te_find/app/home/widgets/product_gridview.dart';
import 'package:te_find/models/Products.dart';
import 'package:te_find/models/product.dart';
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
      productProvider.loopCartToAuth();
      productProvider.setMyCategories();
      productProvider.setMyNewProduct();
      productProvider.setMyFeatureProduct();
      productProvider.setMyFashionProduct();
      productProvider.setMyElectronicProduct();
      accountProvider.banner();
      productProvider.setMyTopBestSeller();
      // productProvider.setMyNegotiableProduct();
      productProvider.setMyDiscountedProduct();
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
                EdgeInsets.only(bottom: 30, top: 20.h, left: 20.w, right: 20.w),
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
                            Text('Micheal',
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
                        Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.5),
                                    spreadRadius: 0.5,
                                    blurRadius: 0.5,
                                    offset: Offset(0, 0.5))
                              ]),
                          child: Center(
                            child: SvgPicture.asset(Assets.notificationIcon)
                          ),
                        ),
                        Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.5),
                                    spreadRadius: 0.5,
                                    blurRadius: 0.5,
                                    offset: Offset(0, 0.5))
                              ]),
                          child: Center(
                            child: SvgPicture.asset(Assets.cart),
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
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Featured Items',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        )),
                    Text('View All',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 241.h,
                  child: ListView.builder(
                    padding: EdgeInsets.only(left: 5),
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      // Products negotiableProducts =
                      // productProvider
                      //     .negotiableProduct![index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: GestureDetector(
                            onDoubleTap: () {

                            },
                            onTap: (){
                              // NavigatorService().navigateTo(
                              //   productDetailScreenRoute,
                              //   // arguments: widget.newProducts,
                              // );
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => FeaturedProductDetail()));


                            },
                            child:
                                Stack(alignment: Alignment.center, children: [
                              Container(
                                height: 232.h,
                                width: 240.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(26),
                                    color: AppColors.white),
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 160.h,
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
                                                "Luxury Leather Handbag",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors
                                                        .blackTextColor),
                                              ),
                                              SizedBox(height: 8.h),
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
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppColors
                                                            .primaryColor),
                                                  ),
                                                  Row(
                                                    spacing: 4.w,
                                                    children: [
                                                      SvgPicture.asset(
                                                          'assets/images/visibility.svg'),
                                                      Text(
                                                        "124",
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
                                    Positioned(
                                      bottom: 80,
                                      left: 10,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 25.w, vertical: 5.h),
                                        decoration: BoxDecoration(
                                            color: AppColors.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(28.r)),
                                        child: Text(
                                          "New",
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.roboto(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ])),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Categories',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        )),
                    Text('See All',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        )),
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
                CarouselSlider.builder(
                  options: CarouselOptions(
                    enlargeFactor: 0.5,
                    autoPlay: true,
                    height: 152.82.h,
                    viewportFraction: 1,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayAnimationDuration: Duration(milliseconds: 500),
                    autoPlayInterval: Duration(seconds: 2),
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 10,
                    onPageChanged: (index, reason) {
                      ref.read(currentIndexProvider.notifier).state = index;
                    },
                  ),
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          child: Container(
                            color: Colors.red,
                            height: 50.h,
                            width: double.infinity,
                          )),
                ),
                SizedBox(
                  height: 10.h,
                ),
                AnimatedSmoothIndicator(
                  activeIndex: currentPageIndex,
                  count: 3,
                  effect: ScrollingDotsEffect(
                    spacing: 4.0,
                    dotWidth: 8.0,
                    dotHeight: 7.0,
                    strokeWidth: 8,
                    dotColor: AppColors.grey,
                    activeDotColor: AppColors.primaryColor,
                  ),
                ),
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
                    Text('See All',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 9,
                    crossAxisSpacing: 6,
                    childAspectRatio: 0.72,
                  ),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    //  final feed = productProvider.allProduct![index];
                    return ProductGridview();
                  },
                ),
                _searchController.text.isNotEmpty
                    ? FutureBuilder<List<Products>>(
                        future: productProvider.searchProduct,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
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
                                  return ProductGridview(
                                      // newProducts: product
                                      );
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
                        children: [],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
