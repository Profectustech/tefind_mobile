import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:te_find/app/widgets/bottom_modals.dart';
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
import 'package:te_find/utils/notification_helper.dart';
import 'package:te_find/app/widgets/custom_button.dart';
import 'package:te_find/app/widgets/custom_text_form_field.dart';
import 'package:te_find/utils/progress_bar_manager/appbar.dart';

import '../../utils/locator.dart';

class Signup extends ConsumerStatefulWidget {
  const Signup({super.key});

  @override
  ConsumerState<Signup> createState() => _SignupState();
}

class _SignupState extends ConsumerState<Signup> {
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
  void dispose() {
    super.dispose();
  }



  String? fcmToken;
  getFCMToken() async {
    fcmToken = await NotificationHelper.getFcmToken();
  }

  @override
  void initState() {
    Future.microtask(() {
      getFCMToken();
      print("FCM Token: $fcmToken");
    });
    super.initState();
  }

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
            padding: EdgeInsets.symmetric(vertical: 40.h),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
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
                        Text('Sign up to start buying\n& selling',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: AppColors.faintBlack)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          label: 'Email',
                          controller: accountProvider.signUpEmailController,
                          validator: Validators().isEmail,
                        ),
                        SizedBox(height: 70.h),
                        CustomButton(
                            label: "Sign Up",
                            fillColor:
                                // isFormValid ?
                                AppColors.primaryColor,
                            // : Colors.grey,
                            onPressed:
                                // isFormValid
                                //     ?
                                () {
                              accountProvider.startRegistration();
                              // if (_formKey.currentState!.validate()) {
                              //   accountProvider.startRegistration();
                              //
                              // }
                            }
                            // : null,
                            ),
                        SizedBox(height: 15.h),
                        Row(
                          spacing: 5,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already had an account?',
                              style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            InkWell(
                              onTap: () {
                                locator<NavigatorService>()
                                    .navigateTo(loginScreenRoute);
                              },
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
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
