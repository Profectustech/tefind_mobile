class CartModel {
  CartModel({
      num? currentPage, 
      List<Data>? data, 
      String? firstPageUrl, 
      num? from, 
      num? lastPage, 
      String? lastPageUrl, 
      List<Links>? links, 
      dynamic nextPageUrl, 
      String? path, 
      num? perPage, 
      dynamic prevPageUrl, 
      num? to, 
      num? total,}){
    _currentPage = currentPage;
    _data = data;
    _firstPageUrl = firstPageUrl;
    _from = from;
    _lastPage = lastPage;
    _lastPageUrl = lastPageUrl;
    _links = links;
    _nextPageUrl = nextPageUrl;
    _path = path;
    _perPage = perPage;
    _prevPageUrl = prevPageUrl;
    _to = to;
    _total = total;
}

  CartModel.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _firstPageUrl = json['first_page_url'];
    _from = json['from'];
    _lastPage = json['last_page'];
    _lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      _links = [];
      json['links'].forEach((v) {
        _links?.add(Links.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
    _perPage = json['per_page'];
    _prevPageUrl = json['prev_page_url'];
    _to = json['to'];
    _total = json['total'];
  }
  num? _currentPage;
  List<Data>? _data;
  String? _firstPageUrl;
  num? _from;
  num? _lastPage;
  String? _lastPageUrl;
  List<Links>? _links;
  dynamic _nextPageUrl;
  String? _path;
  num? _perPage;
  dynamic _prevPageUrl;
  num? _to;
  num? _total;

  num? get currentPage => _currentPage;
  List<Data>? get data => _data;
  String? get firstPageUrl => _firstPageUrl;
  num? get from => _from;
  num? get lastPage => _lastPage;
  String? get lastPageUrl => _lastPageUrl;
  List<Links>? get links => _links;
  dynamic get nextPageUrl => _nextPageUrl;
  String? get path => _path;
  num? get perPage => _perPage;
  dynamic get prevPageUrl => _prevPageUrl;
  num? get to => _to;
  num? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = _firstPageUrl;
    map['from'] = _from;
    map['last_page'] = _lastPage;
    map['last_page_url'] = _lastPageUrl;
    if (_links != null) {
      map['links'] = _links?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = _nextPageUrl;
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['prev_page_url'] = _prevPageUrl;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }

}

class Links {
  Links({
      dynamic url, 
      String? label, 
      bool? active,}){
    _url = url;
    _label = label;
    _active = active;
}

  Links.fromJson(dynamic json) {
    _url = json['url'];
    _label = json['label'];
    _active = json['active'];
  }
  dynamic _url;
  String? _label;
  bool? _active;

  dynamic get url => _url;
  String? get label => _label;
  bool? get active => _active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['label'] = _label;
    map['active'] = _active;
    return map;
  }

}

class Data {
  Data({
      num? id, 
      String? customerFirstName, 
      String? customerLastName, 
      String? customerEmail, 
      num? customerId, 
      String? cartCurrencyCode, 
      String? subTotal, 
      String? grandTotal, 
      String? shippingAmount, 
      String? taxTotal, 
      String? discountAmount, 
      num? isActive, 
      String? createdAt, 
      String? updatedAt, 
      List<Items>? items,}){
    _id = id;
    _customerFirstName = customerFirstName;
    _customerLastName = customerLastName;
    _customerEmail = customerEmail;
    _customerId = customerId;
    _cartCurrencyCode = cartCurrencyCode;
    _subTotal = subTotal;
    _grandTotal = grandTotal;
    _shippingAmount = shippingAmount;
    _taxTotal = taxTotal;
    _discountAmount = discountAmount;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _items = items;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _customerFirstName = json['customer_first_name'];
    _customerLastName = json['customer_last_name'];
    _customerEmail = json['customer_email'];
    _customerId = json['customer_id'];
    _cartCurrencyCode = json['cart_currency_code'];
    _subTotal = json['sub_total'];
    _grandTotal = json['grand_total'];
    _shippingAmount = json['shipping_amount'];
    _taxTotal = json['tax_total'];
    _discountAmount = json['discount_amount'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(Items.fromJson(v));
      });
    }
  }
  num? _id;
  String? _customerFirstName;
  String? _customerLastName;
  String? _customerEmail;
  num? _customerId;
  String? _cartCurrencyCode;
  String? _subTotal;
  String? _grandTotal;
  String? _shippingAmount;
  String? _taxTotal;
  String? _discountAmount;
  num? _isActive;
  String? _createdAt;
  String? _updatedAt;
  List<Items>? _items;

  num? get id => _id;
  String? get customerFirstName => _customerFirstName;
  String? get customerLastName => _customerLastName;
  String? get customerEmail => _customerEmail;
  num? get customerId => _customerId;
  String? get cartCurrencyCode => _cartCurrencyCode;
  String? get subTotal => _subTotal;
  String? get grandTotal => _grandTotal;
  String? get shippingAmount => _shippingAmount;
  String? get taxTotal => _taxTotal;
  String? get discountAmount => _discountAmount;
  num? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<Items>? get items => _items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['customer_first_name'] = _customerFirstName;
    map['customer_last_name'] = _customerLastName;
    map['customer_email'] = _customerEmail;
    map['customer_id'] = _customerId;
    map['cart_currency_code'] = _cartCurrencyCode;
    map['sub_total'] = _subTotal;
    map['grand_total'] = _grandTotal;
    map['shipping_amount'] = _shippingAmount;
    map['tax_total'] = _taxTotal;
    map['discount_amount'] = _discountAmount;
    map['is_active'] = _isActive;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_items != null) {
      map['items'] = _items?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Items {
  Items({
      num? id, 
      num? quantity, 
      String? sku, 
      String? type, 
      String? name, 
      num? productId, 
      num? cartId, 
      String? price, 
      dynamic total,
      String? createdAt, 
      String? updatedAt, 
      List<String>? images, 
      Seller? seller, 
      String? categoryName, 
      List<dynamic>? children, 
      Product? product,}){
    _id = id;
    _quantity = quantity;
    _sku = sku;
    _type = type;
    _name = name;
    _productId = productId;
    _cartId = cartId;
    _price = price;
    _total = total;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _images = images;
    _seller = seller;
    _categoryName = categoryName;
    _children = children;
    _product = product;
}

  Items.fromJson(dynamic json) {
    _id = json['id'];
    _quantity = json['quantity'];
    _sku = json['sku'];
    _type = json['type'];
    _name = json['name'];
    _productId = json['product_id'];
    _cartId = json['cart_id'];
    _price = json['price'];
    _total = json['total'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _images = json['images'] != null ? json['images'].cast<String>() : [];
    _seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
    _categoryName = json['category_name'];
    if (json['children'] != null) {
      _children = [];
      json['children'].forEach((v) {
       // _children?.add(Dynamic.fromJson(v));
      });
    }
    _product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }
  num? _id;
  num? _quantity;
  String? _sku;
  String? _type;
  String? _name;
  num? _productId;
  num? _cartId;
  String? _price;
  dynamic _total;
  String? _createdAt;
  String? _updatedAt;
  List<String>? _images;
  Seller? _seller;
  String? _categoryName;
  List<dynamic>? _children;
  Product? _product;

  num? get id => _id;
  num? get quantity => _quantity;
  String? get sku => _sku;
  String? get type => _type;
  String? get name => _name;
  num? get productId => _productId;
  num? get cartId => _cartId;
  String? get price => _price;
  dynamic? get total => _total;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<String>? get images => _images;
  Seller? get seller => _seller;
  String? get categoryName => _categoryName;
  List<dynamic>? get children => _children;
  Product? get product => _product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['quantity'] = _quantity;
    map['sku'] = _sku;
    map['type'] = _type;
    map['name'] = _name;
    map['product_id'] = _productId;
    map['cart_id'] = _cartId;
    map['price'] = _price;
    map['total'] = _total;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['images'] = _images;
    if (_seller != null) {
      map['seller'] = _seller?.toJson();
    }
    map['category_name'] = _categoryName;
    if (_children != null) {
      map['children'] = _children?.map((v) => v.toJson()).toList();
    }
    if (_product != null) {
      map['product'] = _product?.toJson();
    }
    return map;
  }

}

class Product {
  Product({
      num? id, 
      String? sku, 
      String? type, 
      String? createdAt, 
      String? updatedAt, 
      ProductCategory? productCategory, 
      String? brandName,}){
    _id = id;
    _sku = sku;
    _type = type;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _productCategory = productCategory;
    _brandName = brandName;
}

  Product.fromJson(dynamic json) {
    _id = json['id'];
    _sku = json['sku'];
    _type = json['type'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _productCategory = json['product_category'] != null ? ProductCategory.fromJson(json['product_category']) : null;
    _brandName = json['brand_name'];
  }
  num? _id;
  String? _sku;
  String? _type;
  String? _createdAt;
  String? _updatedAt;
  ProductCategory? _productCategory;
  String? _brandName;

  num? get id => _id;
  String? get sku => _sku;
  String? get type => _type;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  ProductCategory? get productCategory => _productCategory;
  String? get brandName => _brandName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['sku'] = _sku;
    map['type'] = _type;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_productCategory != null) {
      map['product_category'] = _productCategory?.toJson();
    }
    map['brand_name'] = _brandName;
    return map;
  }

}

