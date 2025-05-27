class Products {
  Products({
      String? sku, 
      String? name, 
      String? brandName, 
      num? productId, 
      String? description, 
      String? price, 
      String? specialPrice, 
      dynamic specialPriceFrom, 
      dynamic specialPriceTo, 
      String? categoryName, 
      String? categoryType, 
      String? createdAt, 
      String? updatedAt, 
      dynamic thumbnail, 
      String? weight, 
      num? color, 
      dynamic colorLabel, 
      num? size, 
      dynamic sizeLabel, 
      num? percentageDiscount, 
      bool? promoCountDown, 
      num? qty, 
      List<ImageUrls>? imageUrls, 
      List<dynamic>? variants, 
      Seller? seller,}){
    _sku = sku;
    _name = name;
    _brandName = brandName;
    _productId = productId;
    _description = description;
    _price = price;
    _specialPrice = specialPrice;
    _specialPriceFrom = specialPriceFrom;
    _specialPriceTo = specialPriceTo;
    _categoryName = categoryName;
    _categoryType = categoryType;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _thumbnail = thumbnail;
    _weight = weight;
    _color = color;
    _colorLabel = colorLabel;
    _size = size;
    _sizeLabel = sizeLabel;
    _percentageDiscount = percentageDiscount;
    _promoCountDown = promoCountDown;
    _qty = qty;
    _imageUrls = imageUrls;
    _variants = variants;
    _seller = seller;
}

  Products.fromJson(dynamic json) {
    _sku = json['sku'];
    _name = json['name'];
    _brandName = json['brand_name'];
    _productId = json['product_id'];
    _description = json['description'];
    _price = json['price'];
    _specialPrice = json['special_price'];
    _specialPriceFrom = json['special_price_from'];
    _specialPriceTo = json['special_price_to'];
    _categoryName = json['category_name'];
    _categoryType = json['category_type'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _thumbnail = json['thumbnail'];
    _weight = json['weight'];
    _color = json['color'];
    _colorLabel = json['color_label'];
    _size = json['size'];
    _sizeLabel = json['size_label'];
    _percentageDiscount = json['percentage_discount'];
    _promoCountDown = json['promo_count_down'];
    _qty = json['qty'];
    if (json['image_urls'] != null) {
      _imageUrls = [];
      json['image_urls'].forEach((v) {
        _imageUrls?.add(ImageUrls.fromJson(v));
      });
    }
    if (json['variants'] != null) {
      _variants = [];
      json['variants'].forEach((v) {
     //   _variants?.add(Dynamic.fromJson(v));
      });
    }
    _seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
  }
  String? _sku;
  String? _name;
  String? _brandName;
  num? _productId;
  String? _description;
  String? _price;
  String? _specialPrice;
  dynamic _specialPriceFrom;
  dynamic _specialPriceTo;
  String? _categoryName;
  String? _categoryType;
  String? _createdAt;
  String? _updatedAt;
  dynamic _thumbnail;
  String? _weight;
  num? _color;
  dynamic _colorLabel;
  num? _size;
  dynamic _sizeLabel;
  num? _percentageDiscount;
  bool? _promoCountDown;
  num? _qty;
  List<ImageUrls>? _imageUrls;
  List<dynamic>? _variants;
  Seller? _seller;

  String? get sku => _sku;
  String? get name => _name;
  String? get brandName => _brandName;
  num? get productId => _productId;
  String? get description => _description;
  String? get price => _price;
  String? get specialPrice => _specialPrice;
  dynamic get specialPriceFrom => _specialPriceFrom;
  dynamic get specialPriceTo => _specialPriceTo;
  String? get categoryName => _categoryName;
  String? get categoryType => _categoryType;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get thumbnail => _thumbnail;
  String? get weight => _weight;
  num? get color => _color;
  dynamic get colorLabel => _colorLabel;
  num? get size => _size;
  dynamic get sizeLabel => _sizeLabel;
  num? get percentageDiscount => _percentageDiscount;
  bool? get promoCountDown => _promoCountDown;
  num? get qty => _qty;
  List<ImageUrls>? get imageUrls => _imageUrls;
  List<dynamic>? get variants => _variants;
  Seller? get seller => _seller;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sku'] = _sku;
    map['name'] = _name;
    map['brand_name'] = _brandName;
    map['product_id'] = _productId;
    map['description'] = _description;
    map['price'] = _price;
    map['special_price'] = _specialPrice;
    map['special_price_from'] = _specialPriceFrom;
    map['special_price_to'] = _specialPriceTo;
    map['category_name'] = _categoryName;
    map['category_type'] = _categoryType;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['thumbnail'] = _thumbnail;
    map['weight'] = _weight;
    map['color'] = _color;
    map['color_label'] = _colorLabel;
    map['size'] = _size;
    map['size_label'] = _sizeLabel;
    map['percentage_discount'] = _percentageDiscount;
    map['promo_count_down'] = _promoCountDown;
    map['qty'] = _qty;
    if (_imageUrls != null) {
      map['image_urls'] = _imageUrls?.map((v) => v.toJson()).toList();
    }
    if (_variants != null) {
      map['variants'] = _variants?.map((v) => v.toJson()).toList();
    }
    if (_seller != null) {
      map['seller'] = _seller?.toJson();
    }
    return map;
  }

}

