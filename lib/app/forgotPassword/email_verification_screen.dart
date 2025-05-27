import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saleko/app/widgets/back_button.dart';
import 'package:saleko/providers/account_provider.dart';
import 'package:saleko/providers/provider.dart';
import 'package:saleko/services/navigation/navigator_service.dart';
import 'package:saleko/services/navigation/route_names.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:saleko/utils/app_styles.dart';
import 'package:saleko/app/widgets/custom_button.dart';
import 'package:saleko/app/widgets/pin_input_field.dart';
import 'package:saleko/utils/helpers.dart';
import 'package:saleko/utils/progress_bar_manager/appbar.dart';

class EmailVerificationScreen extends ConsumerStatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  ConsumerState<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState
    extends ConsumerState<EmailVerificationScreen> {
  final NavigatorService _navigation = NavigatorService();
  late AccountProvider accountProvider;
  // TextEditingController pinController = TextEditingController();

  void login() {
    _navigation.navigateTo(loginScreenRoute);
  }

  bool get isPinFilled => accountProvider.forgotOtpPinController.text.isNotEmpty;
  void logIn() {
    _navigation.navigateTo(loginScreenRoute);
  }


  @override
  void initState() {
    super.initState();
    startTimer();
  }



  int waitTime = 44;
  late Timer timer; // Default wait time in seconds
  bool isTimerFinished = false;
  // Start the countdown timer
  void startTimer() {
    setState(() {
      isTimerFinished = false;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (waitTime > 0) {
          waitTime--;
        } else {
          timer.cancel();
          isTimerFinished = true;
        }
      });
    });
  }

  // Reset the timer and start again
  void resetTimer() {
    setState(() {
      waitTime = 44;
      isTimerFinished = false;
    });
    startTimer(); // Start a new timer
  }

  @override
  void dispose() {
    //accountProvider.forgotOtpPinController.clear();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return Scaffold(
      appBar: CustomAppBar(
          centerTitle: true,
          text: 'Login',
          onTap: () {
            login();
          }),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Confirm your Email",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 20),
              Text(
                "Enter the code sent to the ${accountProvider.usernameController.text}",
           //     textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              SizedBox(height: 40),
              Center(
                  child: PinInputField(
                pinController: accountProvider.forgotOtpPinController,
              )),
              SizedBox(
                height: 30,
              ),
              isTimerFinished
                  ? Center(
                      child: GestureDetector(
                        onTap: () {
                          if (isTimerFinished) {
                            resetTimer();
                            accountProvider.sendForgotPassOTP();
                          }
                        },
                        child: Text(
                          "Send Code Again",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.primaryColor, fontSize: 16),
                        ),
                      ),
                    )
                  : Text(
                      "Didn't receive the verification code? It could take a bit of time, request a new code in $waitTime seconds",
                      textAlign: TextAlign.center,
                    ),
              Spacer(),
              CustomButton(
                fillColor: isPinFilled ? AppColors.primaryColor : Colors.grey,
                label: 'Confirm',
                onPressed: () {
                  if (accountProvider.forgotOtpPinController.text.isNotEmpty) {
                 accountProvider.verifyForgotOtpCode();
                  } else {
                    showErrorToast(message: "Kindly input your OTP");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
