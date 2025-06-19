import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:te_find/models/CartModel.dart';
import 'package:te_find/models/CategoriesModel.dart';
import 'package:te_find/models/MarketListModel.dart';
import 'package:te_find/models/Products.dart';
import 'package:te_find/models/WishListModel.dart';
import 'package:te_find/models/brandListModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:te_find/models/util_model.dart';
import 'package:te_find/providers/provider.dart';
import 'package:te_find/repository/product_repository.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/services/navigation/route_names.dart';
import 'package:te_find/utils/assets_manager.dart';
import 'package:te_find/utils/base_model.dart';
import 'package:te_find/utils/enums.dart';
import 'package:te_find/utils/helpers.dart';
import '../models/BestSellerModel.dart';
import '../models/categoryByHierachy.dart';
import '../models/gender_category_model.dart';

class ProductProvider extends BaseModel {
  final Ref reader;
  ProductProvider.init({
    required this.reader,
  });

  final _productRepository = ProductRepository();
  Future<List<MarketListModel>>? market;
  Future<List<BrandListModel>>? brand;
  Future<List<CategoriesModel>>? categories;
  Future<List<Products>>? products;
  Future<List<Products>>? newProducts;
  List<Products> negotiableProduct = [];
  List<Products>? discountedProduct = [];
  List<WishListModel>? wishListProduct = [];
  Future<List<Products>>? fashionProduct;
  Future<List<Products>>? electronicProducts;
  Future<List<Products>>? searchProduct;
  Future<List<Products>>? selectedProduct;
  Future<List<Products>>? marketProduct;
  Future<List<Products>>? productBySeller;
  Future<List<BestSellerModel>>? bestSeller;

  //Pagination

  LoadingState _loadingState = LoadingState.idle;

  LoadingState get loadingState => _loadingState;

  LoadingState _fetchState = LoadingState.idle;

  LoadingState get fetchState => _fetchState;

  int _nextPage = 1;

  int get nextPage => _nextPage;
  int? _orderCount = 1;

  int? get orderCount => _orderCount;

  List<Products>? get allProduct => _allProduct;
  List<Products>? _allProduct;

  List<Items>? get offlineCart => _offlineCart;
  List<Items>? _offlineCart;

  List<MarketListModel>? _packageList;

  List<MarketListModel>? get packageList => _packageList;

  CartModel? _cartModel;

  CartModel? get cartModel => _cartModel;

  NavigatorService _navigation = NavigatorService();

  setLoadingState(LoadingState value) {
    _loadingState = value;
    notifyListeners();
  }

  setFetchState(LoadingState value) {
    _fetchState = value;
    notifyListeners();
  }

  final ScrollController scrollController = ScrollController();

  // Changes made start's here for the provider
  convertUsable() async {
    categoryList = await categories ?? [];
  }

  List<CategoriesModel> categoryList = [];
  int selectedIndex = 0;
  List<CategoriesModel> filteredItems = [];
  List<Children> selectedChildren = [];

  Future<void> loadFirstCategory() async {
    categories = productCategory();
    final categoryListData = await categories!;
    categoryList = categoryListData;
    if (categoryList.isNotEmpty) {
      selectedChildren = categoryList.first.children!;
    }
    notifyListeners();
  }

  String? idFetch;

  pushToAllScreen(String header, List<Products> products, {String? id}) {
    idFetch = id;
    _nextPage = 1;
    _allProduct = products;
    _nextPage = _nextPage + 1;
    notifyListeners();
    setLoadingState(LoadingState.done);
    notifyListeners();
    _navigation.navigateTo(viewAllProducts, arguments: header);
  }

  productSellerLoad(List<Products> products, {String? id}) {
    idFetch = id;
    _nextPage = 1;
    _allProduct = products;
    _nextPage = _nextPage + 1;
    notifyListeners();
    setLoadingState(LoadingState.done);
    notifyListeners();
  }

