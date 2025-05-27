class BannerModel {
  BannerModel({
      num? id, 
      String? type, 
      bool? isActive, 
      String? displayFrom, 
      String? displayTo, 
      String? createdAt, 
      String? updatedAt, 
      String? imageUrl,}){
    _id = id;
    _type = type;
    _isActive = isActive;
    _displayFrom = displayFrom;
    _displayTo = displayTo;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _imageUrl = imageUrl;
}

  BannerModel.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _isActive = json['is_active'];
    _displayFrom = json['display_from'];
    _displayTo = json['display_to'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _imageUrl = json['image_url'];
  }
  num? _id;
  String? _type;
  bool? _isActive;
  String? _displayFrom;
  String? _displayTo;
  String? _createdAt;
  String? _updatedAt;
  String? _imageUrl;

  num? get id => _id;
  String? get type => _type;
  bool? get isActive => _isActive;
  String? get displayFrom => _displayFrom;
  String? get displayTo => _displayTo;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get imageUrl => _imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['is_active'] = _isActive;
    map['display_from'] = _displayFrom;
    map['display_to'] = _displayTo;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['image_url'] = _imageUrl;
    return map;
  }

}