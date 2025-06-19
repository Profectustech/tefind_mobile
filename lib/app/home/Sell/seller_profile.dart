import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/app/widgets/custom_button.dart';
import 'package:te_find/utils/assets_manager.dart';

import '../../../providers/account_provider.dart';
import '../../../providers/otherProvider.dart';
import '../../../providers/provider.dart';
import '../../../utils/app_colors.dart';
import '../../widgets/custom_text_form_field.dart';

class SellerProfile extends ConsumerStatefulWidget {
  const SellerProfile({super.key});

  @override
  ConsumerState createState() => _SellerProfileState();
}

class _SellerProfileState extends ConsumerState<SellerProfile> {
  late OtherProvider otherProvider;
  late AccountProvider accountProvider;
  bool isChecked = false;
  bool isChecked1 = false;


  @override
  Widget build(BuildContext context) {

    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    otherProvider = ref.watch(RiverpodProvider.otherProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Address',
                      style: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTextFormField(
                        onTap: () {
                          print('i press something');
                          accountProvider
                              .showDestinationAddressPicker(accountProvider);
                        },
                        controller: accountProvider.businessAddressController,
                        hint: '',
                        maxLines: 2),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'City',
                      style: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTextFormField(
                      controller: accountProvider.sellerCity,
                      hint: "Enter your City",
                      // validator: Validators().isSignUpEmpty,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'State',
                      style: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTextFormField(
                      controller: accountProvider.sellerState,
                      hint: "Select your State",
                      // validator: Validators().isSignUpEmpty,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'Delivery Options',
                      style: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: AppColors.primaryColor,
                          value: accountProvider.isChecked,
                          materialTapTargetSize: MaterialTapTargetSize
                              .shrinkWrap,
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          onChanged: (val) {
                            setState(() {
                              accountProvider.isChecked = val ?? false;
                            });
                          },
                        ),
                        SizedBox(width: 5.w),
                        Expanded(
                          child: Text(
                            'In-person Meetup',
                            style: GoogleFonts.roboto(
                                fontSize: 14.sp, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: AppColors.primaryColor,
                          value: accountProvider.isChecked1,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          onChanged: (val) {
                            setState(() {
                              accountProvider.isChecked1 = val ?? false;
                            });
                          },
                        ),
                        SizedBox(width: 5.w),
                        Expanded(
                          child: Text(
                            'Shipping',
                            style: GoogleFonts.roboto(
                                fontSize: 14.sp, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
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
                  child: CustomButton(
                onPressed: () {
                  otherProvider.regPosition(0);
                },
                borderColor: AppColors.primaryColor,
                label: 'Previous',
                fillColor: AppColors.white,
                buttonTextColor: AppColors.primaryColor,
              )),
              Expanded(
                  child: CustomButton(
                onPressed: () {
                  otherProvider.regPosition(2);
                },
                label: 'Next',
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
