class ProductModel {
  ProductModel({
    num? id,
    String? sku,
    dynamic productNumber,
    String? name,
    String? description,
    String? urlKey,
    bool? status,
    dynamic thumbnail,
    num? price,
    dynamic cost,
    num? specialPrice,
    dynamic specialPriceFrom,
    dynamic specialPriceTo,
    num? weight,
    num? color,
    dynamic colorLabel,
    num? size,
    dynamic sizeLabel,
    String? createdAt,
    String? locale,
    String? channel,
    num? productId,
    String? updatedAt,
    dynamic parentId,
    bool? visibleIndividually,
    num? minPrice,
    num? maxPrice,
    String? shortDescription,
    dynamic metaTitle,
    dynamic metaKeywords,
    dynamic metaDescription,
    num? width,
    num? height,
    num? depth,
    dynamic rejectReason,
    String? approvalStatus,
    dynamic variants,
    List<ProductImages>? productImages,
  }) {
    _id = id;
    _sku = sku;
    _productNumber = productNumber;
    _name = name;
    _description = description;
    _urlKey = urlKey;
    _status = status;
    _thumbnail = thumbnail;
    _price = price;
    _cost = cost;
    _specialPrice = specialPrice;
    _specialPriceFrom = specialPriceFrom;
    _specialPriceTo = specialPriceTo;
    _weight = weight;
    _color = color;
    _colorLabel = colorLabel;
    _size = size;
    _sizeLabel = sizeLabel;
    _createdAt = createdAt;
    _locale = locale;
    _channel = channel;
    _productId = productId;
    _updatedAt = updatedAt;
    _parentId = parentId;
    _visibleIndividually = visibleIndividually;
    _minPrice = minPrice;
    _maxPrice = maxPrice;
    _shortDescription = shortDescription;
    _metaTitle = metaTitle;
    _metaKeywords = metaKeywords;
    _metaDescription = metaDescription;
    _width = width;
    _height = height;
    _depth = depth;
    _rejectReason = rejectReason;
    _approvalStatus = approvalStatus;
    _variants = variants;
    _productImages = productImages;
  }

