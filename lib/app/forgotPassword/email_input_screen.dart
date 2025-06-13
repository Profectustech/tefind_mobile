import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:te_find/app/widgets/custom_button.dart';
import 'package:te_find/app/widgets/custom_text_form_field.dart';
import 'package:te_find/providers/account_provider.dart';
import 'package:te_find/providers/provider.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/helpers.dart';
import 'package:te_find/utils/progress_bar_manager/appbar.dart';

class EmailInputScreen extends ConsumerStatefulWidget {
  const EmailInputScreen({super.key});

  @override
  ConsumerState<EmailInputScreen> createState() => _EmailInputScreenState();
}

class _EmailInputScreenState extends ConsumerState<EmailInputScreen> {
  final NavigatorService _navigation = NavigatorService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late AccountProvider accountProvider;
  final ValueNotifier<bool> _isButtonEnabled = ValueNotifier(false);

  void _updateButtonState() {
    final isEmailNotEmpty = accountProvider.forgotPasswordEmailController.text.isNotEmpty;
    _isButtonEnabled.value = isEmailNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
     // accountProvider = ref.read(RiverpodProvider.accountProvider);
      accountProvider.forgotPasswordEmailController.addListener(_updateButtonState);
      _updateButtonState(); // Initial check
    });
  }

  @override
  void dispose() {
    accountProvider.forgotPasswordEmailController.removeListener(_updateButtonState);
    accountProvider.forgotPasswordEmailController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);

    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: false,
        text: 'Forgot Password',
        onTap: () {},
      ),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/teFindBackground.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Don’t Stress,',
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: AppColors.faintBlack)),
                    SizedBox(height: 5.h),
                    Text('It happens 🤗',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: AppColors.faintBlack)),
                    SizedBox(height: 35.h),
                    Center(
                      child: Text(
                        'Kindly input your email to reset your password',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.faintBlack,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 35.h),
                    CustomTextFormField(
                      label: 'Email',
                      controller: accountProvider.forgotPasswordEmailController,
                      validator: Validators().isEmail,
                    ),
                    SizedBox(height: 100.h),
                    ValueListenableBuilder<bool>(
                      valueListenable: _isButtonEnabled,
                      builder: (context, isEnabled, _) {
                        return CustomButton(
                          label: "Proceed",
                          fillColor: isEnabled ? AppColors.primaryColor : Colors.grey,
                          onPressed: isEnabled
                              ? () {
                            if (_formKey.currentState!.validate()) {
                              accountProvider.forgetPassword();
                            }
                          }
                              : null,
                        );
                      },
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
