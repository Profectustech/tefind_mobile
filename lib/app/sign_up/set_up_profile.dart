import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:saleko/app/widgets/custom_button.dart';
import 'package:saleko/app/widgets/custom_text_form_field.dart';
import 'package:saleko/providers/account_provider.dart';
import 'package:saleko/providers/provider.dart';
import 'package:saleko/services/navigation/navigator_service.dart';
import 'package:saleko/services/navigation/route_names.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:saleko/utils/helpers.dart';
import 'package:saleko/utils/progress_bar_manager/appbar.dart';

class SetUpProfile extends ConsumerStatefulWidget {
  const SetUpProfile({super.key});

  @override
  ConsumerState<SetUpProfile> createState() => _SetUpProfileState();
}

class _SetUpProfileState extends ConsumerState<SetUpProfile> {
  late AccountProvider accountProvider;
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = true;


  void handleSignup() {
    if (_formKey.currentState?.validate() ?? false) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              children: [
                Image.asset('assets/images/successful.gif'),
                Center(
                    child: Text(
                  "Welcome to Saleko!",
                  style: TextStyle(fontSize: 15, color: AppColors.primaryColor),
                )),
              ],
            ),
            content: Text(
              "Your account has been successfully created. Start exploring unique items from trusted vendors right away!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
            actions: [
              CustomButton(
                fillColor: AppColors.primaryColor,
                onPressed: () {
                  Navigator.pop(context);
                  NavigatorService().pushNamedAndRemoveUntil(loginScreenRoute);
                },
                label: "Go to Home",
              )
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(centerTitle: true, text: 'Sign up', onTap: () {}),
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
                    "Set Up your profile",
                    style: GoogleFonts.sourceSans3(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24)),
                  ),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    controller: accountProvider.firstNameController,
                    hint: "First Name*",
                    validator: Validators().isSignUpEmpty,
                  ),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    controller: accountProvider.lastNameController,
                    hint: "Last Name*",
                    validator: Validators().isSignUpEmpty,
                  ),
                  SizedBox(height: 20),
                  accountProvider.emailPhone == 'Email Address'
                      ? CustomTextFormField(
                          label: "Email Address",
                          controller: accountProvider.emailController,
                          hint: "Email Address*",
                          validator: Validators().isEmail)
                      : IntlPhoneField(
                          controller: accountProvider.phoneController,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          initialCountryCode: 'NG',
                          onChanged: (phone) {},
                        ),
                  SizedBox(height: 20),
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
                      labelStyle: GoogleFonts.urbanist(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff8391A1),
                      ),
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
                      errorStyle: const TextStyle(color: AppColors.red),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(),
                      ),
                    ),
                    onChanged: (v) {
                      accountProvider.validatePassword();
                    },
                    obscureText: passwordVisible,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: Colors.black),
                    cursorColor: Colors.black,
                  ),
                  SizedBox(height: 30),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _buildCriteriaIndicator(
                          "8 characters", accountProvider.criteria1Satisfied),
                      _buildCriteriaIndicator(
                          "Uppercase", accountProvider.hasUppercaseLetter),
                      _buildCriteriaIndicator(
                          "Lowercase", accountProvider.hasLowercaseLetter),
                      _buildCriteriaIndicator(
                          "Number", accountProvider.hasNumber),
                      _buildCriteriaIndicator(
                          "Special Character", accountProvider.hasSymbol),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Checkbox(
                        value: accountProvider.acceptTerms,
                        onChanged: (bool? value) {
                          setState(() {
                            accountProvider.acceptTerms = value!;
                          });
                        },
                      ),
                      Text("I accept the"),
                      SizedBox(width: 5.h),
                      Text(
                        "Terms & condition and Privacy Notice.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  CustomButton(
                      label: "Sign up",
                      fillColor: accountProvider.firstNameController.text.isNotEmpty || accountProvider.lastNameController.text.isNotEmpty || accountProvider.passwordController.text.isNotEmpty
                          ? AppColors.primaryColor
                          : AppColors.grey,
                      onPressed: ()
                      async{
                        bool isSuccess = await accountProvider.completeSignUp();
                        if (isSuccess) {
                          handleSignup();
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCriteriaIndicator(String label, bool isValid) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isValid ? AppColors.primaryColor : AppColors.shadowGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 4),
          if (isValid) Icon(Icons.check, color: Colors.white, size: 16),
        ],
      ),
    );
  }
}
