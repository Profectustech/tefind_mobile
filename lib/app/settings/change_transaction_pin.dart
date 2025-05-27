import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saleko/app/settings/create_transaction_pin.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:saleko/utils/progress_bar_manager/utility_app_bar.dart';

import '../../providers/account_provider.dart';
import '../../providers/provider.dart';
import '../../utils/helpers.dart';
import '../widgets/custom_button.dart';
import '../widgets/pin_input_field.dart';

class ChangeTransactionPin extends ConsumerStatefulWidget {
  const ChangeTransactionPin({super.key});

  @override
  ConsumerState createState() => _ChangeTransactionPinState();
}

class _ChangeTransactionPinState extends ConsumerState<ChangeTransactionPin> {

  late Timer timer;
  int waitTime = 90; // Default wait time in seconds
  bool isTimerFinished = false;

  @override
  void initState() {
    super.initState();
    startTimer();

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
      waitTime = 90;
      isTimerFinished = false;
    });
    startTimer(); // Start a new timer
  }

  late AccountProvider accountProvider;
  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return Scaffold(
      appBar: UtilityAppBar(text: 'Create Transaction PIN',),
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20), 
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 20.h,),
            Text("Create Transaction PIN", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.primaryColor,)),
            SizedBox(height: 10.h,),
            Text("We'll send a code to the phone number you used to\nregister your account, to make sure it's really you.", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.grey,), textAlign: TextAlign.center),
            Text("+234 (80) 2314 ****", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.grey,)),
            SizedBox(height: 30.h,),
            Text("Input OTP", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.grey,)),
            SizedBox(height: 10.h,),
            PinInputField(
            pinNumber: 4,

          ),
            SizedBox(height: 50.h,),
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
            : Text("Resend code in 00:$waitTime", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.primaryColor,)),
            SizedBox(height: 30.h,),
            CustomButton(
              fillColor: AppColors.primaryColor,
              label: 'Continue',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateTransactionPin()));
                // if (accountProvider.pinController.text.isNotEmpty) {
                //   accountProvider.verifyOtpCode();
                // } else {
                //   showErrorToast(message: "Kindly input your OTP");
                // }
              },
            ),
          ],
        ),
      ),),
    );
  }
}
