class AuthModel {
  final String _token;

  AuthModel(this._token);
  String get token => _token;

  factory AuthModel.fromJson(String token) {
    return AuthModel(
      token,
    );
  }
}