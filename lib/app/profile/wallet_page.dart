import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:te_find/app/change_password.dart';
import 'package:te_find/app/home/widgets/fundwallet_container.dart';
import 'package:te_find/app/home/widgets/transactionTile.dart';
import 'package:te_find/providers/product_provider.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/assets_manager.dart';
import 'package:te_find/utils/progress_bar_manager/utility_app_bar.dart';

class WalletPage extends ConsumerStatefulWidget {
  const WalletPage({super.key});

  @override
  ConsumerState<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends ConsumerState<WalletPage> {
  final balanceVisibilityProvider = StateProvider<bool>((ref) => false);
  @override
  Widget build(BuildContext context) {
    final isBalanceHidden = ref.watch(balanceVisibilityProvider);
    final transactions = ref.watch(transactionProvider);
    return Scaffold(
      appBar: UtilityAppBar(text: "Wallet", hasActions: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FundWalletContainer(
                  isBalanceHidden: isBalanceHidden,
                  ref: ref,
                  balanceVisibilityProvider: balanceVisibilityProvider),
              SizedBox(
                height: 30.h,
              ),
              Text(
                "Transaction History",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                width: double.infinity,
                height: 45.h,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    SvgPicture.asset(Assets.calenderIcon),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "Duration",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey),
                    ),
                    Spacer(),
                    SvgPicture.asset(Assets.arrow_down),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text(
                    "IN - ",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black),
                  ),
                  Text(
                    "+ ₦100,200",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.green),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    "OUT - ",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black),
                  ),
                  Text(
                    "- ₦99,200",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.red),
                  )
                ],
              ),
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    return TransactionTile(
                      transactions: transactions,
                      index: index,
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
