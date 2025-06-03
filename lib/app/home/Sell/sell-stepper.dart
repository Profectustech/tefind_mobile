import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:te_find/app/home/Sell/reusable_widget.dart';
import 'package:te_find/app/home/Sell/sell_onboarding.dart';
import 'package:te_find/app/home/Sell/seller_account.dart';
import 'package:te_find/app/home/Sell/seller_profile.dart';

import '../../../providers/otherProvider.dart';
import '../../../providers/provider.dart';

class SteperExistingCustomer extends ConsumerStatefulWidget {
  const SteperExistingCustomer({super.key});

  @override
  ConsumerState<SteperExistingCustomer> createState() =>
      _SteperExistingCustomerState();
}

class _SteperExistingCustomerState
    extends ConsumerState<SteperExistingCustomer> {
  late OtherProvider otherProvider;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      otherProvider.removPosition();
    });
  }

  @override
  Widget build(BuildContext context) {
    otherProvider = ref.watch(RiverpodProvider.otherProvider);

    return WillPopScope(
      onWillPop:  () async {
        if (otherProvider.position == 0) {
          Navigator.pop(context);
          return true;
        } else {
          otherProvider.regPosition(otherProvider.position - 1);
          return false;
        }
      } ,
      child: Scaffold(
          appBar: buildAppBarCustom(context: context, title: 'Open a Seller Profile',
              onTap: () {
                if (otherProvider.position == 0) {
                  Navigator.pop(context);
                } else {
                  otherProvider.regPosition(otherProvider.position - 1);
                }
              }),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DashThreeIndicator(currentIndex: otherProvider.position),
                if (otherProvider.position == 0)
                  Expanded(child: SellOnboarding()),
                if (otherProvider.position == 1)
                  const Expanded(child: SellerProfile()),
                //   DashTwoIndicator(currentIndex: otherProvider.setTransactionPin),
                if(otherProvider.position==2)
                  const Expanded(child: SellerAccount()),
              ],
            ),
          )),
    );
  }
}