  paginateAllScreen(
    dynamic type,
    ScrollController? controller,
  ) async {
    if (controller!.position.extentAfter < 100 &&
        fetchState != LoadingState.loading) {
      setFetchState(LoadingState.loading);
      late HTTPResponseModel res;
      if (type == 'New Products') {
        res = await _productRepository.newProduct(page: _nextPage);
      } else if (type == 'Featured Products') {
        res = await _productRepository.getProduct(page: _nextPage);
      } else if (type == 'Market') {
        res = await _productRepository.fetchProductByMarket(idFetch,
            page: _nextPage);
      } else if (type == 'Product Seller') {
        res = await _productRepository.fetchProductBySeller(idFetch,
            page: _nextPage);
      } else {
        res = await _productRepository.getFashionProduct(type, page: _nextPage);
      }

      if (HTTPResponseModel.isApiCallSuccess(res)) {
        List<Products>? packageList = List<Products>.from(
            res.data['products'].map((item) => Products.fromJson(item)));
        _allProduct?.addAll(packageList);
        _nextPage = _nextPage + 1;
        notifyListeners();
        setFetchState(LoadingState.done);
        return res.data;
      } else {
        setFetchState(LoadingState.error);
        notifyListeners();
        throw Exception('Failed to load internet');
        //return ErrorModel(result.error);
      }
    }
  }

  //This updates the index of the button and also scrolls there
  void updateSelectedIndex(int index) {
    selectedIndex = index;
    selectedChildren = categoryList[index].children!;

    notifyListeners();
  }

