import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saleko/app/widgets/back_button.dart';
import 'package:saleko/app/widgets/couponTextFormField.dart';
import 'package:saleko/providers/account_provider.dart';
import 'package:saleko/providers/provider.dart';
import 'package:saleko/services/navigation/navigator_service.dart';
import 'package:saleko/services/navigation/route_names.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:saleko/utils/app_styles.dart';
import 'package:saleko/app/widgets/custom_button.dart';
import 'package:saleko/app/widgets/pin_input_field.dart';
import 'package:saleko/utils/assets_manager.dart';
import 'package:saleko/utils/helpers.dart';
import 'package:saleko/utils/progress_bar_manager/appbar.dart';

class ConfirmedPayment extends StatefulWidget {
  ConfirmedPayment({super.key});

  @override
  State<ConfirmedPayment> createState() => _ConfirmedPaymentState();
}

final NavigatorService _navigation = NavigatorService();

class _ConfirmedPaymentState extends State<ConfirmedPayment> {
  void continueShoping() {
    _navigation.navigateReplacementTo(checkoutScreenRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 170,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(38.49),
                    topLeft: Radius.circular(38.49),
                    bottomLeft: Radius.circular(9.62),
                    bottomRight: Radius.circular(9.62),
                  ),
                  image: DecorationImage(
                    image: AssetImage(Assets.confirmImage),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your order has\nbeen confirmed",
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 32),
                      ),
                      Row(
                        children: [
                          Text(
                            "Order ID:",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.greenText),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            "SAL-20221234012",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Image.asset(Assets.positiveConfirmed, scale: 1.2,),
                ],
              ),
              SizedBox(
                height: 50.h,
              ),
              CustomButton(
                label: "Track item",
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {
                  continueShoping();
                },
                child: Text(
                  "Continue Shopping",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationThickness: 2,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
