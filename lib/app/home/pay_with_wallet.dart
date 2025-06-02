import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/app/widgets/back_button.dart';
import 'package:te_find/app/widgets/couponTextFormField.dart';
import 'package:te_find/providers/account_provider.dart';
import 'package:te_find/providers/provider.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/services/navigation/route_names.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/app_styles.dart';
import 'package:te_find/app/widgets/custom_button.dart';
import 'package:te_find/app/widgets/pin_input_field.dart';
import 'package:te_find/utils/helpers.dart';
import 'package:te_find/utils/progress_bar_manager/appbar.dart';
import 'package:te_find/utils/progress_bar_manager/utility_app_bar.dart';

class PayWithWallet extends ConsumerStatefulWidget {
  const PayWithWallet({super.key});

  @override
  ConsumerState<PayWithWallet> createState() => _PayWithWallet();
}

class _PayWithWallet extends ConsumerState<PayWithWallet> {
  final NavigatorService _navigation = NavigatorService();
  late AccountProvider accountProvider;
  TextEditingController pinController = TextEditingController();

  bool get isPinFilled => pinController.text.isNotEmpty;

  void confirmedPayment() {
    _navigation.navigateReplacementTo(confirmedPaymentPage);
  }

  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return Scaffold(
      appBar: UtilityAppBar(
        text: "Pay with Wallet",
        hasActions: false,
      ),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Enter your 4-digit transaction PIN",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    color: AppColors.black,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 40),
              Center(
                  child: PinInputField(
                pinNumber: 4,
                pinController: pinController,
              )),
              SizedBox(
                height: 30,
              ),
              Spacer(),
              CustomButton(
                fillColor: isPinFilled ? AppColors.primaryColor : Colors.grey,
                label: 'Confirm Payment',
                onPressed: () {
                  if (pinController.text.isNotEmpty) {
                    confirmedPayment();
                  } else {
                    showErrorToast(message: "Kindly input your OTP");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
