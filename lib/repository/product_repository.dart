import 'package:te_find/models/util_model.dart';
import 'package:te_find/repository/network_helper.dart';
import 'package:te_find/utils/enums.dart';

class ProductRepository {
  final NetworkHelper _networkHelper = NetworkHelper();

  Future<HTTPResponseModel> getGenderCategories() async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: "category/gender-categories",
    );
  }

  Future<HTTPResponseModel> fetchBrand() async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: "main-svc/attribute/option/brand",
    );
  }

  Future<HTTPResponseModel> productCategory() async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: "main-svc-v2/public/products/categories/tree",
    );
  }

  Future<HTTPResponseModel> fetchSelectedCategory(String categoryName) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: "main-svc-v2/products?category_name=$categoryName",
    );
  }

  Future<HTTPResponseModel> fetchProductByMarket(String? marketId,
      {int? page = 1}) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url:
          "main-svc-v2/public/products/market?market_id=$marketId&per_page=10&page=$page",
    );
  }

  Future<HTTPResponseModel> fetchProductBySeller(String? merchantID,
      {int? page = 1}) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url:
          "main-svc-v2/public/products/market?merchant_id=$merchantID&per_page=10&page=$page ",
    );
  }

  // https://staging.te_find.ng/api/main-svc-v2/public/products/market?market_id=1&per_page=4&page=1

  Future<HTTPResponseModel> fProduct({int? page = 1}) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url:
          "main-svc-v2/public/products/attributes?type=featured&per_page=10&page=1",
      //"product/featured-products?pageSize=5&pageNumber=1&searchValue=&channel=default&locale=en",
    );
  }

  Future<HTTPResponseModel> getTopSeller({int? page = 1}) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: "main-svc-v2/public/products/best-sellers?per_page=5&page=$page",
    );
  }

  Future<HTTPResponseModel> searchProduct(String query) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: "main-svc-v2/public/products?name=$query&per_page=10&page=1",
    );
  }

  Future<HTTPResponseModel> fetchProduct() async {
    //Addition according to display
    // ?category_name=Electronics For Category
    // ?sku=j2bldw For SKU
    // ?type=variants For variants
    // ?type=discounted For discounted
    // ?type=negotiable For negotiable
    // ?name=box For box

    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: "main-svc-v2/public/products?per_page=10&page=1",
    );
  }

  Future<HTTPResponseModel> newProduct({int? page = 1}) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url:
          "main-svc-v2/public/products/attributes?type=new&per_page=10&page=$page",
      //   url: "product/new-products?pageSize=5&pageNumber=1&searchValue=&channel=default&locale=en",
    );
  }

  Future<HTTPResponseModel> getFashionProduct(String productType,
      {int? page = 1}) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url:
          "main-svc-v2/public/products?category_name=$productType&per_page=10&page=$page",
    );
  }

  Future<HTTPResponseModel> getWishList() async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: "main-svc-v2/wishlist",
    );
  }

  Future<HTTPResponseModel> addWishlist({
    num productId = 0,
  }) async {
    return await _networkHelper.runApi(
        type: ApiRequestType.post,
        url: 'main-svc-v2/wishlist',
        body: {"product_id": productId});
  }

  Future<HTTPResponseModel> addToCart({
    String sku = "",
    num quantity = 0,
  }) async {
    return await _networkHelper
        .runApi(type: ApiRequestType.post, url: 'main-svc-v2/cart/add', body: {
      "products": [
        {"sku": sku, "quantity": quantity}
      ]
    });
  }

  Future<HTTPResponseModel> addToCartGuest(
      {String sku = "", num quantity = 0, String guestId = ''}) async {
    return await _networkHelper.runApi(
        type: ApiRequestType.post,
        url: 'main-svc-v2/guest/cart/add',
        body: {
          "products": [
            {"sku": sku, "quantity": quantity}
          ],
          "guest_token": guestId
        });
  }

  Future<HTTPResponseModel> removeFromCart({
    num id = 0,
    num cartId = 0,
    num cartItemId = 0,
  }) async {
    return await _networkHelper.runApi(
        type: ApiRequestType.post,
        url: 'main-svc-v2/cart/delete',
        body: {
          "cart_item_id": cartItemId,
          "cart_id": cartId,
          "product_id": id
        });
  }

  Future<HTTPResponseModel> removeFromCartGuest(
      {var id = 0,
      String guestId = ''}) async {
    return await _networkHelper.runApi(
        type: ApiRequestType.post,
        url: 'main-svc-v2/guest/cart/delete',
        body: {
          "sku": id,
          "guest_token": guestId
        });
  }

  Future<HTTPResponseModel> updateCart({
    num id = 0,
    num cartId = 0,
    num quantity = 0,
  }) async {
    return await _networkHelper.runApi(
        type: ApiRequestType.put,
        url: 'main-svc-v2/cart/update',
        body: {"quantity": quantity, "cart_id": cartId, "product_id": id});
  }

  Future<HTTPResponseModel> updateCartGuest(
      {var id = 0,
      //num cartId = 0,
      num quantity = 0,
      String guestId = ''}) async {
    return await _networkHelper.runApi(
        type: ApiRequestType.put,
        url: 'main-svc-v2/guest/cart/update',
        body: {
          "quantity": quantity,
          "sku": id,
          "guest_token": guestId
        });
  }

  Future<HTTPResponseModel> fetchCart({String id = ""}) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: 'main-svc-v2/cart',
    );
  }

  Future<HTTPResponseModel> fetchCartGuest({String id = ""}) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: 'main-svc-v2/guest/cart/$id',
    );
  }

  //---------//
  Future<HTTPResponseModel> getNegotiableP() async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: "main-svc-v2/products?type=negotiable&per_page=10&page=1",
    );
  }

  Future<HTTPResponseModel> getDiscountedP() async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: "main-svc-v2/public/products?type=discounted&per_page=10&page=1",
    );
  }
}
