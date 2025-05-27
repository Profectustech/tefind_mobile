import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saleko/app/change_password.dart';
import 'package:saleko/app/home/confirmed_payment.dart';
import 'package:saleko/app/home/home_page.dart';
import 'package:saleko/app/login/login_screen.dart';
import 'package:saleko/app/onboarding/onboarding_screen_model.dart';
import 'package:saleko/app/sign_up/signup.dart';
import 'package:saleko/providers/account_provider.dart';
import 'package:saleko/providers/provider.dart';
import 'package:saleko/services/navigation/animated_navigation.dart';
import 'package:saleko/services/navigation/navigator_service.dart';
import 'package:saleko/services/navigation/route_names.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:saleko/utils/assets_manager.dart';
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
      destinationScreen: const SignupScreen(),
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
                Assets.greenBackground,
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
                child: SvgPicture.asset(
                  Assets.salekoWhite,
                  height: 35,
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
                          SizedBox(height: Responsive.height(context) * 0.08),
                          Container(
                            height: screenHeight * 0.4,
                            width: screenWidth * 0.8,
                            decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.white),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                screen.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: Responsive.height(context) * 0.02),
                          SmoothPageIndicator(
                            controller: _controller,
                            count: screens.length,
                            effect: const ExpandingDotsEffect(
                              spacing: 8.0,
                              dotWidth: 15.0,
                              dotHeight: 8.0,
                              strokeWidth: 1.5,
                              dotColor: Colors.white,
                              activeDotColor: Colors.white,
                            ),
                          ),
                          SizedBox(height: Responsive.height(context) * 0.02),
                          Text(
                            screen.title,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: Responsive.height(context) * 0.01),
                          Text(
                            screen.content,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        onPressed: signup,
                        child: Container(
                          height: screenHeight * 0.06,
                          width: screenWidth * 0.38,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(color: AppColors.primaryColor),
                            ),
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: doneAction,
                        child: Container(
                          height: Responsive.height(context) * 0.06,
                          width: Responsive.height(context) * 0.2,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(width: 1.5, color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                   SizedBox(height:Responsive.height(context) * 0.07),
                  InkWell(
                      onTap: () {
                        print('object');
                        accountProvider.loginAsAGuest();
                      },
                      child:Text(
                          "Skip to home",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
