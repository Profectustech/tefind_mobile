import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saleko/app/forgotPassword/successful_reset_page.dart';
import 'package:saleko/app/widgets/custom_button.dart';
import 'package:saleko/providers/account_provider.dart';
import 'package:saleko/providers/provider.dart';
import 'package:saleko/services/navigation/navigator_service.dart';
import 'package:saleko/services/navigation/route_names.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:saleko/utils/progress_bar_manager/appbar.dart';

import '../widgets/password_criterial_Indicator.dart';

class SetNewPassword extends ConsumerStatefulWidget {
  const SetNewPassword({super.key});

  @override
  ConsumerState<SetNewPassword> createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends ConsumerState<SetNewPassword> {
  TextEditingController passwordController = TextEditingController();

  bool get isPasswordFilled =>
      accountProvider.passwordController.text.isNotEmpty;

  late AccountProvider accountProvider;
  final _formKey = GlobalKey<FormState>();
  final NavigatorService _navigation = NavigatorService();

  void login() {
    _navigation.navigateTo(loginScreenRoute);
  }

  bool passwordVisible = true;
  bool isnotChecked = false;

  void handleSignup() {

  }
@override
  void dispose() {
    accountProvider.passwordController.clear();
  }
  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          centerTitle: false,
          text: 'Login',
          onTap: () {
            login();
          }),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Set new password",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Password",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                  ),
                  SizedBox(height: 20.h),
                  TextFormField(
                    controller: accountProvider.passwordController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
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
                      hintText: '******',
                      hintStyle: const TextStyle(color: Colors.grey),
                      fillColor: AppColors.white,
                      filled: true,
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            width: 1, color: AppColors.secondaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: AppColors.buttonDisabled.withOpacity(0.3),
                          width: 1.6.h,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: (v) {
                      accountProvider.validatePassword();
                    },
                    obscureText: passwordVisible,
                    style: const TextStyle(color: Colors.black),
                    cursorColor: Colors.black,
                  ),
                  SizedBox(height: 30),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      buildCriteriaIndicator(
                          "8 characters", accountProvider.criteria1Satisfied),
                      buildCriteriaIndicator(
                          "Uppercase", accountProvider.hasUppercaseLetter),
                      buildCriteriaIndicator(
                          "Lowercase", accountProvider.hasLowercaseLetter),
                      buildCriteriaIndicator(
                          "Number", accountProvider.hasNumber),
                      buildCriteriaIndicator(
                          "Special Character", accountProvider.hasSymbol),
                    ],
                  ),
                  SizedBox(height: 30),
                  CustomButton(
                    label: "Reset Password",
                    fillColor: isPasswordFilled
                        ? AppColors.primaryColor
                        : AppColors.grey,
                    onPressed: (){
                      if (_formKey.currentState?.validate() ?? false) {
                        accountProvider.resetPassword(accountProvider.passwordController.text);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}