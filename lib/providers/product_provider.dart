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

class ProductProvider extends BaseModel {
  final Ref reader;
  ProductProvider.init({
    required this.reader,
  });

  final _productRepository = ProductRepository();
  Future<List<MarketListModel>>? market;
  Future<List<BrandListModel>>? brand;
  Future<List<CategoriesModel>>? categories;
  Future<List<Products>>? fProducts;
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
        res = await _productRepository.fProduct(page: _nextPage);
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
          .where((market) =>
          (market.name ?? "")
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

  Future<List<MarketListModel>> fetchMarket() async {
    if (packageList == null) {
      _nextPage = 1;
      notifyListeners();
      setLoadingState(LoadingState.loading);
      HTTPResponseModel res = await _productRepository.fetchMarket();
      if (HTTPResponseModel.isApiCallSuccess(res)) {
        List<MarketListModel> productList = List<MarketListModel>.from(
            res.data.map((item) => MarketListModel.fromJson(item)));
        _packageList = productList;
        _nextPage = _nextPage + 1;
        notifyListeners();
        setLoadingState(LoadingState.done);
        //_orderCount = res.all['pagination']["totalItems"];
        return productList;
      } else {
        setLoadingState(LoadingState.error);
        notifyListeners();
        return [];
      }
    }
    return [];
  }

  fetchMoreMarket() async {
    // if (controller!.position.extentAfter < 100 &&
    //     fetchState != LoadingState.loading) {
    // if (packageList.length >= orderCount!) {
    //   // showToast('all order History fetched');
    // } else

    // {
    setFetchState(LoadingState.loading);
    HTTPResponseModel res =
        await _productRepository.fetchMarket(page: _nextPage);
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      List<MarketListModel> packageList = List<MarketListModel>.from(
          res.data.map((item) => MarketListModel.fromJson(item)));
      _packageList?.addAll(packageList);
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
    //}
    // }
  }

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

  Future<List<Products>> fetchFProduct() async {
    HTTPResponseModel res = await _productRepository.fProduct();
    if (HTTPResponseModel.isApiCallSuccess(res)) {
      List<Products> featureProductList = List<Products>.from(
          res.data['products'].map((item) => Products.fromJson(item)));
      notifyListeners();
      return featureProductList;
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

  setMyMarket() async {
    if (market == null) {
      market = fetchMarket();
      notifyListeners();
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

  setMyFeatureProduct() async {
    //  if (fProducts == null) {
    fProducts = fetchFProduct();
    notifyListeners();
    // }
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
    if (reader.read(RiverpodProvider.accountProvider).currentUser.id ==
        null) {
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
    if (reader.read(RiverpodProvider.accountProvider).currentUser.id !=
        null) {
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
    if (reader.read(RiverpodProvider.accountProvider).currentUser.id !=
        null) {
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
    if (reader.read(RiverpodProvider.accountProvider).currentUser.id !=
        null) {
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
    if (reader.read(RiverpodProvider.accountProvider).currentUser.id !=
        null) {
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

//-----------------------------------
// List<Product> allProducts = [
//   Product(
//       title: "Fashion",
//       imagePath: 'assets/images/basket.png',
//       destinationPage: fashionScreenRoute),
//   Product(
//       title: "Electronic",
//       imagePath: 'assets/images/laptop.png',
//       destinationPage: fashionScreenRoute),
//   Product(
//       title: "Phones",
//       imagePath: 'assets/images/laptop.png',
//       destinationPage: fashionScreenRoute),
//   Product(
//       title: "Computers",
//       imagePath: 'assets/images/laptop.png',
//       destinationPage: fashionScreenRoute),
//   Product(
//       title: "Babies",
//       imagePath: 'assets/images/laptop.png',
//       destinationPage: fashionScreenRoute),
//   Product(
//       title: "Sports",
//       imagePath: 'assets/images/laptop.png',
//       destinationPage: fashionScreenRoute),
//   Product(
//       title: "Autopart",
//       imagePath: 'assets/images/ipad.png',
//       destinationPage: fashionScreenRoute),
//   Product(
//       title: "Gaming",
//       imagePath: 'assets/images/ipad.png',
//       destinationPage: fashionScreenRoute),
// ];

// final productsProvider = Provider((ref) {
//   return allProducts;
// });

// for wallet transaction page
class Transaction {
  final String statusType;
  final String price;
  final String assetImage;

  Transaction({
    required this.statusType,
    required this.price,
    required this.assetImage,
  });
}

final transactionProvider =
    StateNotifierProvider<TransactionNotifier, List<Transaction>>(
  (ref) => TransactionNotifier(),
);

class TransactionNotifier extends StateNotifier<List<Transaction>> {
  TransactionNotifier()
      : super([
          // i will replace with actual transction
          Transaction(
              statusType: "Fund Wallet",
              price: "+ ₦100,200",
              assetImage: Assets.fundTransaction),
          Transaction(
            statusType: "Order Purchase for Iphone",
            price: "- ₦1,200",
            assetImage: Assets.purchaseTransaction,
          ),
          Transaction(
            statusType: "Order Purchase for Iphone",
            price: "- ₦1,200",
            assetImage: Assets.purchaseTransaction,
          ),
          Transaction(
            statusType: "Order Purchase for Iphone",
            price: "- ₦1,200",
            assetImage: Assets.purchaseTransaction,
          ),
        ]);
}
