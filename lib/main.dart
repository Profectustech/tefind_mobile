import 'dart:io';
import 'package:te_find/providers/account_provider.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/services/navigation/router.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/locator.dart';
import 'package:te_find/utils/progress_bar_manager/dialog_manager.dart';
import 'package:te_find/utils/progress_bar_manager/dialog_service.dart';
import 'package:te_find/utils/storage_util.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'app/splashScreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  StorageUtil.createSharedPref();
  setupLocator();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late FirebaseMessaging messaging;
  late AndroidNotificationChannel channel;
  late AccountProvider accountProvider;

  void selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(builder: (context) => const BottomNavigation()),
    // );
  }

  displayDialog(String title, String body) {
    return showTopSnackBar(
      Overlay.of(NavigatorService.navigationKey_.currentContext!),
      CustomSnackBar.info(
        backgroundColor: AppColors.primaryColor,
        message: "$title\n$body",
      ),
    );
  }

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  void registerNotification() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            // onDidReceiveLocalNotification: (int id, String? title, String? body,
            //     String? payload) async {}
        );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {},
    );

    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    //String initialRoute = HomePage.routeName;
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      //selectedNotificationPayload = notificationAppLaunchDetails!.notificationResponse?.payload;
      // initialRoute = SecondPage.routeName;
    }

    // Update the iOS foreground notification presentation options to allow
    // heads up notifications.

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      if (kDebugMode) {
        print("message received");
      }
      if (kDebugMode) {
        print(event.notification?.body);
      }
      displayDialog(
          '${event.notification?.title}', '${event.notification?.body}');
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {});
  }

  Future<void> _messageHandler(RemoteMessage message) async {
    if (kDebugMode) {
      print('Handling a background message ${message.messageId}');
    }
    if (kDebugMode) {
      print('background message ${message.notification?.body}');
    }
  }


  @override
  void initState() {
    Future.microtask(() {
       accountProvider.initUserLocation();
        accountProvider.startListeningToLocation();
    });

    if (!Platform.isIOS) {
    //  Firebase.initializeApp();
      Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: "AIzaSyBeG0XeJ4MNGfJB6-DZUsZGYp84FQ0MO_w",
          appId: "1:850971239862:android:5e0b133f0dc7a552488d17",
          messagingSenderId: "850971239862",
          projectId: "tefind-63f5c",
        ),
      );
    } else {
      Firebase.initializeApp();
    }

    registerNotification();
     FirebaseMessaging.onBackgroundMessage(_messageHandler);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(360, 800),
      minTextAdapt: true,
      builder: (context, child) {
        return StyledToast(
          locale: const Locale('en', 'US'),
          toastAnimation: StyledToastAnimation.slideFromTop,
          reverseAnimation: StyledToastAnimation.fade,
          toastPositions: StyledToastPosition.top,
          animDuration: const Duration(seconds: 1),
          duration: const Duration(seconds: 7),
          curve: Curves.elasticOut,
          reverseCurve: Curves.fastLinearToSlowEaseIn,
          dismissOtherOnShow: true,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              dialogTheme: const DialogTheme(
                backgroundColor: Colors.white,
              ),
              bottomSheetTheme: const BottomSheetThemeData(
                backgroundColor: Color(0xFFFFFF)
              ),
              scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
              bottomNavigationBarTheme:
                  BottomNavigationBarThemeData(backgroundColor: Colors.white),
              textTheme: GoogleFonts.poppinsTextTheme(
                Theme.of(context).textTheme,

            ),
              // colorScheme:
              //     ColorScheme.fromSeed(seedColor: AppColors.white),
              useMaterial3: true,
              appBarTheme: const AppBarTheme(
                  centerTitle: true,
                  color: Color(0xFFFFFFFF),
                  elevation: 0.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Color(0xFFFFFFFF),
                    statusBarBrightness: Brightness.light,
                    statusBarIconBrightness: Brightness.dark,
                  )),
            ),
            // theme: ThemeData(
            //   colorScheme:
            //       ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
            //   useMaterial3: true,
            // ),
            builder: (context, child) => Navigator(
              key: locator<ProgressService>().progressNavigationKey,
              onGenerateRoute: (settings) =>
                  MaterialPageRoute(builder: (context) {
                return ProgressManager(
                  child: child!,
                );
              }),
            ),
            navigatorKey: locator<NavigatorService>().navigationKey,
            home: SplashScreen(),
            onGenerateRoute: generateRoute,
          ),
        );
      },
    );
  }
}
