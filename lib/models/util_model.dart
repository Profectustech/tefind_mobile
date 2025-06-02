import 'package:flutter/material.dart';
import 'package:te_find/utils/http.dart';

class HTTPResponseModel {
  HTTPResponseModel();

  static bool isApiCallSuccess(HTTPResponseModel data) {
    if (data.success != true) {
      return false;
    }
    return true;
  }

  int? _code;
  bool? _success;
  String? _message;
  dynamic _error;
  String? _errorMessage;
  dynamic _data;
  dynamic _all;

  int get code => _code!;
  bool get success => _success!;
  String? get message => _message;
  dynamic get error => _error;
  String get errorMessage => _errorMessage!;
  dynamic get data => _data;
  dynamic get all => _all;

  set setSuccess(int code) => _code = code;
  set setStatus(bool success) => _success = success;
  set setErrorMessage(String message) => _message = message;
  set setError(error) => _error = error;
  set setData(data) => _data = data;
  set setAll(all) => _all = all;

  HTTPResponseModel.jsonToMap(Map<dynamic, dynamic> parsedJson, int statusCode,
      {String? errorMessage, bool? success}) {
    _code = statusCode;
    _success = success ?? (parsedJson['success'] ?? false);
    _message = parsedJson['message'].toString();
    _error = parsedJson['error'];
    _errorMessage = errorMessage;
    _data = parsedJson['data'];
    _all = parsedJson;
  }
}

class ErrorResponseModel {
  ErrorResponseModel(
      {this.success = false,
      this.code = StatusBadRequest,
      required this.error});
  final bool success;
  final int code;
  final String error;
}