  // This scrolls to exactly where you searching or selected
  void scrollToIndex(ScrollController scrollController, int index) {
    double offset = index * 150;
    scrollController.animateTo(
      offset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // This makes it moves to the next item when the arrow is clicked
  void scrollForward() {
    int nextIndex = selectedIndex + 1;
    if (nextIndex < categoryList.length) {
      updateSelectedIndex(nextIndex);
      scrollToIndex(scrollController, nextIndex);
    }
  }

  // This is the search functionality
  void filterItems(String searchText, ScrollController scrollController) {
    // Filter categories
    filteredItems = categoryList
        .where((item) =>
            (item.name ?? "").toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    if (filteredItems.isNotEmpty) {
      selectedIndex = categoryList.indexOf(filteredItems.first);
      updateSelectedIndex(selectedIndex);
      selectedChildren = categoryList[selectedIndex].children!;
      scrollToIndex(scrollController, selectedIndex);
    } else {
      // Clear selectedChildren when no matching category is found
      selectedChildren = [];
    }
    notifyListeners();
  }

  List<MarketListModel> filteredMarketList = [];
  void filterMarketItems(String searchText) {
    if (_packageList == null || _packageList!.isEmpty) {
      filteredMarketList = [];
    } else if (searchText.trim().isEmpty) {
      filteredMarketList = [];
    } else {
      filteredMarketList = _packageList!
          .where((market) => (market.name ?? "")
              .toLowerCase()
              .contains(searchText.toLowerCase()))
          .toList();
      notifyListeners();
    }
  }
  // void filterMarketItems(String searchText) {
  //   final query = searchText.trim().toLowerCase();
  //   if (_packageList == null || _packageList!.isEmpty || query.isEmpty) {
  //     filteredMarketList = [];
  //   } else {
  //     filteredMarketList = _packageList!
  //         .where((market) =>
  //         (market.name ?? "").toLowerCase().contains(query))
  //         .toList();
  //   }
  //   notifyListeners();
  // }

// changes ends here

  CategoryByGender? GenderbyCategory;
  List<CategoryByGender> _categoryByGender = [];
  List<CategoryByGender> get categoryGender => _categoryByGender;
  setGenderByCategories(List<CategoryByGender> gender) {
    _categoryByGender = gender;
    notifyListeners();
  }

  getGenderCategories() async {
    HTTPResponseModel res = await _productRepository.getGenderCategories();
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      print(res);
      List<CategoryByGender> categoryGender = List<CategoryByGender>.from(
          res.data.map((item) => CategoryByGender.fromJson(item)));
      notifyListeners();
      setGenderByCategories(categoryGender);
      return categoryGender;
    } else {
      setFetchState(LoadingState.error);
      notifyListeners();
      throw Exception('Failed to load internet');
      //return ErrorModel(result.error);
    }
    //}
    // }
  }

  CategoryGender? selectedGender;
  Category? selectedCategory;
  SubCategory? selectedSubCategory;

  List<CategoryGender> _genderData = [];

  List<CategoryGender> get genderData => _genderData;

  void setGenderData(List<CategoryGender> data) {
    _genderData = data;
    notifyListeners();
  }

  void selectGender(CategoryGender gender) {
    selectedGender = gender;
    selectedCategory = null;
    selectedSubCategory = null;
    notifyListeners();
  }

  void selectCategory(Category category) {
    selectedCategory = category;
    selectedSubCategory = null;
    notifyListeners();
  }

  void selectSubCategory(SubCategory sub) {
    selectedSubCategory = sub;
    notifyListeners();
  }

  List<Category> get category => selectedGender?.categories ?? [];
  List<SubCategory> get subcategories => selectedCategory?.subcategories ?? [];
  Future<List<CategoryGender>> getCategoriesByHierarchy() async {
    try {
      final HTTPResponseModel res =
          await _productRepository.categoryByHirachy();

      if (HTTPResponseModel.isApiCallSuccess(res)) {
        final List<CategoryGender> genderCategoryList =
            List<CategoryGender>.from(
          res.data.map((item) => CategoryGender.fromJson(item)),
        );
        setGenderData(genderCategoryList);
        return genderCategoryList;
      } else {
        throw Exception('Failed to load category hierarchy');
      }
    } catch (e) {
      setFetchState(LoadingState.error); // Optional
      rethrow;
    }
  }

  Future<List<MultipartFile>> prepareMultipleFiles(List<File> images) async {
    List<MultipartFile> multiPartFiles = [];

    for (var file in images) {
      String fileName = file.path.split('/').last;
      multiPartFiles.add(
        await MultipartFile.fromFile(
          file.path,
          filename: fileName,
          contentType: MediaType('image', 'jpeg'),
        ),
      );
    }

    return multiPartFiles;
  }

  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productAmountInStockController =
      TextEditingController();
  String? selectedColor;
  createProductListings(List<File> images) async {
    setBusy(true);
    try {
      List<MultipartFile> multiPartFiles = await prepareMultipleFiles(images);
      HTTPResponseModel result =
          await _productRepository.createProductListings({
        "images": multiPartFiles,
        // await MultipartFile.fromFile(
        //   dp!,
        //   filename: dpName,
        //   contentType: mimeType,
        // ),
        "name": productNameController.text,
        "gender": selectedGender?.id,
        "description": productDescriptionController.text,
        "color": 'Pink',
        "price": double.tryParse(productPriceController.text
                .replaceAll(RegExp(r'[^\d.]'), '')) ??
            0.0,

        "category": selectedCategory?.id,
        "subCategory": selectedSubCategory?.id,
        "size": 'S',
        "condition": selectedSubCategory?.id,
        "stock": productAmountInStockController.text,
      });
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        showToast(message: result.all['message']);
        print(result.all);
        getProducts();
        _navigation.navigateReplacementTo(bottomNavigationRoute);
        notifyListeners();
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  bool isEditMode = false;
  Future<void> updateProductListing({
    required String productId,
    required List<File> images,
  }) async {
    try {
      setBusy(true);
      List<MultipartFile> multiPartFiles = await prepareMultipleFiles(images);
      final response = await _productRepository.updateProduct({
        "name": productNameController.text,
        "description": productDescriptionController.text,
        "gender": selectedGender?.id,
        "color": selectedColor,
        "price": productPriceController.text,
        "category": selectedCategory?.id,
        "sub_category": selectedSubCategory?.id,
        "condition": selectedSubCategory?.id,
        "size": selectedSubCategory?.id,
        "stock": productAmountInStockController.text,
        "images": multiPartFiles,
      });

      if (HTTPResponseModel.isApiCallSuccess(response)) {
        showToast(message: "Product updated successfully");
      } else {
        showErrorToast(message: response.all['message']);
      }
    } catch (e) {
      showErrorToast(message: e.toString());
    } finally {
      setBusy(false);
    }
  }

  //
  // Future<void> loadProductImagesForEditing(Products product) async {
  //   try {
  //     setBusy(true);
  //
  //     // Activate edit mode and store product model
  //     editListing = true;
  //     editProductsModel = Products.fromJson(product.toJson());
  //
  //     // Clear previously selected images
  //     selectedImages.clear();
  //     notifyListeners();
  //
  //     final tempDir = await getTemporaryDirectory();
  //     List<File> downloadedFiles = [];
  //
  //     // Iterate over photo URLs
  //     for (String url in product.photos!.map((item) => item.path!).toList()) {
  //       try {
  //         final fileName = basename(url);
  //         final file = File('${tempDir.path}/$fileName');
  //
  //         // Download image using Dio
  //         await dio.download(url, file.path);
  //
  //         downloadedFiles.add(file);
  //       } catch (e) {
  //         print('❌ Failed to download $url: $e');
  //       }
  //     }
  //
  //     if (downloadedFiles.isNotEmpty) {
  //       selectedImages.addAll(downloadedFiles);
  //       notifyListeners();
  //     }
  //
  //     // Navigate to the create/edit listing page
  //     _navigatorService.navigateTo(ProductListingRoute);
  //   } catch (e) {
  //     print('❌ Error in loadProductImagesForEditing: $e');
  //   } finally {
  //     setBusy(false);
  //   }
  // }
  //

  Future<List<BrandListModel>> fetchBrand() async {
    HTTPResponseModel res = await _productRepository.fetchBrand();
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      List<BrandListModel> brandList = List<BrandListModel>.from(
          res.data.map((item) => BrandListModel.fromJson(item)));
      return brandList;
    } else {
      return [];
    }
  }

  Future<List<CategoriesModel>> productCategory() async {
    HTTPResponseModel res = await _productRepository.productCategory();
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      List<CategoriesModel> categories = List<CategoriesModel>.from(
          res.data.map((item) => CategoriesModel.fromJson(item)));
      return categories;
    } else {
      return [];
    }
  }

  Future<List<Products>> getProducts() async {
    HTTPResponseModel res = await _productRepository.getProduct();
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      List<Products> getProductList =
          List<Products>.from(res.data.map((item) => Products.fromJson(item)));
      notifyListeners();
      return getProductList;
    } else {
      return [];
    }
  }

  Future<List<Products>> getNewProduct() async {
    HTTPResponseModel res = await _productRepository.newProduct();
    // print("Response Body: ${res.all}");
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      List<Products> newProductList = List<Products>.from(
          res.data['products'].map((item) => Products.fromJson(item)));
      notifyListeners();
      return newProductList;
    } else {
      return [];
    }
  }

