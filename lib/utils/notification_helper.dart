import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class NotificationHelper {
  late Stream<String> tokenStream;
  late String gToken;

  setToken(String token) {
    if (kDebugMode) {
      print('FCM Token: $token');
    }
  }

  static getFcmToken() async {
    var deviceToken = FirebaseMessaging.instance.getToken();
    return deviceToken;
  }
}
