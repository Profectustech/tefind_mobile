import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/app/widgets/custom_button.dart';
import 'package:te_find/utils/assets_manager.dart';

import '../../../providers/otherProvider.dart';
import '../../../providers/provider.dart';
import '../../../utils/app_colors.dart';
import '../../widgets/custom_text_form_field.dart';

class SellOnboarding extends ConsumerStatefulWidget {
  const SellOnboarding({super.key});

  @override
  ConsumerState createState() => _SellOnboardingState();
}

class _SellOnboardingState extends ConsumerState<SellOnboarding> {
  late OtherProvider otherProvider;
  @override
  Widget build(BuildContext context) {
    otherProvider = ref.watch(RiverpodProvider.otherProvider);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                      height: 80.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.greyLight),
                      child: Center(
                          child: SvgPicture.asset(
                        Assets.userProfile,
                        color: AppColors.grey,
                      ))),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        //   takePicture();
                      },
                      child: Container(
                        height: 32.h,
                        width: 32.w,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Full Name',
              style: GoogleFonts.roboto(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomTextFormField(
              //controller: accountProvider.lastNameController,
              hint: "Enter your full name",
              // validator: Validators().isSignUpEmpty,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'User Name',
              style: GoogleFonts.roboto(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomTextFormField(
              //controller: accountProvider.lastNameController,
              hint: "Enter your User name",
              // validator: Validators().isSignUpEmpty,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Business Name (Optional)',
              style: GoogleFonts.roboto(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomTextFormField(
              //controller: accountProvider.lastNameController,
              hint: "Enter your business name",
              // validator: Validators().isSignUpEmpty,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Phone Number',
              style: GoogleFonts.roboto(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomTextFormField(
              //controller: accountProvider.lastNameController,
              hint: "Enter your phone number",
              // validator: Validators().isSignUpEmpty,
            ), SizedBox(
              height: 20.h,
            ),
            Text(
              'BVN',
              style: GoogleFonts.roboto(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomTextFormField(
              //controller: accountProvider.lastNameController,
              hint: "Enter your bvn number",
              // validator: Validators().isSignUpEmpty,
            ),  SizedBox(
              height: 20.h,
            ),
            Text(
              'Bio',
              style: GoogleFonts.roboto(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomTextFormField(

              maxLines: 5,

              //controller: accountProvider.lastNameController,
              hint: "Tell buyer's about yourself and your business",
              // validator: Validators().isSignUpEmpty,
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomButton(
              onPressed: () {
                otherProvider.regPosition(1);
              },
              label: 'Next',
              fillColor: AppColors.primaryColor,
              buttonTextColor: Colors.white,
            )

          ],
        ),
      ),
    );
  }
}
