class MarketListModel {
  MarketListModel({
      num? marketId, 
      String? name, 
      String? description, 
      String? image,}){
    _marketId = marketId;
    _name = name;
    _description = description;
    _image = image;
}

  MarketListModel.fromJson(dynamic json) {
    _marketId = json['id'];
    _name = json['name'];
    _description = json['description'];
    _image = json['image'];
  }
  num? _marketId;
  String? _name;
  String? _description;
  String? _image;

  num? get marketId => _marketId;
  String? get name => _name;
  String? get description => _description;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _marketId;
    map['name'] = _name;
    map['description'] = _description;
    map['image'] = _image;
    return map;
  }

}