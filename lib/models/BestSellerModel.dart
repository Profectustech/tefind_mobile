/// id : 163
/// merchant_id : "MW164F"
/// url : "joagoola-investments"
/// is_approved : 1
/// is_disabled : 0
/// shop_title : "joagoola Investments"
/// description : null
/// banner : null
/// logo : null
/// tax_vat : null
/// meta_title : null
/// meta_description : null
/// meta_keywords : null
/// address1 : null
/// address2 : null
/// phone : null
/// state : "LAGOS"
/// city : "Lagos Island"
/// country : null
/// drop_off : "6"
/// representative_id : null
/// postcode : null
/// return_policy : null
/// shipping_policy : null
/// privacy_policy : null
/// twitter : null
/// facebook : null
/// youtube : null
/// instagram : null
/// skype : null
/// linked_in : null
/// pinterest : null
/// customer_id : 175
/// created_at : "2024-04-25T16:06:58.000000Z"
/// updated_at : "2024-09-15T12:22:23.000000Z"
/// commission_enable : 0
/// commission_percentage : "0.0000"
/// min_order_amount : "-1.0E-11"
/// google_analytics_id : null
/// business_address : "Dosumu Idumota"
/// commodities : 34
/// market : "4"
/// bvn : "8035714978"
/// home_address : "Dosumu Idumota"
/// business_name : "joagoola Investments"
/// identity_document_number : "8035714978"
/// bankName : null
/// accountNumber : null
/// account_created_at : null
/// identity_document_number_type : 9
/// is_mro_assigned : 0
/// orders_count : 20
/// logo_image_url : "https://te_find.ng/themes/msmarvel/assets/images/store-banner.png"
/// banner_image_url : "https://te_find.ng/themes/msmarvel/assets/images/store-banner.png"
/// market_info : {"id":4,"name":"idumota","image":"markets/idumota.png","image_url":"https://te_find.ng/storage/markets/idumota.png"}

class BestSellerModel {
  BestSellerModel({
      num? id, 
      String? merchantId, 
      String? url, 
      num? isApproved, 
      num? isDisabled, 
      String? shopTitle, 
      dynamic description, 
      dynamic banner, 
      dynamic logo, 
      dynamic taxVat, 
      dynamic metaTitle, 
      dynamic metaDescription, 
      dynamic metaKeywords, 
      dynamic address1, 
      dynamic address2, 
      dynamic phone, 
      String? state, 
      String? city, 
      dynamic country, 
      String? dropOff, 
      dynamic representativeId, 
      dynamic postcode, 
      dynamic returnPolicy, 
      dynamic shippingPolicy, 
      dynamic privacyPolicy, 
      dynamic twitter, 
      dynamic facebook, 
      dynamic youtube, 
      dynamic instagram, 
      dynamic skype, 
      dynamic linkedIn, 
      dynamic pinterest, 
      num? customerId, 
      String? createdAt, 
      String? updatedAt, 
      num? commissionEnable, 
      String? commissionPercentage, 
      String? minOrderAmount, 
      dynamic googleAnalyticsId, 
      String? businessAddress, 
      num? commodities, 
      String? market, 
      String? bvn, 
      String? homeAddress, 
      String? businessName, 
      String? identityDocumentNumber, 
      dynamic bankName, 
      dynamic accountNumber, 
      dynamic accountCreatedAt, 
      num? identityDocumentNumberType, 
      num? isMroAssigned, 
      num? ordersCount, 
      String? logoImageUrl, 
      String? bannerImageUrl, 
      MarketInfo? marketInfo,}){
    _id = id;
    _merchantId = merchantId;
    _url = url;
    _isApproved = isApproved;
    _isDisabled = isDisabled;
    _shopTitle = shopTitle;
    _description = description;
    _banner = banner;
    _logo = logo;
    _taxVat = taxVat;
    _metaTitle = metaTitle;
    _metaDescription = metaDescription;
    _metaKeywords = metaKeywords;
    _address1 = address1;
    _address2 = address2;
    _phone = phone;
    _state = state;
    _city = city;
    _country = country;
    _dropOff = dropOff;
    _representativeId = representativeId;
    _postcode = postcode;
    _returnPolicy = returnPolicy;
    _shippingPolicy = shippingPolicy;
    _privacyPolicy = privacyPolicy;
    _twitter = twitter;
    _facebook = facebook;
    _youtube = youtube;
    _instagram = instagram;
    _skype = skype;
    _linkedIn = linkedIn;
    _pinterest = pinterest;
    _customerId = customerId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _commissionEnable = commissionEnable;
    _commissionPercentage = commissionPercentage;
    _minOrderAmount = minOrderAmount;
    _googleAnalyticsId = googleAnalyticsId;
    _businessAddress = businessAddress;
    _commodities = commodities;
    _market = market;
    _bvn = bvn;
    _homeAddress = homeAddress;
    _businessName = businessName;
    _identityDocumentNumber = identityDocumentNumber;
    _bankName = bankName;
    _accountNumber = accountNumber;
    _accountCreatedAt = accountCreatedAt;
    _identityDocumentNumberType = identityDocumentNumberType;
    _isMroAssigned = isMroAssigned;
    _ordersCount = ordersCount;
    _logoImageUrl = logoImageUrl;
    _bannerImageUrl = bannerImageUrl;
    _marketInfo = marketInfo;
}

