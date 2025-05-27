import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saleko/services/navigation/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saleko/app/home/home_page.dart';
import 'package:saleko/app/widgets/back_button.dart';
import 'package:saleko/app/widgets/sign_in_button.dart';
import 'package:saleko/services/navigation/navigator_service.dart';
import 'package:saleko/providers/account_provider.dart';
import 'package:saleko/providers/provider.dart';
import 'package:saleko/services/navigation/route_names.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:saleko/utils/assets_manager.dart';
import 'package:saleko/utils/helpers.dart';
import 'package:saleko/utils/notification_helper.dart';
import 'package:saleko/app/widgets/custom_button.dart';
import 'package:saleko/app/widgets/custom_text_form_field.dart';
import 'package:saleko/utils/progress_bar_manager/appbar.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _NewUserLoginScreenState();
}

class _NewUserLoginScreenState extends ConsumerState<LoginScreen> {
  final NavigatorService _navigation = NavigatorService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late AccountProvider accountProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool passwordVisible = true;

  // bool get isFormValid {
  //   return accountProvider.signInPhoneOrEmailController.text.isNotEmpty &&
  //       accountProvider.signInPasswordController.text.isNotEmpty;
  // }

  void signUp() {
    _navigation.navigateTo(signupScreenRoute);
  }

  @override
  void initState() {
    super.initState();
    // Add listener to emailController to track changes
    emailController.addListener(_updateButtonState);
    passwordController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    emailController.removeListener(_updateButtonState);
    passwordController.removeListener(_updateButtonState);
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {}); // Trigger a rebuild whenever the email input changes
  }

  // String? fcmToken;
  // getFCMToken() async {
  //   fcmToken = await NotificationHelper.getFcmToken();
  // }

  // @override
  // void initState() {
  //   Future.microtask(() {
  //     getFCMToken();
  //     accountProvider.getUserLocation();
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
            centerTitle: true,
            text: 'Sign Up',
            onTap: () {
              signUp();
            }),
        body: SafeArea(
            child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Text('Login',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black)),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                      label: 'Email or Phone Number',
                      controller: accountProvider.signInPhoneOrEmailController,
                      validator: Validators().isEmail,
                    ),
                    SizedBox(height: 31.h),

                    TextFormField(
                      validator: Validators().isEmpty,
                      controller: accountProvider.signInPasswordController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.fadedBlack.withOpacity(0.4),
                          ),
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff8391A1),
                        ),
                        fillColor: AppColors.white,
                        filled: true,
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(
                              width: 1, color: AppColors.primaryColor),
                        ),
                        disabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide:
                              BorderSide(width: 1, color: AppColors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(
                            color: AppColors.grey,
                            width: 1.w,
                          ),
                        ),
                        errorStyle: const TextStyle(color: AppColors.red),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(),
                        ),
                      ),
                      onChanged: (v) {},
                      obscureText: passwordVisible,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: Colors.black),
                      cursorColor: Colors.black,
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _navigation.navigateTo(emailInputScreenRoute);
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 80.h),

                    CustomButton(
                      label: "Log In",
                      fillColor:
                          // isFormValid ?
                          AppColors.primaryColor ,
                              // : Colors.grey,
                      onPressed:
                      // isFormValid
                      //     ?
                        () {
                              // if (_formKey.currentState!.validate()) {
                              //
                              //   // _navigation.navigateReplacementTo(
                              //   //     bottomNavigationRoute);
                              //
                              // }
                        accountProvider.logIn();
                            }
                          // : null,
                    ),
                    SizedBox(height: 30.h),
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
                          child: Text("Or",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400)),
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
                        // Apple sign-in logic
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

                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          )),
        )));
  }
}
