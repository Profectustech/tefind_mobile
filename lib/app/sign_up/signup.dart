import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saleko/app/sign_up/signup_page_1.dart';
import 'package:saleko/app/widgets/back_button.dart';
import 'package:saleko/app/widgets/sign_in_button.dart';
import 'package:saleko/providers/account_provider.dart';
import 'package:saleko/providers/provider.dart';
import 'package:saleko/services/navigation/navigator_service.dart';
import 'package:saleko/services/navigation/route_names.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:saleko/utils/app_styles.dart';
import 'package:saleko/app/widgets/custom_button.dart';
import 'package:saleko/app/widgets/custom_text_form_field.dart';
import 'package:saleko/utils/assets_manager.dart';
import 'package:saleko/utils/helpers.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final NavigatorService _navigation = NavigatorService();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  late AccountProvider accountProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void logIn() {
    _navigation.navigateTo(loginScreenRoute);
  }

  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 0,
              right: 0,
              child: CustomBackButton(),
            ),
            // Background image
            Positioned.fill(
              child: Image.asset(
                Assets.street,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.5),
            ),
            // Phone mockup image with app screen
            Positioned(
              top: 80,
              left: 80,
              child: Image.asset(
                Assets.iphoneLogo,
                height: 345,
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    CustomButton(
                      label: 'Sign Up',
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Signup1Screen()));
                      },
                    ),
                    SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child:
                              Text("Or", style: TextStyle(color: Colors.grey)),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Apple Sign-In button
                    SignInButton(
                      text: "Continue with Apple",
                      imagePath: Assets.appLogo,
                      onPressed: () {
                        accountProvider.processAppleSignUp();
                      },
                    ),
                    SizedBox(height: 30),
                    // Google Sign-In button
                    SignInButton(
                      text: "Continue with Google",
                      imagePath: Assets.googleLogo,
                      onPressed: () {
                        accountProvider.processGoogleSignUp('signup');
                      },
                    ),
                    SizedBox(height: 40),
                    GestureDetector(
                      onTap: () {
                        _navigation.navigateTo(loginScreenRoute);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already had an account?",
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 10.h,
                          ),
                          GestureDetector(
                            onTap: logIn,
                            child: Text(
                              "Login",
                              style: GoogleFonts.sourceSans3(
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
