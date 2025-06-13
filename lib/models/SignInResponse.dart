class SignInResponse {
  SignInResponse({
    String? id,
    String? email,
    String? name,
    String? phoneNumber,
    String? role,
    bool? isVerified,
    bool? isBusinessVerified,
    int? rating,
    int? totalReviews,
    int? adminLevel,
    List<String>? permissions,
    String? createdAt,
    String? updatedAt,
    bool? hasStore,
    String? image,
    String? username,
  }) {
    _id = id;
    _email = email;
    _name = name;
    _phoneNumber = phoneNumber;
    _role = role;
    _isVerified = isVerified;
    _isBusinessVerified = isBusinessVerified;
    _rating = rating;
    _totalReviews = totalReviews;
    _adminLevel = adminLevel;
    _permissions = permissions;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _hasStore = hasStore;
    _image = image;
    _username = username;
  }

  SignInResponse.fromJson(dynamic json) {
    _id = json['_id'] ?? json['id'];
    _email = json['email'];
    _name = json['name'];
    _phoneNumber = json['phoneNumber'];
    _role = json['role'];
    _isVerified = json['isVerified'];
    _isBusinessVerified = json['isBusinessVerified'];
    _rating = json['rating'];
    _totalReviews = json['totalReviews'];
    _adminLevel = json['adminLevel'];
    _permissions = json['permissions'] != null ? List<String>.from(json['permissions']) : [];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _hasStore = json['hasStore'];
    _image = json['image'];
    _username = json['username'];
  }

  String? _id;
  String? _email;
  String? _name;
  String? _phoneNumber;
  String? _role;
  bool? _isVerified;
  bool? _isBusinessVerified;
  int? _rating;
  int? _totalReviews;
  int? _adminLevel;
  List<String>? _permissions;
  String? _createdAt;
  String? _updatedAt;
  bool? _hasStore;
  String? _image;
  String? _username;

  // Getters
  String? get id => _id;
  String? get email => _email;
  String? get name => _name;
  String? get phoneNumber => _phoneNumber;
  String? get role => _role;
  bool? get isVerified => _isVerified;
  bool? get isBusinessVerified => _isBusinessVerified;
  int? get rating => _rating;
  int? get totalReviews => _totalReviews;
  int? get adminLevel => _adminLevel;
  List<String>? get permissions => _permissions;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  bool? get hasStore => _hasStore;
  String? get image => _image;
  String? get username => _username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['email'] = _email;
    map['name'] = _name;
    map['phoneNumber'] = _phoneNumber;
    map['role'] = _role;
    map['isVerified'] = _isVerified;
    map['isBusinessVerified'] = _isBusinessVerified;
    map['rating'] = _rating;
    map['totalReviews'] = _totalReviews;
    map['adminLevel'] = _adminLevel;
    map['permissions'] = _permissions;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['hasStore'] = _hasStore;
    map['image'] = _image;
    map['username'] = _username;
    return map;
  }
}
