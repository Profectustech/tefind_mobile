class SignInResponse {
  SignInResponse({
      String? userId, 
      String? userType, 
      String? email, 
      String? firstName, 
      String? lastName,
    int? oldUserId,
  String? phoneNumber}){
    _userId = userId;
    _userType = userType;
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _phoneNumber = phoneNumber;
  _oldUserId = oldUserId;
}

  SignInResponse.fromJson(dynamic json) {
    _userId = json['user_id'];
    _userType = json['user_type'];
    _email = json['email'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _phoneNumber = json['phone_number'];
    _oldUserId = json['old_user_id'];

  }
  String? _userId;
  String? _userType;
  String? _email;
  String? _firstName;
  String? _lastName;
  String? _phoneNumber;
  int? _oldUserId;

  String? get userId => _userId;
  String? get userType => _userType;
  String? get email => _email;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get phoneNumber => _phoneNumber;
  int? get oldUserId => _oldUserId;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['user_type'] = _userType;
    map['email'] = _email;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['phone_number'] = _phoneNumber;
    map['old_user_id'] = _oldUserId;

    return map;
  }

}