  ProductModel.fromJson(dynamic json) {
    _id = json['id'];
    _sku = json['sku'];
    _productNumber = json['productNumber'];
    _name = json['name'];
    _description = json['description'];
    _urlKey = json['urlKey'];
    _status = json['status'];
    _thumbnail = json['thumbnail'];
    _price = json['price'];
    _cost = json['cost'];
    _specialPrice = json['specialPrice'];
    _specialPriceFrom = json['specialPriceFrom'];
    _specialPriceTo = json['specialPriceTo'];
    _weight = json['weight'];
    _color = json['color'];
    _colorLabel = json['colorLabel'];
    _size = json['size'];
    _sizeLabel = json['sizeLabel'];
    _createdAt = json['createdAt'];
    _locale = json['locale'];
    _channel = json['channel'];
    _productId = json['productId'];
    _updatedAt = json['updatedAt'];
    _parentId = json['parentId'];
    _visibleIndividually = json['visibleIndividually'];
    _minPrice = json['minPrice'];
    _maxPrice = json['maxPrice'];
    _shortDescription = json['shortDescription'];
    _metaTitle = json['metaTitle'];
    _metaKeywords = json['metaKeywords'];
    _metaDescription = json['metaDescription'];
    _width = json['width'];
    _height = json['height'];
    _depth = json['depth'];
    _rejectReason = json['rejectReason'];
    _approvalStatus = json['approvalStatus'];
    _variants = json['variants'];
    if (json['productImages'] != null) {
      _productImages = [];
      json['productImages'].forEach((v) {
        _productImages?.add(ProductImages.fromJson(v));
      });
    }
  }
  num? _id;
  String? _sku;
  dynamic _productNumber;
  String? _name;
  String? _description;
  String? _urlKey;
  bool? _status;
  dynamic _thumbnail;
  num? _price;
  dynamic _cost;
  num? _specialPrice;
  dynamic _specialPriceFrom;
  dynamic _specialPriceTo;
  num? _weight;
  num? _color;
  dynamic _colorLabel;
  num? _size;
  dynamic _sizeLabel;
  String? _createdAt;
  String? _locale;
  String? _channel;
  num? _productId;
  String? _updatedAt;
  dynamic _parentId;
  bool? _visibleIndividually;
  num? _minPrice;
  num? _maxPrice;
  String? _shortDescription;
  dynamic _metaTitle;
  dynamic _metaKeywords;
  dynamic _metaDescription;
  num? _width;
  num? _height;
  num? _depth;
  dynamic _rejectReason;
  String? _approvalStatus;
  dynamic _variants;
  List<ProductImages>? _productImages;
  ProductModel copyWith({
    num? id,
    String? sku,
    dynamic productNumber,
    String? name,
    String? description,
    String? urlKey,
    bool? status,
    dynamic thumbnail,
    num? price,
    dynamic cost,
    num? specialPrice,
    dynamic specialPriceFrom,
    dynamic specialPriceTo,
    num? weight,
    num? color,
    dynamic colorLabel,
    num? size,
    dynamic sizeLabel,
    String? createdAt,
    String? locale,
    String? channel,
    num? productId,
    String? updatedAt,
    dynamic parentId,
    bool? visibleIndividually,
    num? minPrice,
    num? maxPrice,
    String? shortDescription,
    dynamic metaTitle,
    dynamic metaKeywords,
    dynamic metaDescription,
    num? width,
    num? height,
    num? depth,
    dynamic rejectReason,
    String? approvalStatus,
    dynamic variants,
    List<ProductImages>? productImages,
  }) =>
      ProductModel(
        id: id ?? _id,
        sku: sku ?? _sku,
        productNumber: productNumber ?? _productNumber,
        name: name ?? _name,
        description: description ?? _description,
        urlKey: urlKey ?? _urlKey,
        status: status ?? _status,
        thumbnail: thumbnail ?? _thumbnail,
        price: price ?? _price,
        cost: cost ?? _cost,
        specialPrice: specialPrice ?? _specialPrice,
        specialPriceFrom: specialPriceFrom ?? _specialPriceFrom,
        specialPriceTo: specialPriceTo ?? _specialPriceTo,
        weight: weight ?? _weight,
        color: color ?? _color,
        colorLabel: colorLabel ?? _colorLabel,
        size: size ?? _size,
        sizeLabel: sizeLabel ?? _sizeLabel,
        createdAt: createdAt ?? _createdAt,
        locale: locale ?? _locale,
        channel: channel ?? _channel,
        productId: productId ?? _productId,
        updatedAt: updatedAt ?? _updatedAt,
        parentId: parentId ?? _parentId,
        visibleIndividually: visibleIndividually ?? _visibleIndividually,
        minPrice: minPrice ?? _minPrice,
        maxPrice: maxPrice ?? _maxPrice,
        shortDescription: shortDescription ?? _shortDescription,
        metaTitle: metaTitle ?? _metaTitle,
        metaKeywords: metaKeywords ?? _metaKeywords,
        metaDescription: metaDescription ?? _metaDescription,
        width: width ?? _width,
        height: height ?? _height,
        depth: depth ?? _depth,
        rejectReason: rejectReason ?? _rejectReason,
        approvalStatus: approvalStatus ?? _approvalStatus,
        variants: variants ?? _variants,
        productImages: productImages ?? _productImages,
      );
  num? get id => _id;
  String? get sku => _sku;
  dynamic get productNumber => _productNumber;
  String? get name => _name;
  String? get description => _description;
  String? get urlKey => _urlKey;
  bool? get status => _status;
  dynamic get thumbnail => _thumbnail;
  num? get price => _price;
  dynamic get cost => _cost;
  num? get specialPrice => _specialPrice;
  dynamic get specialPriceFrom => _specialPriceFrom;
  dynamic get specialPriceTo => _specialPriceTo;
  num? get weight => _weight;
  num? get color => _color;
  dynamic get colorLabel => _colorLabel;
  num? get size => _size;
  dynamic get sizeLabel => _sizeLabel;
  String? get createdAt => _createdAt;
  String? get locale => _locale;
  String? get channel => _channel;
  num? get productId => _productId;
  String? get updatedAt => _updatedAt;
  dynamic get parentId => _parentId;
  bool? get visibleIndividually => _visibleIndividually;
  num? get minPrice => _minPrice;
  num? get maxPrice => _maxPrice;
  String? get shortDescription => _shortDescription;
  dynamic get metaTitle => _metaTitle;
  dynamic get metaKeywords => _metaKeywords;
  dynamic get metaDescription => _metaDescription;
  num? get width => _width;
  num? get height => _height;
  num? get depth => _depth;
  dynamic get rejectReason => _rejectReason;
  String? get approvalStatus => _approvalStatus;
  dynamic get variants => _variants;
  List<ProductImages>? get productImages => _productImages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['sku'] = _sku;
    map['productNumber'] = _productNumber;
    map['name'] = _name;
    map['description'] = _description;
    map['urlKey'] = _urlKey;
    map['status'] = _status;
    map['thumbnail'] = _thumbnail;
    map['price'] = _price;
    map['cost'] = _cost;
    map['specialPrice'] = _specialPrice;
    map['specialPriceFrom'] = _specialPriceFrom;
    map['specialPriceTo'] = _specialPriceTo;
    map['weight'] = _weight;
    map['color'] = _color;
    map['colorLabel'] = _colorLabel;
    map['size'] = _size;
    map['sizeLabel'] = _sizeLabel;
    map['createdAt'] = _createdAt;
    map['locale'] = _locale;
    map['channel'] = _channel;
    map['productId'] = _productId;
    map['updatedAt'] = _updatedAt;
    map['parentId'] = _parentId;
    map['visibleIndividually'] = _visibleIndividually;
    map['minPrice'] = _minPrice;
    map['maxPrice'] = _maxPrice;
    map['shortDescription'] = _shortDescription;
    map['metaTitle'] = _metaTitle;
    map['metaKeywords'] = _metaKeywords;
    map['metaDescription'] = _metaDescription;
    map['width'] = _width;
    map['height'] = _height;
    map['depth'] = _depth;
    map['rejectReason'] = _rejectReason;
    map['approvalStatus'] = _approvalStatus;
    map['variants'] = _variants;
    if (_productImages != null) {
      map['productImages'] = _productImages?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// small_image_url : "https://te_find.ng/cache/small/product/13203/VQGhwIWhQ5zSnZH48iUlKg5jHbtXSaLfro6ijLYF.png"
/// medium_image_url : "https://te_find.ng/cache/medium/product/13203/VQGhwIWhQ5zSnZH48iUlKg5jHbtXSaLfro6ijLYF.png"
/// large_image_url : "https://te_find.ng/cache/large/product/13203/VQGhwIWhQ5zSnZH48iUlKg5jHbtXSaLfro6ijLYF.png"
/// original_image_url : "https://te_find.ng/cache/original/product/13203/VQGhwIWhQ5zSnZH48iUlKg5jHbtXSaLfro6ijLYF.png"

class ProductImages {
  ProductImages({
    String? smallImageUrl,
    String? mediumImageUrl,
    String? largeImageUrl,
    String? originalImageUrl,
  }) {
    _smallImageUrl = smallImageUrl;
    _mediumImageUrl = mediumImageUrl;
    _largeImageUrl = largeImageUrl;
    _originalImageUrl = originalImageUrl;
  }

  ProductImages.fromJson(dynamic json) {
    _smallImageUrl = json['small_image_url'];
    _mediumImageUrl = json['medium_image_url'];
    _largeImageUrl = json['large_image_url'];
    _originalImageUrl = json['original_image_url'];
  }
  String? _smallImageUrl;
  String? _mediumImageUrl;
  String? _largeImageUrl;
  String? _originalImageUrl;
  ProductImages copyWith({
    String? smallImageUrl,
    String? mediumImageUrl,
    String? largeImageUrl,
    String? originalImageUrl,
  }) =>
      ProductImages(
        smallImageUrl: smallImageUrl ?? _smallImageUrl,
        mediumImageUrl: mediumImageUrl ?? _mediumImageUrl,
        largeImageUrl: largeImageUrl ?? _largeImageUrl,
        originalImageUrl: originalImageUrl ?? _originalImageUrl,
      );
  String? get smallImageUrl => _smallImageUrl;
  String? get mediumImageUrl => _mediumImageUrl;
  String? get largeImageUrl => _largeImageUrl;
  String? get originalImageUrl => _originalImageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['small_image_url'] = _smallImageUrl;
    map['medium_image_url'] = _mediumImageUrl;
    map['large_image_url'] = _largeImageUrl;
    map['original_image_url'] = _originalImageUrl;
    return map;
  }
}
