import 'dart:io';

import 'package:saleko/models/util_model.dart';
import 'package:saleko/repository/network_helper.dart';
import 'package:saleko/utils/enums.dart';

class PaymentRepository {
  final NetworkHelper _networkHelper = NetworkHelper();

  Future<HTTPResponseModel> verifyPayment(Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: "main-svc-v2/payment/verify",
      body: body,
    );
  }

  Future<HTTPResponseModel> initiatePayment(num cartId) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: "main-svc-v2/payment/initiate/unified/blusalt",
      body: {"cart_id": cartId},
    );
  }
}
