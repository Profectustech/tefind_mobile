import 'dart:io';

import 'package:te_find/models/util_model.dart';
import 'package:te_find/repository/network_helper.dart';
import 'package:te_find/utils/enums.dart';

class AuthRepository {
  final NetworkHelper _networkHelper = NetworkHelper();

  Future<HTTPResponseModel> signup(Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: "auth/signup",
      body: body,
    );
  }
  Future<HTTPResponseModel> createAccount(Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: "auth/create-account",
      body: body,
    );
  }

  Future<HTTPResponseModel> verify(Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: "auth/verify-otp",
      body: body,
    );
  }
  Future<HTTPResponseModel> verifyForgot(Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: "auth/verify-otp",
      body: body,
    );
  }

  Future<HTTPResponseModel> sendForgotOtp(
      Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: "auth/forgot-password",
      body: body,
    );
  }

  Future<HTTPResponseModel> resendOTp(
      Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: "auth/resend-otp",
      body: body,
    );
  }
  Future<HTTPResponseModel> resetPassword(
      Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: "auth/reset-password",
      body: body,
    );
  }
  Future<HTTPResponseModel> upDateUser(
      Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.put,
      url: "user/profile",
      body: body,
    );
  }
  Future<HTTPResponseModel> setTransactionPin(
      Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: "user/transaction-pin/set",
      body: body,
    );
  }

  Future<HTTPResponseModel> updateUserProfileImage(
      Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.formData,
      url: "user/profile/image",
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
      url: 'auth/login',
      body: body,
    );
  }

  Future<HTTPResponseModel> getUserProfile() async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: 'user/profile',
    );
  }






}


