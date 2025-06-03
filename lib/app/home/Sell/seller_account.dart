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
                      height: 30.h,
                    ),
                    CustomTextFormField(
                      //controller: accountProvider.lastNameController,
                      // validator: Validators().isSignUpEmpty,
                    ),



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
                child:  CustomButton(
                  onPressed: () {
                    otherProvider.regPosition(1);
                  },
                  borderColor: AppColors.primaryColor,
                  label: 'Previous',
                  fillColor: AppColors.white,
                  buttonTextColor: AppColors.primaryColor,
                )
              ),

              Expanded(
                child:  CustomButton(
                  onPressed: () {
                   NavigatorService().navigateTo(sellItemScreens);
                  },
                  label: 'Complete Setup',
                  fillColor: AppColors.primaryColor,
                  buttonTextColor: Colors.white,
                )
              ),
            ],
          ),
        ],
      ),
    );
  }
}
