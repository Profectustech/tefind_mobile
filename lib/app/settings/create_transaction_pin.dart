import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
  TextEditingController createPinController = TextEditingController();

  void completeTransactionPIN() {
    // if (_formKey.currentState?.validate() ?? false) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              SizedBox(
                height: 60.h,
              ),
              Center(
                  child: Text(
                "Transaction PIN\nSuccessfully Created",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700),
              )),
            ],
          ),
          content: Text(
            "You can now carry out transactions with your TeFind account.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
          actions: [
            CustomButton(
              fillColor: AppColors.primaryColor,
              onPressed: () {
                Navigator.pop(context);
                NavigatorService().navigateReplacementTo(bottomNavigationRoute);
              },
              label: "Done",
            ),
            SizedBox(
              height: 60.h,
            ),
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
      appBar: UtilityAppBar(
        text: 'Create Transaction PIN',
        hasActions: false,
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),

              Text(
                "Create a 4-digit PIN that you'll use\nto authorize transactions",
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(
                height: 30.h,
              ),
              // Text("Input Transaction PIN", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.grey,)),
              // SizedBox(height: 10.h,),
              PinInputField(
                pinController: createPinController,
                pinNumber: 4,
              ),
              SizedBox(
                height: 120.h,
              ),
              CustomButton(
                  fillColor: AppColors.primaryColor,
                  label: 'Proceed',
                  onPressed: (){
                    bool isSuccess=
                    accountProvider.createTransactionPin(createPinController.text);
                    if (isSuccess) {
                      completeTransactionPIN();
                    }
                  },)
            ],
          ),
        ),
      ),
    );
  }
}
