import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/app/home/widgets/shoppingCartListView.dart';
import 'package:te_find/providers/account_provider.dart';

import '../../providers/provider.dart';
import '../../services/navigation/navigator_service.dart';
import '../../services/navigation/route_names.dart';
import '../../utils/app_colors.dart';
import '../../utils/progress_bar_manager/utility_app_bar.dart';
import '../../utils/storage_util.dart';
import '../widgets/custom_button.dart';

class PrivavyAndSecurity extends ConsumerStatefulWidget {
  const PrivavyAndSecurity({super.key});

  @override
  ConsumerState createState() => _PrivavyAndSecurityState();
}

late AccountProvider accountProvider;
class _PrivavyAndSecurityState extends ConsumerState<PrivavyAndSecurity> {
  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return Scaffold(
      appBar: UtilityAppBar(
        text: 'Privacy and Security',
        hasActions: false,
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account and Security',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: AppColors.grey),
            ),
            SizedBox(height: 15.h),
            PrivacyOption(
              image: 'changePassword',
              title: 'Change Password',
              subtitle: 'Update your account password',
              onPressed: () {
                NavigatorService().navigateTo(changePasswordScreenRoute);
              },
            ),
            SizedBox(height: 15.h),
            PrivacyOption(
              image: 'transactionPin',
              title: 'Create Transaction Pin',
              subtitle: 'Manage your transaction security PIN',
              onPressed: () {
                NavigatorService().navigateTo(createTransactionPin);
              },
            ),  SizedBox(height: 15.h),
            PrivacyOption(
              color: AppColors.lightPink,
              image: 'closeAccount',
              title: 'Close Account',
              subtitle: 'Account cancellation',
              onPressed: () {
                deleteAccount(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PrivacyOption extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final Function()? onPressed;
  final Color? color;
  const PrivacyOption({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.onPressed,
    this.color = AppColors.lightGreen2,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        height: 55.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 37.w,
                height: 37.h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: color,),
                child: Center(
                    child: SvgPicture.asset(
                      'assets/images/$image.svg',
                      height: 15.h,
                    ))),
            SizedBox(width: 5.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.roboto(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.roboto(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.lightTextBlack),
                ),
              ],
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.grey,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}


void deleteAccount(BuildContext context) {
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
              Text(
                'Close Account',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 10.h),
              Text(
                'Are you sure you want to close your account?',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: AppColors.lightTextBlack),
              ),
            SizedBox(height: 10.h),
              Text(
                'Note: you will loose access to your account',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: AppColors.red),
              ),
              SizedBox(height: 20.h),
              Row(
                spacing: 5.w,
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      fillColor: AppColors.greyLight,
                      label: 'Cancel',
                      buttonTextColor: AppColors.lightTextBlack,
                    ),
                  ),
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        Navigator.pop(context);
                      accountProvider.deleteUserAccount();
                      },
                      fillColor: AppColors.red,
                      label: 'Close',
                      buttonTextColor: AppColors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
