class CustomerAddress {
  final int? addressId;
  final String addressTitle;
  final String address;
  final String city;
  final String state;
  final String landmark;
  final bool defaultAddress;

  const CustomerAddress({
    this.addressId,
    this.addressTitle = '',
    this.address = '',
    this.city = '',
    this.state = '',
    this.landmark = '',
    this.defaultAddress = false,
  });

  factory CustomerAddress.fromJson(Map<String, dynamic> json) {
    return CustomerAddress(
      addressId: json['address_id'],
      addressTitle: json['address_title'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      landmark: json['landmark'] ?? '',
      defaultAddress: json['default_address'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address_id': addressId,
      'address_title': addressTitle,
      'address': address,
      'city': city,
      'state': state,
      'landmark': landmark,
      'default_address': defaultAddress,
    };
  }

  CustomerAddress copyWith({
    int? addressId,
    String? addressTitle,
    String? address,
    String? city,
    String? state,
    String? landmark,
    bool? defaultAddress,
  }) {
    return CustomerAddress(
      addressId: addressId ?? this.addressId,
      addressTitle: addressTitle ?? this.addressTitle,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      landmark: landmark ?? this.landmark,
      defaultAddress: defaultAddress ?? this.defaultAddress,
    );
  }

  static const empty = CustomerAddress();

  bool get isEmpty => this == CustomerAddress.empty;
  bool get isNotEmpty => !isEmpty;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomerAddress &&
        other.addressId == addressId &&
        other.addressTitle == addressTitle &&
        other.address == address &&
        other.city == city &&
        other.state == state &&
        other.landmark == landmark &&
        other.defaultAddress == defaultAddress;
  }

  @override
  int get hashCode {
    return Object.hash(
      addressId,
      addressTitle,
      address,
      city,
      state,
      landmark,
      defaultAddress,
    );
  }
}
