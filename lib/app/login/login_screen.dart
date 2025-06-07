import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:te_find/services/navigation/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/app/home/home_page.dart';
import 'package:te_find/app/widgets/back_button.dart';
import 'package:te_find/app/widgets/sign_in_button.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/providers/account_provider.dart';
import 'package:te_find/providers/provider.dart';
import 'package:te_find/services/navigation/route_names.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/assets_manager.dart';
import 'package:te_find/utils/helpers.dart';
import 'package:te_find/utils/locator.dart';
import 'package:te_find/utils/notification_helper.dart';
import 'package:te_find/app/widgets/custom_button.dart';
import 'package:te_find/app/widgets/custom_text_form_field.dart';
import 'package:te_find/utils/progress_bar_manager/appbar.dart';

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
        body: SafeArea(
            child: Stack(children: [
          Image.asset(
            'assets/images/teFindBackground.png',
            fit: BoxFit.cover, // Ensures it covers the screen
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 60.h),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          Assets.te_findLogo2,
                          height: 34.h,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text('Sign into your account',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: AppColors.faintBlack)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          label: 'Email',
                          controller:
                              accountProvider.signInPhoneOrEmailController,
                          validator: Validators().isEmail,
                        ),
                        SizedBox(height: 31.h),

                        TextFormField(
                          validator: Validators().isPassword,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(
                                  width: 1, color: AppColors.primaryColor),
                            ),
                            disabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide:
                                  BorderSide(width: 1, color: AppColors.greyLight),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(
                                color: AppColors.greyLight,
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _navigation.navigateTo(emailInputScreenRoute);
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 80.h),

                        CustomButton(
                            label: "Sign In",
                            fillColor:
                                // isFormValid ?
                                AppColors.primaryColor,
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
                                  locator<NavigatorService>().navigateTo(bottomNavigationRoute);
                           //   accountProvider.logIn();
                            }
                            // : null,
                            ),
                        SizedBox(height: 30.h),
                        Row(
                          spacing: 5,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            InkWell(
                              onTap: (){
                                locator<NavigatorService>().navigateTo(signupScreenRoute);
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30.h),
                        Center(
                          child: Image.asset(
                            Assets.fingerPrint,
                            height: 71.h,
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            ),
          ),
        ])));
  }
}
