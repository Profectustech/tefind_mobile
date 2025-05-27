class BrandListModel {
  BrandListModel({
    num? optionId,
    String? name,
    num? sortOrder,
    dynamic swatchValue,
    String? imagePath,
  }) {
    _optionId = optionId;
    _name = name;
    _sortOrder = sortOrder;
    _swatchValue = swatchValue;
    _imagePath = imagePath;
  }

  BrandListModel.fromJson(dynamic json) {
    _optionId = json['optionId'];
    _name = json['name'];
    _sortOrder = json['sortOrder'];
    _swatchValue = json['swatchValue'];
    _imagePath = json['imagePath'];
  }

  num? _optionId;
  String? _name;
  num? _sortOrder;
  dynamic _swatchValue;
  String? _imagePath;

  num? get optionId => _optionId;
  String? get name => _name;
  num? get sortOrder => _sortOrder;
  dynamic get swatchValue => _swatchValue;
  String? get imagePath => _imagePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['optionId'] = _optionId;
    map['name'] = _name;
    map['sortOrder'] = _sortOrder;
    map['swatchValue'] = _swatchValue;
    map['imagePath'] = _imagePath;
    return map;
  }
}
