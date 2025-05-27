import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saleko/app/home/products/selectedProduct.dart';
import 'package:saleko/app/widgets/see_all_product.dart';
import 'package:saleko/providers/provider.dart';
import 'package:saleko/app/widgets/search_box.dart';
import 'package:saleko/providers/product_provider.dart';
import 'package:saleko/services/navigation/navigator_service.dart';
import 'package:saleko/utils/app_colors.dart';
import '../../models/CategoriesModel.dart';
import '../../providers/account_provider.dart';
import '../../utils/assets_manager.dart';

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
  // final ScrollController _scrollController = ScrollController();
  // int _selectedIndex = 0;
  // List<CategoriesModel> categoryList = [];

  //This converts the future list to a usable list
  // convertUsable() async {
  //    categoryList = await categories!;
  //  }

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

  // Sorry this is a rush work, I will be commenting step by step for easy understanding
  //
  // //This updates the index of the button and also scrolls there
  // void _updateSelectedIndex(int index) async {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  //   ref.read(currentIndexProvider.state).state = index;
  //   ref.read(selectedCategoryProductChildrenProvider.state).state =
  //       categoryList[index].children;
  //
  //   _scrollToIndex(index);
  // }
  //
  // // This scrolls to exactly where you searching or selected
  // void _scrollToIndex(int index) {
  //   double offset = index * 150;
  //   _scrollController.animateTo(
  //     offset,
  //     duration: Duration(milliseconds: 300),
  //     curve: Curves.easeInOut,
  //   );
  // }
  //
  // //This makes it moves to the next item when the arrow is clicked
  // void _scrollForward() {
  //   int nextIndex = _selectedIndex + 1;
  //   if (nextIndex < categoryList.length) {
  //     _updateSelectedIndex(nextIndex);
  //   }
  // }
  //
  // List<CategoriesModel> _filteredItems = [];
  //
  // //This is to load the first item by default
  // void _loadFirstCategory() async {
  //   List<CategoriesModel> categoryList = await productProvider.categories!;
  //   _filteredItems = categoryList;
  //   if (categoryList.isNotEmpty) {
  //     setState(() {
  //       ref.read(selectedCategoryProductChildrenProvider.state).state =
  //           categoryList.first.children;
  //     });
  //   }
  // }
  //
  // // This is the search functionality
  // void _filterItems(String searchText) async {
  //   List<CategoriesModel> categoryList = await productProvider.categories!;
  //
  //   setState(() {
  //     _filteredItems = categoryList
  //         .where((item) => (item.name ?? "")
  //             .toLowerCase()
  //             .contains(searchText.toLowerCase()))
  //         .toList();
  //     setState(() {
  //       if (_filteredItems.isNotEmpty) {
  //         int selectedIndex = categoryList.indexOf(_filteredItems.first);
  //         ref.watch(currentIndexProvider.state).state = selectedIndex;
  //         ref.read(selectedCategoryProductChildrenProvider.state).state =
  //             _filteredItems.first.children;
  //         _updateSelectedIndex(selectedIndex);
  //         _scrollToIndex(selectedIndex);
  //       }
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    productProvider = ref.watch(RiverpodProvider.productProvider);
    accountProvider = ref.watch(RiverpodProvider.accountProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: 20.h),
                SearchBox(
                  controller: searchController,

                  hint: 'Search categories',
                  onChanged: (v) {
                    productProvider.filterItems(v, productProvider.scrollController );
                  },
                ),
                SizedBox(height: 20.h),
                FutureBuilder<List<CategoriesModel>>(
                  future: productProvider.categories,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error loading categories"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text("No categories found"));
                    }
                    List<CategoriesModel> categories = snapshot.data!;

                    return Container(
                      padding: EdgeInsets.only(left: 10),
                      height: 48.h,
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              controller: productProvider.scrollController,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children:
                                    List.generate(productProvider.categoryList.length, (index) {
                                  bool isActive = index == productProvider.selectedIndex;
                                  return GestureDetector(
                                    onTap: () => {productProvider.updateSelectedIndex(index),
                                    searchController.clear(),},
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 7),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: productProvider.selectedChildren.isEmpty
                                            ? Colors.transparent
                                            : (isActive ? AppColors.primaryColor : Colors.transparent),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        productProvider.categoryList[index].name ?? '',
                                        style: TextStyle(
                                          color: productProvider.selectedChildren.isEmpty
                                              ? AppColors.primaryColor
                                              : (isActive ? Colors.white : AppColors.primaryColor),

                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                                color: Colors.white),
                            child: IconButton(
                              onPressed: productProvider.scrollForward,
                              icon: Icon(
                                Icons.arrow_forward,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 20.h),
              //  SeeAllProduct(navigation: _navigation),
                SizedBox(height: 20.h),
                productProvider.selectedChildren.isEmpty ?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 80.h),
                    Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        "Searched Category currently not found,\nKindly use the Category Slider below the search bar",
                        style: TextStyle( fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                )
                    : Consumer(
                  builder: (context, ref, child) {
                    // final selectedChildren =
                    //     ref.watch(selectedCategoryProductChildrenProvider);
                    final selectedChildren = productProvider.selectedChildren;

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: selectedChildren.length ?? 0,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 1,
                        childAspectRatio: 0.6,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            final products = await productProvider
                                .getProductLoading(selectedChildren[index].name ?? '');
                            if (products != null) {
                              productProvider.pushToAllScreen(
                                selectedChildren[index].name?? '',
                                products,
                              );
                            }
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 80.h,
                                width: 80.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.blueGrey.withOpacity(0.05),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      selectedChildren[index].image ?? '',
                                  imageBuilder: (context, imageProvider) =>
                                      ClipRRect(
                                    borderRadius: BorderRadius.circular(15.r),
                                    child: Container(
                                      height: 115,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => Center(
                                    child: SizedBox(
                                      width: 30.w,
                                      height: 30.h,
                                      child: const CircularProgressIndicator(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => ClipRRect(
                                    borderRadius: BorderRadius.circular(15.r),
                                    child: Image.asset(
                                      Assets.laptopPowerbank,
                                      height: 115,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                selectedChildren[index].name ?? "",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.blackTextColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
