import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:te_find/repository/auth_repository.dart';
import 'package:te_find/services/analytics_service.dart';
import 'package:te_find/services/dialog_service.dart';
import 'package:te_find/utils/base_model.dart';
import 'package:te_find/utils/progress_bar_manager/dialog_service.dart';

import '../services/navigation/navigator_service.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => BaseModel());
  locator.registerLazySingleton(() => NavigatorService());
  locator.registerLazySingleton(() => AnalyticsService());
  locator.registerLazySingleton(() => ProgressService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AuthRepository());
}
