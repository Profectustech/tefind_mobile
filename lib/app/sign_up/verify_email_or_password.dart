import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saleko/app/widgets/pin_input_field.dart';
import 'package:saleko/providers/account_provider.dart';
import 'package:saleko/providers/provider.dart';
import 'package:saleko/services/navigation/navigator_service.dart';
import 'package:saleko/services/navigation/route_names.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:saleko/app/widgets/custom_button.dart';
import 'package:saleko/utils/helpers.dart';
import 'package:saleko/utils/progress_bar_manager/appbar.dart';

class VerifyEmailOrPassword extends ConsumerStatefulWidget {

  VerifyEmailOrPassword(
      {super.key,});

  @override
  _VerifyEmailOrPasswordState createState() => _VerifyEmailOrPasswordState();
}

class _VerifyEmailOrPasswordState extends ConsumerState<VerifyEmailOrPassword> {
  final NavigatorService _navigation = NavigatorService();

  void login() {
    _navigation.navigateTo(loginScreenRoute);
  }

   String? title;
  String? message;
  late Timer timer;
  int waitTime = 44; // Default wait time in seconds
  bool isTimerFinished = false;

  @override
  void initState() {
    super.initState();
    startTimer();
    Future.microtask(() {
      title = accountProvider.emailPhone == 'Email Address'
          ? 'Confirm Email'
          : 'Confirm Phone Number';
      message = accountProvider.emailPhone == 'Email Address'
          ? 'We have sent a verification code to ${accountProvider.emailController.text}'
          : 'We have sent a verification code to ${accountProvider.phoneController.text}';
    });


  }




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

  late AccountProvider accountProvider;

  @override
  void dispose() {
    // Dispose of the timer when the widget is destroyed
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          centerTitle: true,
          text: 'Login',
          onTap: () {
            login();
          }),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? "",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              SizedBox(height: 20),
              Text(
                message ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 40),
              Center(
                  child: PinInputField(
                    pinNumber: 6,
                pinController: accountProvider.pinController,
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
                          }
                        },
                        child: Text(
                          "Send Code Again",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 14.56,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    )
                  : Text(
                      "Didn't receive the verification code? It could take a bit of time, request a new code in $waitTime seconds",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
              Spacer(),
              CustomButton(
                fillColor: AppColors.primaryColor,
                label: 'Confirm',
                onPressed: () {
                  if (accountProvider.pinController.text.isNotEmpty) {
                    accountProvider.verifyOtpCode();
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
