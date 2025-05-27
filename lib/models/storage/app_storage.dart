///this class is to keep track of storage used
///This will make it easier to know that is stored
class AppStorage {
  AppStorage._();

  static const minVersion = 1; //any version less than this should be cleared.
  static const version = 'version';

  static const appSettings = 'app_settings';
  static const frequentAddress = 'frequent_address';
  static const securitySettings = 'security_settings';
  static const user = 'user';
  static const userToken = 'user_token';
}
