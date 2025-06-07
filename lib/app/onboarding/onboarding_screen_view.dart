import 'package:carousel_slider/carousel_slider.dart';
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
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentIndex = 0;
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
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    accountProvider = ref.watch(RiverpodProvider.accountProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
          child: Column(
            children: [
             SizedBox(height: 60.h,),
              Center(
                child: Image.asset(
                  Assets.te_findLogo2,
                  height: 34.h,
                ),
              ),
              SizedBox(height: Responsive.height(context) * 0.05),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: screens.length,
                  onPageChanged: (index) {
                    setState(() {
                      isLastPage = index == screens.length - 1;
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    double scale = _currentIndex == index ? 1.0 : 0.9;
                    return TweenAnimationBuilder(
                      duration: Duration(milliseconds: 350),
                      tween: Tween<double>(begin: scale, end: scale),
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 280.h,
                                width: 280.w,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    screens[index].image,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              SizedBox(height: 50.h),
                              Text(
                                screens[index].title,
                                style: GoogleFonts.poppins(
                                  fontSize: 24.sp,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                screens[index].content,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: AppColors.lightTextBlack,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              SmoothPageIndicator(
                controller: _controller,
                count: screens.length,
                effect: ScrollingDotsEffect(
                  spacing: 8.0,
                  dotWidth: 8.0,
                  dotHeight: 8.0,
                  dotColor: AppColors.greyLight,
                  activeDotColor: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 35.h),
              MaterialButton(
                onPressed: () {
                  if (isLastPage) {
                    doneAction();
                  } else {
                    _controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
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
                      isLastPage ? "Get Started" : "Next",
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Responsive.height(context) * 0.08),
            ],
          ),
        ),
      ),
    );
  }
}
