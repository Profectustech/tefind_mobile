import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/app/change_password.dart';
import 'package:te_find/app/home/confirmed_payment.dart';
import 'package:te_find/app/home/home_page.dart';
import 'package:te_find/app/login/login_screen.dart';
import 'package:te_find/app/onboarding/onboarding_screen_model.dart';
import 'package:te_find/app/sign_up/signup.dart';
import 'package:te_find/providers/account_provider.dart';
import 'package:te_find/providers/provider.dart';
import 'package:te_find/services/navigation/animated_navigation.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/services/navigation/route_names.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/assets_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utils/screen_size.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final AnimatedNavigation _navigation = AnimatedNavigation();
  final PageController _controller = PageController();
  late AccountProvider accountProvider;

  late final List<OnboardingScreenModel> screens;
  late final int lastPage;

  int currentPage = 0;
  bool isLastPage = false;


  void nextAction() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeIn,
    );
  }

  void signup() {
    _navigation.navigateTo(
      context: context,
      destinationScreen: const Signup(),
      animationDuration: 1200,
    );
  }

  void doneAction() {
    _navigation.navigateTo(
      context: context,
      destinationScreen: const LoginScreen(),
      animationDuration: 1200,
    );
  }

  @override
  void initState() {
    super.initState();
    screens = getScreens();
    lastPage = screens.length - 1;

    _controller.addListener(() {
      setState(() {
        currentPage = _controller.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    accountProvider = ref.watch(RiverpodProvider.accountProvider);

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Image.asset(
                screens[currentPage].image,
                fit: BoxFit.cover,
                height: screenHeight,
                width: screenWidth,
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: Responsive.height(context) * 0.1),
              Center(
                child: Image.asset(
                  Assets.te_findLogo,
                  height: 63.h,
                ),
              ),
             Expanded(
                child: PageView(
                  controller: _controller,
                  onPageChanged: (page) {
                    setState(() {
                      isLastPage = (page == lastPage);
                    });
                  },
                  children: screens.map((screen) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: Responsive.height(context) * 0.49),
                          Text(
                            screen.title,
                            style: TextStyle(
                              fontSize: 24.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: Responsive.height(context) * 0.01),
                          Text(
                            screen.content,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              SmoothPageIndicator(
                controller: _controller,
                count: screens.length,
                effect: ScrollingDotsEffect(
                  spacing: 8.0,
                  dotWidth: 8.0,
                  dotHeight: 8.0,
                  dotColor: Colors.white70,
                  activeDotColor: AppColors.primaryColor
                ),
              ),

              SizedBox(height:Responsive.height(context) * 0.03),
              Center(
                child: MaterialButton(
                  onPressed: () {
                    if (isLastPage) {
                      doneAction();
                    } else {
                      nextAction();
                    }
                  },
                  child: Container(
                    height: screenHeight * 0.07,
                    width: screenWidth * 0.80,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "Next",
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  ),
                ),
              ),
               SizedBox(height:Responsive.height(context) * 0.100),
            ],
          ),
        ],
      ),
    );
  }
}
