import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:te_find/app/widgets/back_button.dart';
import 'package:te_find/app/widgets/bottom_modals.dart';
import 'package:te_find/app/widgets/custom_bottom_sheet.dart';
import 'package:te_find/providers/account_provider.dart';
import 'package:te_find/providers/provider.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/services/navigation/route_names.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/app_styles.dart';
import 'package:te_find/app/widgets/custom_button.dart';
import 'package:te_find/app/widgets/custom_text_form_field.dart';
import 'package:te_find/utils/helpers.dart';
import 'package:te_find/utils/progress_bar_manager/appbar.dart';

import '../../utils/assets_manager.dart';
import '../widgets/pin_input_field.dart';

class SetNewPassword extends ConsumerStatefulWidget {
  const SetNewPassword({super.key});

  @override
  ConsumerState<SetNewPassword> createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends ConsumerState<SetNewPassword> {
  final NavigatorService _navigation = NavigatorService();
  TextEditingController emailController = TextEditingController();
  late AccountProvider accountProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // A boolean to check if the email field is not emptys
  bool get isEmailFilled => accountProvider.usernameController.text.isNotEmpty;
  bool passwordVisible = true;
  bool confPasswordVisible = true;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      accountProvider.usernameController.addListener(_updateButtonState);
    });
  }

  @override
  void dispose() {
    accountProvider.usernameController.clear();
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {
      isEmailFilled;
    }); // Trigger a rebuild whenever the email input changes
  }

  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);

    return Scaffold(
        appBar: CustomAppBar(
            centerTitle: false, text: 'Reset Password', onTap: () {}),
        backgroundColor: AppColors.white,
        body: SafeArea(
            child: Stack(children: [
              Image.asset(
                'assets/images/teFindBackground.png',
                fit: BoxFit.cover, // Ensures it covers the screen
              ),
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Don’t Stress,',
                              style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.faintBlack)),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text('It happens 🤗',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.faintBlack)),
                          SizedBox(
                            height: 35.h,
                          ),
                          Center(
                            child: Text(
                                'Kindly input your email to reset your password',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.faintBlack)),
                          ),
                          SizedBox(
                            height: 35.h,
                          ),
                          TextFormField(
                            validator: Validators().isPassword,
                           // controller: accountProvider.signInPasswordController,
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
                          SizedBox(height: 40.h,),
                          TextFormField(
                            validator: Validators().isPassword,
                           // controller: accountProvider.signInPasswordController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  confPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: AppColors.fadedBlack.withOpacity(0.4),
                                ),
                                onPressed: () {
                                  setState(() {
                                    confPasswordVisible = !confPasswordVisible;
                                  });
                                },
                              ),
                              hintText: 'Confirm Password',
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                              labelText: "Confirm Password",
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
                            obscureText: confPasswordVisible,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(color: Colors.black),
                            cursorColor: Colors.black,
                          ),
                          SizedBox(height: 100.h),
                          CustomButton(
                              label: "Proceed",
                              fillColor:
                              // isFormValid ?
                              AppColors.primaryColor,
                              // : Colors.grey,
                              onPressed: () {
                                BottomModals.validatePasswordPin(context: context);
                                NavigatorService().navigateReplacementTo(loginScreenRoute);
                              }),

                        ],
                      ),
                    )),
              ),
            ])));
  }
}
