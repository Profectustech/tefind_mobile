import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saleko/providers/product_provider.dart';
import 'package:saleko/utils/app_colors.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile(
      {super.key, required this.transactions, required this.index});

  final List<Transaction> transactions;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(width: 1, color: AppColors.grey),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(transactions[index].assetImage, height: 4, width: 4,),
              ),

              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transactions[index].statusType,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "11:25 AM",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        "28th, June 2024",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Text(
                transactions[index].price,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: transactions[index].statusType == "Fund Wallet"
                        ? AppColors.green
                        : AppColors.red),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Divider(color: AppColors.dividerColor, thickness:0.5)

          //
        ],
      ),
    );
  }
}
