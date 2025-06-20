import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:te_find/models/util_model.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/services/navigation/route_names.dart';
import 'package:te_find/utils/constants.dart';
import 'package:te_find/utils/enums.dart';
import 'package:te_find/utils/error_handler.dart';
import 'package:te_find/utils/http.dart';
import 'package:te_find/utils/storage_util.dart';

class NetworkHelper {
  final Dio _dio = Dio();

  static const httpTimeoutDuration = 30;
  final NavigatorService _navigation = NavigatorService();

  final kTimeoutResponse = Response(
    data: {"success": false, "message": "Connection Timeout"},
    statusCode: StatusRequestTimeout,
    requestOptions:
        RequestOptions(path: 'Error occurred while connecting to server'),
  );

  Future<HTTPResponseModel> runApi({
    required ApiRequestType type,
    required String url,
    // String? from,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool showError = true,
    bool isFormData = false,
  }) async {
    debugPrint('URL:: ${AppConstants.kBaseUrl + url}, body:: ${body}');
    _dio.options.baseUrl = AppConstants.kBaseUrl;

    // TODO:: Handle error repsonse on Timeout with Dio. Currently using kTimeoutResponse
    // Not working
    // _dio.options.connectTimeout = httpTimeoutDuration * 1000;
    // _dio.options.receiveTimeout = httpTimeoutDuration * 1000;

    final token = await StorageUtil.getData("token");
    print('token: $token');

    var kHeader = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    kHeader.addAll(headers ?? {});

    _dio.options.headers = headers ?? kHeader;

    var res;
    try {
      switch (type) {
        case ApiRequestType.get:
          res = await _get(url: url, body: body);
          break;
        case ApiRequestType.post:
          res = await _post(url: url, body: body);

          break;
        case ApiRequestType.put:
          res = await _put(url: url, body: body);
          break;
        case ApiRequestType.patch:
          res = await _patch(url: url, body: body);
          break;
        case ApiRequestType.delete:
          res = await _delete(url: url, body: body);
          break;
        case ApiRequestType.formData:
          res = await _formData(url: url, body: body);
          break;
        case ApiRequestType.formDataPatch:
          res = await _formDataPatch(url: url, body: body);
          break;
      }

      log('res: ${jsonEncode(res.data)}');

      if (res.statusCode == StatusRequestTimeout) {
        DioErrorHandler()
            .handleStringError(res.data['message'] ?? 'Connection Timeout');
      }

      if (res.data is String) {
        return HTTPResponseModel.jsonToMap(
            {"success": false, "message": ""}, res.statusCode!);
      }

      return HTTPResponseModel.jsonToMap(res.data, res.statusCode!);
    } on DioError catch (error) {
      final int statusCode = error.response?.statusCode ?? 400;
      String errorMessage = "";
      print('error: ${error.error}');
      if (error.error.toString().contains("SocketException")) {
        errorMessage =
            "Your internet is not stable kindly reconnect and try again";
      } else {
        errorMessage = DioErrorHandler().getErrorMessage(error);
      }

      if (error.response?.statusCode == StatusUnauthorized) {
        DioErrorHandler()
            .handleStringError('Session expired. Kindly login again');
        // clear token
        StorageUtil.clearData();
        _navigation.pushNamedAndRemoveUntil(loginScreenRoute);
      } else if (showError) {
        if (error.error.toString().contains("SocketException")) {
          DioErrorHandler().handleStringError(
              "Your internet is not stable kindly reconnect and try again");
        } else {
          DioErrorHandler().handleError(
            error,
          );
        }
      }
      return HTTPResponseModel.jsonToMap(
          error.error.toString().contains("SocketException")
              ? {"message": ""}
              : error.response?.data,
          statusCode,
          errorMessage: errorMessage,
          success: false);
    } catch (e) {
      print('error: ${e.toString()}');
      rethrow;
    }
  }

  Future<Response> _get({required String url, body}) async {
    return await _dio.get(url).timeout(
        const Duration(seconds: httpTimeoutDuration),
        onTimeout: () => kTimeoutResponse);
  }

  Future<Response> _post({required String url, body}) async {
    return await _dio.post(url, data: body).timeout(
        const Duration(seconds: httpTimeoutDuration),
        onTimeout: () => kTimeoutResponse);
  }

  Future<Response> _patch({required String url, body}) async {
    return await _dio.patch(url, data: body).timeout(
        const Duration(seconds: httpTimeoutDuration),
        onTimeout: () => kTimeoutResponse);
  }

  Future<Response> _put({required String url, body}) async {
    return await _dio.put(url, data: body).timeout(
        const Duration(seconds: httpTimeoutDuration),
        onTimeout: () => kTimeoutResponse);
  }

  Future<Response> _delete({required String url, body}) async {
    return await _dio.delete(url, data: body).timeout(
        const Duration(seconds: httpTimeoutDuration),
        onTimeout: () => kTimeoutResponse);
  }

  Future<Response> _formData({required String url, body}) async {
    FormData formData = FormData.fromMap(body);
    return await _dio.post(url, data: formData).timeout(
        const Duration(seconds: httpTimeoutDuration),
        onTimeout: () => kTimeoutResponse);
  }

  Future<Response> _formDataPatch({required String url, body}) async {
    FormData formData = FormData.fromMap(body);
    return await _dio.patch(url, data: formData).timeout(
        const Duration(seconds: httpTimeoutDuration),
        onTimeout: () => kTimeoutResponse);
  }
}
