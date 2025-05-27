import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  Future<void> setCurrentScreen(String screenName) async {
    await analytics.setCurrentScreen(
      screenName: screenName,
      screenClassOverride: screenName,
    );
  }

  Future<void> sendAnalyticsLog(String logMessage) async {
    await analytics.logEvent(
      name: 'test_event',
      parameters: <String, Object>{
        'category': logMessage,
        'time': DateTime.now().toString(),
        'distinct_id': "",
      },
    );
  }
}
