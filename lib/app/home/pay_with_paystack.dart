import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saleko/app/home/pay_with_wallet.dart';
import 'package:saleko/app/widgets/couponTextFormField.dart';
import 'package:saleko/app/widgets/custom_bottom_sheet.dart';
import 'package:saleko/app/widgets/custom_button.dart';
import 'package:saleko/app/widgets/custom_text_form_field.dart';
import 'package:saleko/app/widgets/feature_widget.dart';
import 'package:saleko/models/product.dart';
import 'package:saleko/providers/app_nav_notifier.dart';
import 'package:saleko/providers/provider.dart';
import 'package:saleko/services/navigation/route_names.dart';
import 'package:saleko/utils/assets_manager.dart';
import 'package:saleko/utils/progress_bar_manager/utility_app_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:saleko/app/widgets/search_box.dart';
import 'package:saleko/providers/product_provider.dart';
import 'package:saleko/services/navigation/navigator_service.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:saleko/utils/progress_bar_manager/appbar.dart';

import '../../providers/account_provider.dart';

final selectedPayStacOption = StateProvider<String>((ref) => 'Card');

class PayWithPaystack extends ConsumerStatefulWidget {
  // final Product product;
  PayWithPaystack({super.key});

  @override
  ConsumerState<PayWithPaystack> createState() => _PayWithPaystack();
  final NavigatorService _navigation = NavigatorService();
}

class _PayWithPaystack extends ConsumerState<PayWithPaystack>
    with SingleTickerProviderStateMixin {
  late AccountProvider accountProvider;
  final NavigatorService _navigation = NavigatorService();

  //navigation
  void confirmPayment() {
    _navigation.navigateTo(payWithWallet);
  }

  @override
  Widget build(BuildContext context) {
    // for the rest widget
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    // for paystack radio bottom
    final paymentOption = ref.watch(selectedPayStacOption);

    return Scaffold(
      appBar: UtilityAppBar(
        text: "Pay With Paystack",
        hasActions: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(Assets.paystackCard),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text("Card",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                      Spacer(),
                      Radio<String>(
                        activeColor: AppColors.primaryColor,
                        value: 'Card',
                        groupValue: paymentOption,
                        onChanged: (value) {
                          ref.read(selectedPayStacOption.notifier).state =
                              value!;
                        },
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(Assets.paystackBT),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text("Bank Transfer",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                      Spacer(),
                      Radio<String>(
                        activeColor: AppColors.primaryColor,
                        value: 'BankTransfer',
                        groupValue: paymentOption,
                        onChanged: (value) {
                          ref.read(selectedPayStacOption.notifier).state =
                              value!;
                        },
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(Assets.paystackBank),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text("Bank",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                      Spacer(),
                      Radio<String>(
                        activeColor: AppColors.primaryColor,
                        value: 'Bank',
                        groupValue: paymentOption,
                        onChanged: (value) {
                          ref.read(selectedPayStacOption.notifier).state =
                              value!;
                        },
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(Assets.paystackUSSD),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text("USSD",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                      Spacer(),
                      Radio<String>(
                        activeColor: AppColors.primaryColor,
                        value: 'USSD',
                        groupValue: paymentOption,
                        onChanged: (value) {
                          ref.read(selectedPayStacOption.notifier).state =
                              value!;
                        },
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(Assets.paystackQR),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text("QR code",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                      Spacer(),
                      Radio<String>(
                        activeColor: AppColors.primaryColor,
                        value: 'QRcode',
                        groupValue: paymentOption,
                        onChanged: (value) {
                          ref.read(selectedPayStacOption.notifier).state =
                              value!;
                        },
                      ),
                    ],
                  ),
                  Divider(),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
