import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saleko/app/change_password.dart';
import 'package:saleko/app/widgets/custom_button.dart';
import 'package:saleko/services/navigation/navigator_service.dart';
import 'package:saleko/services/navigation/route_names.dart';
import 'package:saleko/utils/app_colors.dart';

class SuccessfulResetPage extends StatelessWidget {
  SuccessfulResetPage({super.key});
  final NavigatorService _navigation = NavigatorService();

  void handleSubmit() {
    _navigation..navigateReplacementTo(loginScreenRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/successful.gif'),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Password Reset Successfully",
              style: GoogleFonts.sourceSans3(
                  textStyle:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 30.h,
            ),
            Text(
              "The password has been successfully reset, you\ncan log in back with a new password",
              textAlign: TextAlign.center,
              style:
                  GoogleFonts.sourceSans3(textStyle: TextStyle(fontSize: 16)),
            ),
            SizedBox(
              height: 30.h,
            ),
            CustomButton(
                label: "Go to Login",
                fillColor: AppColors.primaryColor,
                onPressed: handleSubmit),
          ],
        ),
      ),
    );
  }
}
