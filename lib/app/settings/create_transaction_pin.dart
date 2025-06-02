import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:te_find/services/navigation/route_names.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/progress_bar_manager/utility_app_bar.dart';

import '../../providers/account_provider.dart';
import '../../providers/provider.dart';
import '../../services/navigation/navigator_service.dart';
import '../../utils/helpers.dart';
import '../widgets/custom_button.dart';
import '../widgets/pin_input_field.dart';

class CreateTransactionPin extends ConsumerStatefulWidget {
  const CreateTransactionPin({super.key});

  @override
  ConsumerState createState() => _CreateTransactionPinState();
}

class _CreateTransactionPinState extends ConsumerState<CreateTransactionPin> {


  late AccountProvider accountProvider;

  void completeTransactionPIN() {
    // if (_formKey.currentState?.validate() ?? false) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              SizedBox(height: 60.h,),
              Center(
                  child: Text(
                    "Transaction PIN\nSuccessfully Created",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20, color: AppColors.primaryColor, fontWeight: FontWeight.w700),
                  )),
            ],
          ),
          content: Text(
            "You can now carry out transactions with your te_find Buyer Wallet",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
          actions: [
            CustomButton(
              fillColor: AppColors.primaryColor,
              onPressed: () {
                Navigator.pop(context);
                NavigatorService().navigateReplacementTo(settingsScreenRoute);
              },
              label: "Done",
            ),
            SizedBox(height: 60.h,),
          ],
        );
      },
    );
  //}
}
  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return Scaffold(
      appBar: UtilityAppBar(text: 'Create Transaction PIN',),
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20.h,),
              Text("Create Transaction PIN", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.primaryColor,)),
              SizedBox(height: 10.h,),
              Text("Please provide a 4-digit PIN that will be used to\nvalidate your transaction.", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.grey,),textAlign: TextAlign.center,),

              SizedBox(height: 30.h,),
              Text("Input Transaction PIN", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.grey,)),
              SizedBox(height: 10.h,),
              PinInputField(
                pinNumber: 4,

              ),
              SizedBox(height: 60.h,),

              CustomButton(
                fillColor: AppColors.primaryColor,
                label: 'Continue',
                onPressed:
                  completeTransactionPIN


              ),
            ],
          ),
        ),),
    );
  }
}
