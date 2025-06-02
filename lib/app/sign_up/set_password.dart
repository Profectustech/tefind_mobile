import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/app/widgets/back_button.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/services/navigation/route_names.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/app/widgets/custom_button.dart';
import 'package:te_find/utils/helpers.dart';

class SetPasswordScreen extends ConsumerStatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  ConsumerState<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends ConsumerState<SetPasswordScreen> {
  final NavigatorService _navigation = NavigatorService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController pinController = TextEditingController();
  TextEditingController pinController2 = TextEditingController();

  bool passwordVisible = true;
  bool passwordVisible2 = true;

  bool _loading = false;

  void goBackToLogin() async {
    setState(() {
      _loading = !_loading;
    });
    await Future.delayed(const Duration(seconds: 4));
    _navigation.navigateTo(loginScreenRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenSecond,
      body: SafeArea(
          child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomBackButton(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30.h),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        width: 300,
                        child: Text("Create your password",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white)),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        width: 350,
                        child: Text("Your password should be unique.",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white)),
                      )
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Create Password",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          validator: Validators().isEmpty,
                          controller: pinController,
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
                            hintText: '******',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                            // labelText: "New Password",
                            labelStyle: GoogleFonts.urbanist(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff8391A1),
                            ),
                            fillColor: AppColors.white,
                            filled: true,
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  width: 1, color: AppColors.secondaryColor),
                            ),
                            disabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  width: 1, color: AppColors.shadowGrey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color:
                                    AppColors.buttonDisabled.withOpacity(0.3),
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
                            setState(() {});
                          },
                          obscureText: passwordVisible,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(color: Colors.black),
                          cursorColor: Colors.black,
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          "Confirm Password",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          validator: Validators().isEmpty,
                          controller: pinController2,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                passwordVisible2
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.fadedBlack.withOpacity(0.4),
                              ),
                              onPressed: () {
                                setState(() {
                                  passwordVisible2 = !passwordVisible2;
                                });
                              },
                            ),
                            hintText: '******',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                            //labelText: "Confirm Password",
                            labelStyle: GoogleFonts.urbanist(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff8391A1),
                            ),
                            fillColor: AppColors.white,
                            filled: true,
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  width: 1, color: AppColors.secondaryColor),
                            ),
                            disabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  width: 1, color: AppColors.shadowGrey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color:
                                    AppColors.buttonDisabled.withOpacity(0.3),
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
                            setState(() {});
                          },
                          obscureText: passwordVisible,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(color: Colors.black),
                          cursorColor: Colors.black,
                        ),
                        SizedBox(height: 50.h),
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
                                height: 180,
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
                                          label: 'Login',
                                          onPressed: () {
                                            _navigation
                                                .navigateTo(loginScreenRoute);
                                          },
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
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
