import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../providers/account_provider.dart';
import '../../providers/provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/helpers.dart';
import '../../utils/progress_bar_manager/utility_app_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/password_criterial_Indicator.dart';

class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  ConsumerState createState() => _ChangePasswordPageState();
}
TextEditingController emailController = TextEditingController();
TextEditingController phoneController = TextEditingController();
late AccountProvider accountProvider;
bool currentPasswordVisible = true;
bool newPasswordVisible = true;
bool confirmPasswordVisible = true;

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return Scaffold(
      appBar: UtilityAppBar(text: "Change Password", hasActions: true),
          body: SingleChildScrollView(
            child: Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                TextFormField(
                  validator: Validators().isEmpty,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        currentPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.fadedBlack.withOpacity(0.4),
                      ),
                      onPressed: () {
                        setState(() {
                          currentPasswordVisible = !currentPasswordVisible;
                        });
                      },
                    ),
            
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    labelText: "Current Password*",
                    labelStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff8391A1),
                    ),
                    fillColor: Colors.transparent,
                    filled: true,
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                          width: 1, color: AppColors.primaryColor),
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide:
                      BorderSide(width: 1, color: AppColors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                        color: AppColors.grey,
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
                  obscureText: currentPasswordVisible,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                ),
                SizedBox(height: 20.h,),
                TextFormField(
                  validator: Validators().isEmpty,
                  controller: accountProvider.settingPasswordController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        newPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.fadedBlack.withOpacity(0.4),
                      ),
                      onPressed: () {
                        setState(() {
                          newPasswordVisible = !newPasswordVisible;
                        });
                      },
                    ),
            
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    labelText: "New Password*",
                    labelStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff8391A1),
                    ),
                    fillColor: Colors.transparent,
                    filled: true,
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                          width: 1, color: AppColors.primaryColor),
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide:
                      BorderSide(width: 1, color: AppColors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                        color: AppColors.grey,
                        width: 1.w,
                      ),
                    ),
                    errorStyle: const TextStyle(color: AppColors.red),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(),
                    ),
                  ),
                  onChanged: (v) {
                    accountProvider.validatePassword2();
                  },
                  obscureText: newPasswordVisible,
                  keyboardType: TextInputType.text,
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
            
                SizedBox(height: 20.h,),
                TextFormField(
                  validator: Validators().isEmpty,
            
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        confirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.fadedBlack.withOpacity(0.4),
                      ),
                      onPressed: () {
                        setState(() {
                          confirmPasswordVisible = !confirmPasswordVisible;
                        });
                      },
                    ),
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    labelText: "ConfirmNew Password*",
                    labelStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff8391A1),
                    ),
                    fillColor: Colors.transparent,
                    filled: true,
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                          width: 1, color: AppColors.primaryColor),
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide:
                      BorderSide(width: 1, color: AppColors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                        color: AppColors.grey,
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
                  obscureText: confirmPasswordVisible,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                ),
            
                  SizedBox(height: 30.h,),
            
                  CustomButton(
                    label: "Change Password",
                    fillColor:
                         AppColors.primaryColor,
            
                    onPressed: (){},
                  ),
            
            
            
                ],),),
          ),
    );
  }
}