class Seller {
  Seller({
      String? merchantId, 
      String? shopTitle, 
      num? marketplaceSellerId, 
      String? banner, 
      String? logo, 
      MarketInfo? marketInfo,}){
    _merchantId = merchantId;
    _shopTitle = shopTitle;
    _marketplaceSellerId = marketplaceSellerId;
    _banner = banner;
    _logo = logo;
    _marketInfo = marketInfo;
}

  Seller.fromJson(dynamic json) {
    _merchantId = json['merchant_id'];
    _shopTitle = json['shop_title'];
    _marketplaceSellerId = json['marketplace_seller_id'];
    _banner = json['banner'];
    _logo = json['logo'];
    _marketInfo = json['market_info'] != null ? MarketInfo.fromJson(json['market_info']) : null;
  }
  String? _merchantId;
  String? _shopTitle;
  num? _marketplaceSellerId;
  String? _banner;
  String? _logo;
  MarketInfo? _marketInfo;

  String? get merchantId => _merchantId;
  String? get shopTitle => _shopTitle;
  num? get marketplaceSellerId => _marketplaceSellerId;
  String? get banner => _banner;
  String? get logo => _logo;
  MarketInfo? get marketInfo => _marketInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['merchant_id'] = _merchantId;
    map['shop_title'] = _shopTitle;
    map['marketplace_seller_id'] = _marketplaceSellerId;
    map['banner'] = _banner;
    map['logo'] = _logo;
    if (_marketInfo != null) {
      map['market_info'] = _marketInfo?.toJson();
    }
    return map;
  }

}

class MarketInfo {
  MarketInfo({
      num? id, 
      String? name, 
      String? image,}){
    _id = id;
    _name = name;
    _image = image;
}

  MarketInfo.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
  }
  num? _id;
  String? _name;
  String? _image;

  num? get id => _id;
  String? get name => _name;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    return map;
  }

}

class ImageUrls {
  ImageUrls({
      String? localUrl, 
      dynamic azureUrl,}){
    _localUrl = localUrl;
    _azureUrl = azureUrl;
}

  ImageUrls.fromJson(dynamic json) {
    _localUrl = json['local_url'];
    _azureUrl = json['azure_url'];
  }
  String? _localUrl;
  dynamic _azureUrl;

  String? get localUrl => _localUrl;
  dynamic get azureUrl => _azureUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['local_url'] = _localUrl;
    map['azure_url'] = _azureUrl;
    return map;
  }

}