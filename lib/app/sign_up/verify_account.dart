import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

class VerificationScreen extends ConsumerStatefulWidget {
  const VerificationScreen({super.key});

  @override
  ConsumerState<VerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends ConsumerState<VerificationScreen> {
  final NavigatorService _navigation = NavigatorService();
  late AccountProvider accountProvider;
  TextEditingController pinController = TextEditingController();

  int waitTime = 100;
  late Timer timer;

  void handleSubmit() {
    _navigation.navigateTo(loginScreenRoute);
  }

  void handleOnTap() {
    setState(() {
      waitTime = 100;
    });
    startTimer();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    // Create a timer that updates every second
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (waitTime > 0) {
          waitTime--;
        } else {
          // Stop the timer when it reaches 0
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return Scaffold(
      backgroundColor: AppColors.greenSecond,
      body: SafeArea(
          child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Container(
                      height: 220,
                      child: Stack(
                        children: [
                          CustomBackButton(),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: SvgPicture.asset(
                                'assets/images/svg.logo.png',
                              )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 70.h),
                              Container(
                                padding: EdgeInsets.only(left: 20),
                                width: 300,
                                child: Text("Verify Account!",
                                    style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.white)),
                              ),
                              Container(
                                padding: EdgeInsets.all(20),
                                width: 350,
                                child: Text(
                                    "Enter 4-digit Code code we have sent to at +23489906056.",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.white)),
                              )
                            ],
                          ),
                        ],
                      )),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        PinInputField(
                          pinController: pinController,
                        ),
                        SizedBox(height: 100.h),
                        Center(
                            child: Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  gradient: RadialGradient(
                                    center: Alignment(
                                      0.9,
                                      -0.9,
                                    ),
                                    colors: [
                                      Colors.grey.shade400,
                                      AppColors.secondaryColor,
                                      AppColors.secondaryColor,
                                      AppColors.secondaryColor,
                                    ],
                                    radius: 4.0,
                                  ),
                                  //  color: Color(0xff16275D),
                                  // color: Color(0xff21093A),
                                  border: Border.all(
                                      width: 2, color: AppColors.green),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                                width: 350,
                                height: 250,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: CustomButton(
                                          fillColor: AppColors.primaryColor,
                                          label: 'Verify',
                                          onPressed: () {
                                            if (pinController.text.isNotEmpty) {
                                              _navigation.navigateTo(
                                                  setPasswordScreenRoute);
                                            } else {
                                              showErrorToast(message:
                                                  "Kindly input your OTP");
                                            }
                                          },
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                        onTap: () {},
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Didn’t receive the code? ',
                                              style: AppStyles
                                                  .createNormalTextStyle(
                                                textColor: AppColors.white,
                                              ),
                                            ),
                                            Text(
                                              'Resend',
                                              style: TextStyle(
                                                  color: AppColors.white,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationColor: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )),
                                  ],
                                ))),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              )))),
    );
  }
}
