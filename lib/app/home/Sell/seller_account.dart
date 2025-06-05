import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/app/widgets/custom_button.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/utils/assets_manager.dart';
import '../../../providers/otherProvider.dart';
import '../../../providers/provider.dart';
import '../../../services/navigation/route_names.dart';
import '../../../utils/app_colors.dart';
import '../../widgets/custom_text_form_field.dart';

class SellerAccount extends ConsumerStatefulWidget {
  const SellerAccount({super.key});

  @override
  ConsumerState createState() => _SellerAccountgState();
}

class _SellerAccountgState extends ConsumerState<SellerAccount> {
  late OtherProvider otherProvider;
  @override
  Widget build(BuildContext context) {
    otherProvider = ref.watch(RiverpodProvider.otherProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.h, vertical: 20.h),
                        height: 88.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.criyon,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              spacing: 10.w,
                              children: [
                                SvgPicture.asset(
                                    'assets/images/bankTransfer.svg'),
                                Text(
                                  'Bank Account Details',
                                  style: GoogleFonts.roboto(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),

                            Text(
                              'Your earnings will be sent to this account',
                              style: GoogleFonts.roboto(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.lightTextBlack),
                            ),
                          ],
                        )),
                    Text(
                      'Bank Name',
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
                      hint: "Select bank",
                      // validator: Validators().isSignUpEmpty,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'Account Number',
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
                      hint: 'Enter your 10-digit account number',
                      // validator: Validators().isSignUpEmpty,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'Account Name',
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
                        // validator: Validators().isSignUpEmpty,
                        ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.h, vertical: 10.h),
                        height: 88.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.criyon,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Row(
                              spacing: 10.w,
                              children: [
                                SvgPicture.asset(
                                    'assets/images/bankTransfer.svg'),
                                Text(
                                  'Important Notice',
                                  style: GoogleFonts.roboto(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Make sure your account details are correct. Wrong details may lead to failed transactions.',
                              style: GoogleFonts.roboto(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.lightTextBlack),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 12.w,
            children: [
              Expanded(
                  child: CustomButton(
                onPressed: () {
                  otherProvider.regPosition(1);
                },
                borderColor: AppColors.primaryColor,
                label: 'Previous',
                fillColor: AppColors.white,
                buttonTextColor: AppColors.primaryColor,
              )),
              Expanded(
                  child: CustomButton(
                onPressed: () {
                  sellerProfileComp(context);
                },
                label: 'Complete Setup',
                fillColor: AppColors.primaryColor,
                buttonTextColor: Colors.white,
              )),
            ],
          ),
        ],
      ),
    );
  }
}


void sellerProfileComp(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/images/sucessListing.svg'),
              SizedBox(height: 10.h),
              Text(
                'Profile Complete!',
                style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 10.h),
              Text(
                textAlign: TextAlign.center,
                'Your seller profile has been created\nsuccessfully',
                style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.lightTextBlack),
              ),
              SizedBox(height: 20.h),
              CustomButton(
                onPressed: (){
                  Navigator.pop(context);
                  NavigatorService().navigateTo(sellItemScreens);
                },
                fillColor: AppColors.primaryColor,
                label: 'Start Selling',
                buttonTextColor: AppColors.white,
              )
            ],
          ),
        ),
      );
    },
  );
}