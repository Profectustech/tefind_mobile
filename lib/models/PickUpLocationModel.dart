class PickUpLocation {
  PickUpLocation({
    String? address1,
    String? city,
    String? state,
  }) {
    _address1 = address1;
    _city = city;
    _state = state;
  }

  PickUpLocation.fromJson(dynamic json) {
    _address1 = json['address1'];
    _city = json['city'];
    _state = json['state'];
  }

  String? _address1;
  String? _city;
  String? _state;

  String? get address1 => _address1;
  String? get city => _city;
  String? get state => _state;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address1'] = _address1;
    map['city'] = _city;
    map['state'] = _state;
    return map;
  }
}
