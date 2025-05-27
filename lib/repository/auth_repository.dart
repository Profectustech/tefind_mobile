import 'dart:io';

import 'package:saleko/models/util_model.dart';
import 'package:saleko/repository/network_helper.dart';
import 'package:saleko/utils/enums.dart';

class AuthRepository {
  final NetworkHelper _networkHelper = NetworkHelper();

  Future<HTTPResponseModel> signup(Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: "auth-svc/auth/signup",
      body: body,
    );
  }

  Future<HTTPResponseModel> verify(Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: "auth-svc/otp/verify",
      body: body,
    );
  }
  Future<HTTPResponseModel> verifyForgot(Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: "auth-svc/otp/verify",
      body: body,
    );
  }


  Future<HTTPResponseModel> completeRegistration(
      Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: "auth-svc/auth/complete-signup",
      body: body,
    );
  }
  Future<HTTPResponseModel> sendForgotOtp(
      Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: "auth-svc/otp/send",
      body: body,
    );
  }
  Future<HTTPResponseModel> resetPassword(
      Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: "auth-svc/auth/reset-password",
      body: body,
    );
  }
  Future<HTTPResponseModel> createAddress(
      Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: "main-svc-v2/products/create-customer-address",
      body: body,
    );
  }
  Future<HTTPResponseModel> loginProviders(String? token) async {
    return await _networkHelper.runApi(
        type: ApiRequestType.post,
        url: 'auth-svc/auth/social/callback/google',
        body: {'channel': Platform.isIOS ? "ios" : "android", "token": token});
  }

  Future<HTTPResponseModel> loginApple(String? token) async {
    return await _networkHelper.runApi(
        type: ApiRequestType.post,
        url: 'auth-svc/auth/social/callback/apple',
        body: {'channel': Platform.isIOS ? "ios" : "android", "token": token});
  }

  Future<HTTPResponseModel> getCustomerAddress(int? customerID) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: 'main-svc-v2/products/customer-addresses?customer_id=$customerID',
    );
  }  Future<HTTPResponseModel> getPickUpAddress() async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: 'main-svc-v2/products/pickup-locations',
    );
  }
  Future<HTTPResponseModel> getDefaultLocation(double latitude,
      double longitude) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: 'main-svc-v2/public/products/current-location?latitude=$latitude&longitude=$longitude',
    );
  }

  Future<HTTPResponseModel> login(Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: 'auth-svc/auth/login',
      body: body,
    );
  }

  Future<HTTPResponseModel> banner() async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: 'main-svc-v2/media/get-items?type=slider',
    );
  }






}