  Future<List<Products>> getNegotiableProduct() async {
    HTTPResponseModel res = await _productRepository.getNegotiableP();
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      List<Products> negotiableProductList = List<Products>.from(
          res.data['products'].map((item) => Products.fromJson(item)));
      notifyListeners();
      return negotiableProductList;
    } else {
      return [];
    }
  }

  Future<List<Products>> getDiscountedProduct() async {
    HTTPResponseModel res = await _productRepository.getDiscountedP();
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      List<Products> negotiableProductList =
          List<Products>.from(res.data.map((item) => Products.fromJson(item)));
      notifyListeners();
      return negotiableProductList;
    } else {
      return [];
    }
  }

  Future<List<BestSellerModel>> getTopSeller() async {
    HTTPResponseModel res = await _productRepository.getTopSeller();
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      List<BestSellerModel> bestSellerProduct = List<BestSellerModel>.from(
          res.data.map((item) => BestSellerModel.fromJson(item)));
      notifyListeners();
      return bestSellerProduct;
    } else {
      return [];
    }
  }

  getWishList() async {
    HTTPResponseModel res = await _productRepository.getWishList();
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      List<WishListModel> wishList = List<WishListModel>.from(
          res.data.map((item) => WishListModel.fromJson(item)));
      notifyListeners();
      return wishList;
    } else {
      return [];
    }
  }

  Future<List<Products>> searchP(String query) async {
    HTTPResponseModel res = await _productRepository.searchProduct(query);
    print("Response Body: ${res.all}");

    if (HTTPResponseModel.isApiCallSuccess(res)) {
      List<Products> searchProductList = List<Products>.from(
        res.data['products'].map((item) => Products.fromJson(item)),
      );
      notifyListeners(); // Notify listeners if you're using ChangeNotifier
      return searchProductList;
    } else {
      return [];
    }
  }

  Future<List<Products>> selectedCategoryProducts(String categoryName) async {
    HTTPResponseModel res =
        await _productRepository.fetchSelectedCategory(categoryName);
    print("Response Body: ${res.all}");
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      List<Products> selectedCatgoryProducts = List<Products>.from(
        res.data['products'].map((item) => Products.fromJson(item)),
      );
      notifyListeners();
      return selectedCatgoryProducts;
    } else {
      return [];
    }
  }

  Future<List<Products>> selectedMarketProduct(String? marketID) async {
    HTTPResponseModel res =
        await _productRepository.fetchProductByMarket(marketID);
    print("Response Body: ${res.all}");
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      List<Products> selectedMatketProducts = List<Products>.from(
        res.data['products'].map((item) => Products.fromJson(item)),
      );
      //   _allProduct?.addAll(selectedMatketProducts);
      notifyListeners();
      return selectedMatketProducts;
    } else {
      return [];
    }
  }

  Future<List<Products>> getFashionProduct(String productType) async {
    HTTPResponseModel res =
        await _productRepository.getFashionProduct(productType);
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      List<Products> fashionProductList = List<Products>.from(
          res.data['products'].map((item) => Products.fromJson(item)));
      notifyListeners();
      return fashionProductList;
    } else {
      return [];
    }
  }

  Future<List<Products>> getProductLoading(String productType) async {
    setBusy(true);
    HTTPResponseModel res =
        await _productRepository.getFashionProduct(productType);
    setBusy(false);
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      List<Products> fashionProductList = List<Products>.from(
          res.data['products'].map((item) => Products.fromJson(item)));
      notifyListeners();
      return fashionProductList;
    } else {
      return [];
    }
  }

  Future<List<Products>> selectedProductBySeller(dynamic merchantID) async {
    HTTPResponseModel res =
        await _productRepository.fetchProductBySeller(merchantID);
    print("Response Body: ${res.all}");
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      List<Products> selectedMarketProducts = List<Products>.from(
        res.data['products'].map((item) => Products.fromJson(item)),
      );
      _allProduct?.addAll(selectedMarketProducts);
      notifyListeners();
      return selectedMarketProducts;
    } else {
      return [];
    }
  }

  setMyBrand() async {
    if (brand == null) {
      brand = fetchBrand();
      notifyListeners();
    }
  }

  setMyCategories() async {
    if (categories == null) {
      categories = productCategory();
      notifyListeners();
    }
  }

  setMyProduct() async {
    if (products == null) {
      products = getProducts();
      notifyListeners();
    }
  }

  setMyNewProduct() async {
    try {
      newProducts = getNewProduct();
      notifyListeners();
    } catch (e) {
      print(e);
      notifyListeners();
    }
  }

  setMyNegotiableProduct() async {
    try {
      negotiableProduct = await getNegotiableProduct();
      notifyListeners();
    } catch (e) {
      print(e);
      notifyListeners();
    }
  }

  setMyDiscountedProduct() async {
    try {
      discountedProduct = await getDiscountedProduct();
      notifyListeners();
    } catch (e) {
      print(e);
      notifyListeners();
    }
  }

  setMyFashionProduct() async {
    if (fashionProduct == null) {
      fashionProduct = getFashionProduct("Fashion");
      notifyListeners();
    }
  }

  setMyElectronicProduct() async {
    if (electronicProducts == null) {
      electronicProducts = getFashionProduct("Electronic");
      notifyListeners();
    }
  }

  setMySearchProduct(String query) async {
    try {
      searchProduct = searchP(query);
      notifyListeners();
    } catch (e) {
      print(e);
      notifyListeners();
    }
  }

  setMySelectedProduct(String categoryName) async {
    try {
      selectedProduct = selectedCategoryProducts(categoryName);
      notifyListeners();
    } catch (e) {
      print(e);
      notifyListeners();
    }
  }

  setMyMarketProduct(String marketID) async {
    try {
      marketProduct = selectedMarketProduct(marketID);
      notifyListeners();
    } catch (e) {
      print(e);
      notifyListeners();
    }
  }

  setMyProductByMerchant(dynamic merchantID) async {
    try {
      productBySeller = selectedProductBySeller(merchantID);
      notifyListeners();
    } catch (e) {
      print(e);
      notifyListeners();
    }
  }

  setMyTopBestSeller() async {
    try {
      bestSeller = getTopSeller();
      notifyListeners();
    } catch (e) {
      print(e);
      notifyListeners();
    }
  }

  setMyWishList() async {
    try {
      wishListProduct = await getWishList();
      notifyListeners();
    } catch (e) {
      print(e);
      notifyListeners();
    }
  }

  addWishlist(
    num productId,
  ) async {
    HTTPResponseModel res =
        await _productRepository.addWishlist(productId: productId);
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      return res.data;
    } else {
      showErrorToast(message: res.message);
    }
  }

  loopCartToAuth() async {
    if (reader.read(RiverpodProvider.accountProvider).currentUser.id == null) {
      fetchCart();
    } else {
      print(offlineCart);
      if (_offlineCart!.isNotEmpty) {
        for (final item in _offlineCart!) {
          await addToCart(item.sku ?? '', item.quantity ?? 0);
        }
        //offlineCart.clear();
        // fetchCart();
      } else {
        fetchCart();
      }
    }
  }

  addToCart(
    String sku,
    num quantity,
  ) async {
    late HTTPResponseModel res;
    if (reader.read(RiverpodProvider.accountProvider).currentUser.id != null) {
      res = await _productRepository.addToCart(sku: sku, quantity: quantity);
    } else {
      res = await _productRepository.addToCartGuest(
          sku: sku,
          quantity: quantity,
          guestId: reader.read(RiverpodProvider.accountProvider).guestId);
    }

    if (HTTPResponseModel.isApiCallSuccess(res)) {
      showToast(
          message: "Cart Successfully Updated",
          title: "Add to cart",
          icon: SvgPicture.asset(Assets.shopping_cart));
      fetchCart();
      return res.data;
    } else {
      showErrorToast(message: res.message);
    }
  }

  removeFromCart({
    var productId = 0,
    num cartId = 0,
    num cartItemId = 0,
  }) async {
    late HTTPResponseModel res;
    if (reader.read(RiverpodProvider.accountProvider).currentUser.id != null) {
      res = await _productRepository.removeFromCart(
          id: productId, cartId: cartId, cartItemId: cartItemId);
    } else {
      res = await _productRepository.removeFromCartGuest(
          id: productId,
          guestId: reader.read(RiverpodProvider.accountProvider).guestId);
    }
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      showToast(
          message: "Item removed successfully",
          title: "Remove from cart",
          icon: SvgPicture.asset(Assets.shopping_cart));

      fetchCart();
      notifyListeners();
      return res.data;
    } else {
      showErrorToast(message: res.message);
    }
  }

  updateCart({
    var productId = 0,
    num cartId = 0,
    num quantity = 0,
  }) async {
    late HTTPResponseModel res;
    if (reader.read(RiverpodProvider.accountProvider).currentUser.id != null) {
      res = await _productRepository.updateCart(
          id: productId, cartId: cartId, quantity: quantity);
    } else {
      res = await _productRepository.updateCartGuest(
          id: productId,
          // cartId: cartId,
          quantity: quantity,
          guestId: reader.read(RiverpodProvider.accountProvider).guestId);
    }
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      fetchCart();
      notifyListeners();
      return res.data;
    } else {
      showErrorToast(
          message: res.message, icon: SvgPicture.asset(Assets.shopping_cart));
    }
  }

  fetchCart() async {
    late HTTPResponseModel res;
    if (reader.read(RiverpodProvider.accountProvider).currentUser.id != null) {
      res = await _productRepository.fetchCart();
    } else {
      res = await _productRepository.fetchCartGuest(
          id: reader.read(RiverpodProvider.accountProvider).guestId);
    }
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      if (reader.read(RiverpodProvider.accountProvider).currentUser.id !=
          null) {
        _cartModel = CartModel.fromJson(res.data);
      } else {
        List<Items> items = List<Items>.from(
            res.data['cart_items'].map((item) => Items.fromJson(item)));
        _cartModel = CartModel(data: [Data(items: items)]);

        _offlineCart = items;
      }
      notifyListeners();

      return res.data;
    } else {
      showErrorToast(message: res.message);
    }
  }
}
