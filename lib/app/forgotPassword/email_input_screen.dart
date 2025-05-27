import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:saleko/app/forgotPassword/email_verification_screen.dart';
import 'package:saleko/app/widgets/back_button.dart';
import 'package:saleko/providers/account_provider.dart';
import 'package:saleko/providers/provider.dart';
import 'package:saleko/services/navigation/navigator_service.dart';
import 'package:saleko/services/navigation/route_names.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:saleko/utils/app_styles.dart';
import 'package:saleko/app/widgets/custom_button.dart';
import 'package:saleko/app/widgets/custom_text_form_field.dart';
import 'package:saleko/utils/helpers.dart';
import 'package:saleko/utils/progress_bar_manager/appbar.dart';

class EmailInputScreen extends ConsumerStatefulWidget {
  const EmailInputScreen({super.key});

  @override
  ConsumerState<EmailInputScreen> createState() => _EmailInputScreenState();
}

class _EmailInputScreenState extends ConsumerState<EmailInputScreen> {
  final NavigatorService _navigation = NavigatorService();
  TextEditingController emailController = TextEditingController();
  late AccountProvider accountProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // A boolean to check if the email field is not empty
  bool get isEmailFilled => accountProvider.usernameController.text.isNotEmpty;


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
      appBar: CustomAppBar(centerTitle: true, text: '', onTap: () {}),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "No worries, we’ll send you OTP to reset your password.",
                        style: TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(height: 32.h),
                      Text(
                        "Email or Phone number",
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 10),
                      CustomTextFormField(
                        hint: 'Enter email or phone number',
                        controller: accountProvider.usernameController,
                        validator: Validators().isEmail,
                      ),
                      SizedBox(height: 100.h),
                      CustomButton(
                        fillColor: isEmailFilled
                            ? AppColors.primaryColor
                            : Colors.grey,
                        label: 'Send Code',
                        onPressed: isEmailFilled
                            ? () {
                                if (_formKey.currentState!.validate()) {
                                  accountProvider.sendForgotPassOTP();

                                }
                              }
                            : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
