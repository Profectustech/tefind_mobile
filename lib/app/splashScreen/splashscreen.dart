import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:te_find/app/onboarding/onboarding_screen_view.dart';
import 'package:te_find/providers/account_provider.dart';
import 'package:te_find/providers/provider.dart';
import 'package:te_find/services/navigation/animated_navigation.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/storage_util.dart';

import '../../utils/assets_manager.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AccountProvider accountProvider;
  final AnimatedNavigation _navigation = AnimatedNavigation();
  late AnimationController animationController;
  late Animation<Offset> topBounceAnimation;
  late Animation<Offset> bottomSlideAnimation;

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 4));
    navigationPage();
  }

  void navigationPage() async {
    var id = await StorageUtil.getData("profile");
    if (id != null) {
      goToExistingUserLogin();
    } else {
      goToOnboarding();
    }
  }

  void goToOnboarding() {
    _navigation.navigateTo(
      context: context,
      destinationScreen: const OnboardingScreen(),
    );
  }

  void goToExistingUserLogin() {
    accountProvider.alreadyLoggedIn();
  }

  @override
  void initState() {
    super.initState();
    // Future.microtask(() {
    //   accountProvider.initUserLocation();
    //   accountProvider.startListeningToLocation();
    // });
    init();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Bounce in from top
    topBounceAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.bounceOut,
    ));

    // Slide in from bottom
    bottomSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    ));

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/teFindBackground.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideTransition(
                  position: topBounceAnimation,
                  child: Image.asset(
                    'assets/images/app_icon.png',
                    scale: 5.0,
                  ),
                ),
                SizedBox(height: 10.h),
                SlideTransition(
                  position: bottomSlideAnimation,
                  child: Image.asset(
                    Assets.te_findLogo2,
                    height: 45.h,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