  BestSellerModel.fromJson(dynamic json) {
    _id = json['id'];
    _merchantId = json['merchant_id'];
    _url = json['url'];
    _isApproved = json['is_approved'];
    _isDisabled = json['is_disabled'];
    _shopTitle = json['shop_title'];
    _description = json['description'];
    _banner = json['banner'];
    _logo = json['logo'];
    _taxVat = json['tax_vat'];
    _metaTitle = json['meta_title'];
    _metaDescription = json['meta_description'];
    _metaKeywords = json['meta_keywords'];
    _address1 = json['address1'];
    _address2 = json['address2'];
    _phone = json['phone'];
    _state = json['state'];
    _city = json['city'];
    _country = json['country'];
    _dropOff = json['drop_off'];
    _representativeId = json['representative_id'];
    _postcode = json['postcode'];
    _returnPolicy = json['return_policy'];
    _shippingPolicy = json['shipping_policy'];
    _privacyPolicy = json['privacy_policy'];
    _twitter = json['twitter'];
    _facebook = json['facebook'];
    _youtube = json['youtube'];
    _instagram = json['instagram'];
    _skype = json['skype'];
    _linkedIn = json['linked_in'];
    _pinterest = json['pinterest'];
    _customerId = json['customer_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _commissionEnable = json['commission_enable'];
    _commissionPercentage = json['commission_percentage'];
    _minOrderAmount = json['min_order_amount'];
    _googleAnalyticsId = json['google_analytics_id'];
    _businessAddress = json['business_address'];
    _commodities = json['commodities'];
    _market = json['market'];
    _bvn = json['bvn'];
    _homeAddress = json['home_address'];
    _businessName = json['business_name'];
    _identityDocumentNumber = json['identity_document_number'];
    _bankName = json['bankName'];
    _accountNumber = json['accountNumber'];
    _accountCreatedAt = json['account_created_at'];
    _identityDocumentNumberType = json['identity_document_number_type'];
    _isMroAssigned = json['is_mro_assigned'];
    _ordersCount = json['orders_count'];
    _logoImageUrl = json['logo_image_url'];
    _bannerImageUrl = json['banner_image_url'];
    _marketInfo = json['market_info'] != null ? MarketInfo.fromJson(json['market_info']) : null;
  }
  num? _id;
  String? _merchantId;
  String? _url;
  num? _isApproved;
  num? _isDisabled;
  String? _shopTitle;
  dynamic _description;
  dynamic _banner;
  dynamic _logo;
  dynamic _taxVat;
  dynamic _metaTitle;
  dynamic _metaDescription;
  dynamic _metaKeywords;
  dynamic _address1;
  dynamic _address2;
  dynamic _phone;
  String? _state;
  String? _city;
  dynamic _country;
  String? _dropOff;
  dynamic _representativeId;
  dynamic _postcode;
  dynamic _returnPolicy;
  dynamic _shippingPolicy;
  dynamic _privacyPolicy;
  dynamic _twitter;
  dynamic _facebook;
  dynamic _youtube;
  dynamic _instagram;
  dynamic _skype;
  dynamic _linkedIn;
  dynamic _pinterest;
  num? _customerId;
  String? _createdAt;
  String? _updatedAt;
  num? _commissionEnable;
  String? _commissionPercentage;
  String? _minOrderAmount;
  dynamic _googleAnalyticsId;
  String? _businessAddress;
  num? _commodities;
  String? _market;
  String? _bvn;
  String? _homeAddress;
  String? _businessName;
  String? _identityDocumentNumber;
  dynamic _bankName;
  dynamic _accountNumber;
  dynamic _accountCreatedAt;
  num? _identityDocumentNumberType;
  num? _isMroAssigned;
  num? _ordersCount;
  String? _logoImageUrl;
  String? _bannerImageUrl;
  MarketInfo? _marketInfo;
BestSellerModel copyWith({  num? id,
  String? merchantId,
  String? url,
  num? isApproved,
  num? isDisabled,
  String? shopTitle,
  dynamic description,
  dynamic banner,
  dynamic logo,
  dynamic taxVat,
  dynamic metaTitle,
  dynamic metaDescription,
  dynamic metaKeywords,
  dynamic address1,
  dynamic address2,
  dynamic phone,
  String? state,
  String? city,
  dynamic country,
  String? dropOff,
  dynamic representativeId,
  dynamic postcode,
  dynamic returnPolicy,
  dynamic shippingPolicy,
  dynamic privacyPolicy,
  dynamic twitter,
  dynamic facebook,
  dynamic youtube,
  dynamic instagram,
  dynamic skype,
  dynamic linkedIn,
  dynamic pinterest,
  num? customerId,
  String? createdAt,
  String? updatedAt,
  num? commissionEnable,
  String? commissionPercentage,
  String? minOrderAmount,
  dynamic googleAnalyticsId,
  String? businessAddress,
  num? commodities,
  String? market,
  String? bvn,
  String? homeAddress,
  String? businessName,
  String? identityDocumentNumber,
  dynamic bankName,
  dynamic accountNumber,
  dynamic accountCreatedAt,
  num? identityDocumentNumberType,
  num? isMroAssigned,
  num? ordersCount,
  String? logoImageUrl,
  String? bannerImageUrl,
  MarketInfo? marketInfo,
}) => BestSellerModel(  id: id ?? _id,
  merchantId: merchantId ?? _merchantId,
  url: url ?? _url,
  isApproved: isApproved ?? _isApproved,
  isDisabled: isDisabled ?? _isDisabled,
  shopTitle: shopTitle ?? _shopTitle,
  description: description ?? _description,
  banner: banner ?? _banner,
  logo: logo ?? _logo,
  taxVat: taxVat ?? _taxVat,
  metaTitle: metaTitle ?? _metaTitle,
  metaDescription: metaDescription ?? _metaDescription,
  metaKeywords: metaKeywords ?? _metaKeywords,
  address1: address1 ?? _address1,
  address2: address2 ?? _address2,
  phone: phone ?? _phone,
  state: state ?? _state,
  city: city ?? _city,
  country: country ?? _country,
  dropOff: dropOff ?? _dropOff,
  representativeId: representativeId ?? _representativeId,
  postcode: postcode ?? _postcode,
  returnPolicy: returnPolicy ?? _returnPolicy,
  shippingPolicy: shippingPolicy ?? _shippingPolicy,
  privacyPolicy: privacyPolicy ?? _privacyPolicy,
  twitter: twitter ?? _twitter,
  facebook: facebook ?? _facebook,
  youtube: youtube ?? _youtube,
  instagram: instagram ?? _instagram,
  skype: skype ?? _skype,
  linkedIn: linkedIn ?? _linkedIn,
  pinterest: pinterest ?? _pinterest,
  customerId: customerId ?? _customerId,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  commissionEnable: commissionEnable ?? _commissionEnable,
  commissionPercentage: commissionPercentage ?? _commissionPercentage,
  minOrderAmount: minOrderAmount ?? _minOrderAmount,
  googleAnalyticsId: googleAnalyticsId ?? _googleAnalyticsId,
  businessAddress: businessAddress ?? _businessAddress,
  commodities: commodities ?? _commodities,
  market: market ?? _market,
  bvn: bvn ?? _bvn,
  homeAddress: homeAddress ?? _homeAddress,
  businessName: businessName ?? _businessName,
  identityDocumentNumber: identityDocumentNumber ?? _identityDocumentNumber,
  bankName: bankName ?? _bankName,
  accountNumber: accountNumber ?? _accountNumber,
  accountCreatedAt: accountCreatedAt ?? _accountCreatedAt,
  identityDocumentNumberType: identityDocumentNumberType ?? _identityDocumentNumberType,
  isMroAssigned: isMroAssigned ?? _isMroAssigned,
  ordersCount: ordersCount ?? _ordersCount,
  logoImageUrl: logoImageUrl ?? _logoImageUrl,
  bannerImageUrl: bannerImageUrl ?? _bannerImageUrl,
  marketInfo: marketInfo ?? _marketInfo,
);
  num? get id => _id;
  String? get merchantId => _merchantId;
  String? get url => _url;
  num? get isApproved => _isApproved;
  num? get isDisabled => _isDisabled;
  String? get shopTitle => _shopTitle;
  dynamic get description => _description;
  dynamic get banner => _banner;
  dynamic get logo => _logo;
  dynamic get taxVat => _taxVat;
  dynamic get metaTitle => _metaTitle;
  dynamic get metaDescription => _metaDescription;
  dynamic get metaKeywords => _metaKeywords;
  dynamic get address1 => _address1;
  dynamic get address2 => _address2;
  dynamic get phone => _phone;
  String? get state => _state;
  String? get city => _city;
  dynamic get country => _country;
  String? get dropOff => _dropOff;
  dynamic get representativeId => _representativeId;
  dynamic get postcode => _postcode;
  dynamic get returnPolicy => _returnPolicy;
  dynamic get shippingPolicy => _shippingPolicy;
  dynamic get privacyPolicy => _privacyPolicy;
  dynamic get twitter => _twitter;
  dynamic get facebook => _facebook;
  dynamic get youtube => _youtube;
  dynamic get instagram => _instagram;
  dynamic get skype => _skype;
  dynamic get linkedIn => _linkedIn;
  dynamic get pinterest => _pinterest;
  num? get customerId => _customerId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get commissionEnable => _commissionEnable;
  String? get commissionPercentage => _commissionPercentage;
  String? get minOrderAmount => _minOrderAmount;
  dynamic get googleAnalyticsId => _googleAnalyticsId;
  String? get businessAddress => _businessAddress;
  num? get commodities => _commodities;
  String? get market => _market;
  String? get bvn => _bvn;
  String? get homeAddress => _homeAddress;
  String? get businessName => _businessName;
  String? get identityDocumentNumber => _identityDocumentNumber;
  dynamic get bankName => _bankName;
  dynamic get accountNumber => _accountNumber;
  dynamic get accountCreatedAt => _accountCreatedAt;
  num? get identityDocumentNumberType => _identityDocumentNumberType;
  num? get isMroAssigned => _isMroAssigned;
  num? get ordersCount => _ordersCount;
  String? get logoImageUrl => _logoImageUrl;
  String? get bannerImageUrl => _bannerImageUrl;
  MarketInfo? get marketInfo => _marketInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['merchant_id'] = _merchantId;
    map['url'] = _url;
    map['is_approved'] = _isApproved;
    map['is_disabled'] = _isDisabled;
    map['shop_title'] = _shopTitle;
    map['description'] = _description;
    map['banner'] = _banner;
    map['logo'] = _logo;
    map['tax_vat'] = _taxVat;
    map['meta_title'] = _metaTitle;
    map['meta_description'] = _metaDescription;
    map['meta_keywords'] = _metaKeywords;
    map['address1'] = _address1;
    map['address2'] = _address2;
    map['phone'] = _phone;
    map['state'] = _state;
    map['city'] = _city;
    map['country'] = _country;
    map['drop_off'] = _dropOff;
    map['representative_id'] = _representativeId;
    map['postcode'] = _postcode;
    map['return_policy'] = _returnPolicy;
    map['shipping_policy'] = _shippingPolicy;
    map['privacy_policy'] = _privacyPolicy;
    map['twitter'] = _twitter;
    map['facebook'] = _facebook;
    map['youtube'] = _youtube;
    map['instagram'] = _instagram;
    map['skype'] = _skype;
    map['linked_in'] = _linkedIn;
    map['pinterest'] = _pinterest;
    map['customer_id'] = _customerId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['commission_enable'] = _commissionEnable;
    map['commission_percentage'] = _commissionPercentage;
    map['min_order_amount'] = _minOrderAmount;
    map['google_analytics_id'] = _googleAnalyticsId;
    map['business_address'] = _businessAddress;
    map['commodities'] = _commodities;
    map['market'] = _market;
    map['bvn'] = _bvn;
    map['home_address'] = _homeAddress;
    map['business_name'] = _businessName;
    map['identity_document_number'] = _identityDocumentNumber;
    map['bankName'] = _bankName;
    map['accountNumber'] = _accountNumber;
    map['account_created_at'] = _accountCreatedAt;
    map['identity_document_number_type'] = _identityDocumentNumberType;
    map['is_mro_assigned'] = _isMroAssigned;
    map['orders_count'] = _ordersCount;
    map['logo_image_url'] = _logoImageUrl;
    map['banner_image_url'] = _bannerImageUrl;
    if (_marketInfo != null) {
      map['market_info'] = _marketInfo?.toJson();
    }
    return map;
  }

}

/// id : 4
/// name : "idumota"
/// image : "markets/idumota.png"
/// image_url : "https://te_find.ng/storage/markets/idumota.png"

class MarketInfo {
  MarketInfo({
      num? id, 
      String? name, 
      String? image, 
      String? imageUrl,}){
    _id = id;
    _name = name;
    _image = image;
    _imageUrl = imageUrl;
}

  MarketInfo.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _imageUrl = json['image_url'];
  }
  num? _id;
  String? _name;
  String? _image;
  String? _imageUrl;
MarketInfo copyWith({  num? id,
  String? name,
  String? image,
  String? imageUrl,
}) => MarketInfo(  id: id ?? _id,
  name: name ?? _name,
  image: image ?? _image,
  imageUrl: imageUrl ?? _imageUrl,
);
  num? get id => _id;
  String? get name => _name;
  String? get image => _image;
  String? get imageUrl => _imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    map['image_url'] = _imageUrl;
    return map;
  }

}