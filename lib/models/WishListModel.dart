class WishListModel {
  int? id;
  int? productId;
  String? createdAt;
  Product? product;
  String? stockStatus;
  int? inventoryQty;
  String? productName;
  String? price;
  String? specialPrice;
  List<Variant>? variants;
  List<String>? images;
  List<String>? category;
  Seller? seller;

  WishListModel({
    this.id,
    this.productId,
    this.createdAt,
    this.product,
    this.stockStatus,
    this.inventoryQty,
    this.productName,
    this.price,
    this.specialPrice,
    this.variants,
    this.images,
    this.category,
    this.seller,
  });

  factory WishListModel.fromJson(Map<String, dynamic> json) {
    return WishListModel(
      id: json['id'],
      productId: json['product_id'],
      createdAt: json['created_at'],
      product: json['product'] != null ? Product.fromJson(json['product']) : null,
      stockStatus: json['stock_status'],
      inventoryQty: json['inventory_qty'],
      productName: json['product_name'],
      price: json['price'],
      specialPrice: json['special_price'],
      variants: (json['variants'] as List?)
          ?.map((e) => Variant.fromJson(e))
          .toList(),
      images: (json['images'] as List?)?.cast<String>(),
      category: (json['category'] as List?)?.cast<String>(),
      seller: json['seller'] != null ? Seller.fromJson(json['seller']) : null,
    );
  }
}

class Product {
  int? id;
  String? sku;
  String? type;
  String? createdAt;
  String? updatedAt;
  ProductCategory? productCategory;
  String? brandName;

  Product({
    this.id,
    this.sku,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.productCategory,
    this.brandName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      sku: json['sku'],
      type: json['type'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      productCategory: json['product_category'] != null
          ? ProductCategory.fromJson(json['product_category'])
          : null,
      brandName: json['brand_name'],
    );
  }
}

class ProductCategory {
  String? categoryName;
  String? categoryType;

  ProductCategory({this.categoryName, this.categoryType});

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      categoryName: json['category_name'],
      categoryType: json['category_type'],
    );
  }
}

class Variant {
  String? sku;
  String? name;
  String? price;
  String? specialPrice;
  int? percentageDiscount;
  int? qty;
  String? color;
  String? size;

  Variant({
    this.sku,
    this.name,
    this.price,
    this.specialPrice,
    this.percentageDiscount,
    this.qty,
    this.color,
    this.size,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      sku: json['sku'],
      name: json['name'],
      price: json['price'],
      specialPrice: json['special_price'],
      percentageDiscount: json['percentage_discount'],
      qty: json['qty'],
      color: json['color'],
      size: json['size'],
    );
  }
}

class Seller {
  int? id;
  String? shopTitle;
  String? description;
  String? businessName;

  Seller({
    this.id,
    this.shopTitle,
    this.description,
    this.businessName,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      id: json['id'],
      shopTitle: json['shop_title'],
      description: json['description'],
      businessName: json['business_name'],
    );
  }
}