class ProductCategory {
  ProductCategory({
      String? categoryName, 
      String? categoryType,}){
    _categoryName = categoryName;
    _categoryType = categoryType;
}

  ProductCategory.fromJson(dynamic json) {
    _categoryName = json['category_name'];
    _categoryType = json['category_type'];
  }
  String? _categoryName;
  String? _categoryType;

  String? get categoryName => _categoryName;
  String? get categoryType => _categoryType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category_name'] = _categoryName;
    map['category_type'] = _categoryType;
    return map;
  }

}

class Seller {
  Seller({
      num? id, 
      String? shopTitle, 
      dynamic description, 
      String? businessName,}){
    _id = id;
    _shopTitle = shopTitle;
    _description = description;
    _businessName = businessName;
}

  Seller.fromJson(dynamic json) {
    _id = json['id'];
    _shopTitle = json['shop_title'];
    _description = json['description'];
    _businessName = json['business_name'];
  }
  num? _id;
  String? _shopTitle;
  dynamic _description;
  String? _businessName;

  num? get id => _id;
  String? get shopTitle => _shopTitle;
  dynamic get description => _description;
  String? get businessName => _businessName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['shop_title'] = _shopTitle;
    map['description'] = _description;
    map['business_name'] = _businessName;
    return map;
  }

}