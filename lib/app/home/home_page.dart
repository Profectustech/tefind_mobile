import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saleko/app/home/widgets/categoryTile.dart';
import 'package:saleko/app/home/widgets/category_grid.dart';
import 'package:saleko/app/home/widgets/product_gridview.dart';
import 'package:saleko/models/Products.dart';
import 'package:saleko/models/product.dart';
import 'package:saleko/providers/provider.dart';
import 'package:saleko/services/navigation/route_names.dart';
import 'package:saleko/utils/assets_manager.dart';
import 'package:saleko/utils/helpers.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:saleko/app/widgets/search_box.dart';
import 'package:saleko/providers/product_provider.dart';
import 'package:saleko/services/navigation/navigator_service.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:saleko/utils/progress_bar_manager/appbar.dart';
import '../../models/BestSellerModel.dart';
import '../../models/CategoriesModel.dart';
import '../../providers/account_provider.dart';
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
      appBar: CustomAppBar(
          displayBack: false,
          centerTitle: false,
          text: accountProvider.currentUser.email == null ? 'Sign In' : "",
          onTap: () {
            if (accountProvider.currentUser.email == null) {
              signUp();
            }
          }),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 10,
                ),
                child: SearchBox(
                  controller: _searchController,
                  hint: 'What are you looking for',
                  onChanged: (query) {
                    debounce(const Duration(milliseconds: 500), () {
                      productProvider.setMySearchProduct(query);
                    });
                    // setState(() {});
                  },
                ),
              ),
              _searchController.text.isNotEmpty
                  ? FutureBuilder<List<Products>>(
                      future: productProvider.searchProduct,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.data!.isNotEmpty) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                return ProductGridview(newProducts: product);
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
                      children: [
                        accountProvider.bannerList?.isNotEmpty ?? false
                            ? CarouselSlider.builder(
                                options: CarouselOptions(
                                  enlargeFactor: 0.5,
                                  autoPlay: true,
                                  height: 152.82.h,
                                  viewportFraction: 1,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  autoPlayAnimationDuration:
                                      Duration(milliseconds: 500),
                                  autoPlayInterval: Duration(seconds: 2),
                                  enlargeCenterPage: true,
                                  aspectRatio: 16 / 10,
                                  onPageChanged: (index, reason) {
                                    ref
                                        .read(currentIndexProvider.notifier)
                                        .state = index;
                                  },
                                ),
                                itemCount:
                                    accountProvider.bannerList?.length ?? 0,
                                itemBuilder: (BuildContext context,
                                        int itemIndex, int pageViewIndex) =>
                                    ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.r)),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fitWidth,
                                    width: double.infinity,
                                    height: 152.82.h,
                                    imageUrl: accountProvider
                                            .bannerList?[itemIndex].imageUrl ??
                                        '',
                                    placeholder: (context, url) => const Center(
                                        child: SizedBox(
                                      height: 30,
                                    )),
                                    errorWidget: (context, url, error) =>
                                        const Center(child: Icon(Icons.error)),
                                  ),
                                ),
                              )
                            : Container(),
                        if (accountProvider.bannerList != null)
                          AnimatedSmoothIndicator(
                            activeIndex: currentPageIndex,
                            count: accountProvider.bannerList?.length ?? 0,
                            effect: ExpandingDotsEffect(
                              spacing: 4.0,
                              dotWidth: 8.0,
                              dotHeight: 7.0,
                              strokeWidth: 8,
                              dotColor: AppColors.grey,
                              activeDotColor: AppColors.primaryColor,
                            ),
                          ),
                        SizedBox(height: 20),
                        FutureBuilder<List<CategoriesModel>>(
                          future: productProvider.categories,
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
                                    child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        mainAxisSpacing: 12,
                                        crossAxisSpacing: 6,
                                        childAspectRatio: 0.90,
                                      ),
                                      itemCount: 8,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
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
                                        );
                                      },
                                    ),
                                  )));
                            } else if (snapshot.data!.isNotEmpty) {
                              return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  // i removed Expanded because i have an error of Incorrect use of ParentDataWidget
                                  child: GridView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: snapshot.data!.length > 8
                                        ? 8
                                        : snapshot.data!.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      mainAxisSpacing: 9,
                                      crossAxisSpacing: 6,
                                      childAspectRatio: 0.65,
                                    ),
                                    itemBuilder: (context, index) {
                                      CategoriesModel categories =
                                          snapshot.data![index];
                                      return CategoryItem(
                                          categories: categories);
                                    },
                                  ));
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
                                    "There is no Categories available",
                                    style: TextStyle(
                                        fontSize: 14, color: AppColors.black),
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
                        Column(
                          children: [
                            if (productProvider.negotiableProduct != null &&
                                productProvider
                                    .negotiableProduct.isNotEmpty) ...[
                              CategoryTile(
                                navigation: _navigation,
                                title: "Negotiation",
                                showViewAll: true,
                                onTap: () {
                                  productProvider.pushToAllScreen(
                                    'Negotiable Products',
                                    productProvider.negotiableProduct,
                                  );
                                },
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 241.h,
                                child: ListView.builder(
                                  padding: EdgeInsets.only(left: 20),
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      productProvider.negotiableProduct!.length,
                                  itemBuilder: (context, index) {
                                    Products negotiableProducts =
                                        productProvider
                                            .negotiableProduct![index];
                                    return ProductGridview(
                                      newProducts: negotiableProducts,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                            ],
                            SizedBox(
                              height: 16.h,
                            ),
                            if (productProvider.discountedProduct != null &&
                                productProvider
                                    .discountedProduct!.isNotEmpty) ...[
                              CategoryTile(
                                navigation: _navigation,
                                title: "Discounted Products",
                                showViewAll: true,
                                onTap: () {
                                  productProvider.pushToAllScreen(
                                    'Discounted Products',
                                    productProvider.discountedProduct ?? [],
                                  );
                                },
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 241.h,
                                child: ListView.builder(
                                  padding: EdgeInsets.only(left: 20),
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      productProvider.discountedProduct!.length,
                                  itemBuilder: (context, index) {
                                    Products discountedProducts =
                                        productProvider
                                            .discountedProduct![index];
                                    return ProductGridview(
                                      newProducts: discountedProducts,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                            ],
                            FutureBuilder<List<Products>>(
                              future: productProvider.newProducts,
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
                                      ),
                                    ),
                                  );
                                } else if (snapshot.hasData &&
                                    snapshot.data!.isNotEmpty) {
                                  final products = snapshot.data!;
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CategoryTile(
                                        navigation: _navigation,
                                        title: "New Products",
                                        showViewAll: true,
                                        onTap: () {
                                          productProvider.pushToAllScreen(
                                            'New Products',
                                            products,
                                          );
                                        },
                                        arguments: products,
                                      ),
                                      SizedBox(height: 10.h),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 241.h,
                                        child: ListView.builder(
                                          padding: EdgeInsets.only(left: 20),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: snapshot.data!.length > 8
                                              ? 8
                                              : snapshot.data!.length,
                                          itemBuilder: (context, index) {
                                            return ProductGridview(
                                              newProducts: products[index],
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                } else if (snapshot.hasError) {
                                  return const Center(
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(height: 100),
                                        Text(
                                          'Network error',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text('Please try again later'),
                                        SizedBox(height: 100),
                                      ],
                                    ),
                                  );
                                } else {
                                  return const Center(
                                    child: Column(
                                      children: [
                                        SizedBox(height: 50),
                                        Text(
                                          "There is no product available",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.black,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 30),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            FutureBuilder<List<Products>>(
                              future: productProvider.fProducts,
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
                                  final products = snapshot.data!;
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CategoryTile(
                                        navigation: _navigation,
                                        title: "Featured Products",
                                        showViewAll: true,
                                        onTap: () {
                                          productProvider.pushToAllScreen(
                                            'Featured Products',
                                            products,
                                          );
                                        },
                                        arguments: products,
                                      ),
                                      SizedBox(height: 10.h),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 241.h,
                                        child: ListView.builder(
                                          padding: EdgeInsets.only(left: 20),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: snapshot.data!.length > 8
                                              ? 8
                                              : snapshot.data!.length,
                                          itemBuilder: (context, index) {
                                            return ProductGridview(
                                              newProducts: products[index],
                                            );
                                          },
                                        ),
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
                            SizedBox(height: 10),
                            FutureBuilder<List<Products>>(
                              future: productProvider.fashionProduct,
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
                                  final fashionProducts = snapshot.data!;
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CategoryTile(
                                        navigation: _navigation,
                                        title: "Fashion",
                                        showViewAll: true,
                                        onTap: () {
                                          productProvider.pushToAllScreen(
                                            'Fashion',
                                            fashionProducts,
                                          );
                                        },
                                        arguments: fashionProducts,
                                      ),
                                      SizedBox(height: 10.h),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 241.h,
                                        child: ListView.builder(
                                          padding: EdgeInsets.only(left: 20),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: fashionProducts.length > 8
                                              ? 8
                                              : snapshot.data!.length,
                                          //   itemCount: fashionProducts.length,
                                          itemBuilder: (context, index) {
                                            return ProductGridview(
                                              newProducts:
                                                  fashionProducts[index],
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                  //   SizedBox(
                                  //   width: double.infinity,
                                  //   height: 241.h,
                                  //   child: ListView.builder(
                                  //     padding: EdgeInsets.only(left: 20),
                                  //     scrollDirection: Axis.horizontal,
                                  //     itemCount: snapshot.data!.length,
                                  //     itemBuilder: (context, index) {
                                  //       Products fashionProduct =
                                  //       snapshot.data![index];
                                  //       return ProductGridview(
                                  //         newProducts: fashionProduct,
                                  //       );
                                  //     },
                                  //   ),
                                  // );
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
                            SizedBox(height: 10),
                            FutureBuilder<List<Products>>(
                              future: productProvider.electronicProducts,
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
                                  final electronicProduct = snapshot.data!;
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CategoryTile(
                                        navigation: _navigation,
                                        title: "Electronics",
                                        showViewAll: true,
                                        onTap: () {
                                          productProvider.pushToAllScreen(
                                            'Electronics',
                                            electronicProduct,
                                          );
                                        },
                                        arguments: electronicProduct,
                                      ),
                                      SizedBox(height: 10.h),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 241.h,
                                        child: ListView.builder(
                                          padding: EdgeInsets.only(left: 20),
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              electronicProduct.length > 8
                                                  ? 8
                                                  : snapshot.data!.length,
                                          itemBuilder: (context, index) {
                                            return ProductGridview(
                                              newProducts:
                                                  electronicProduct[index],
                                            );
                                          },
                                        ),
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
                            SizedBox(height: 10),
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
                                      CategoryTile(
                                        navigation: _navigation,
                                        title: "Top Seller",
                                        showViewAll: true,
                                        onTap: () {
                                          _navigation.navigateTo(
                                              sellersPageScreenRoute,
                                              arguments: bestseller);
                                        },
                                        // arguments: electronicProduct,
                                      ),
                                      SizedBox(height: 10.h),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 250.h,
                                        child: ListView.builder(
                                          padding: EdgeInsets.only(left: 20),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: bestseller.length > 8
                                              ? 8
                                              : snapshot.data!.length,
                                          itemBuilder: (context, index) {
                                            return TopSellerGride(
                                              newProducts: bestseller[index],
                                            );
                                          },
                                        ),
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
                            SizedBox(
                              height: 50.h,
                            ),
                          ],
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
