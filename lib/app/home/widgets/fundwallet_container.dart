import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:te_find/app/widgets/custom_bottom_sheet.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/assets_manager.dart';

class FundWalletContainer extends StatelessWidget {
  const FundWalletContainer({
    super.key,
    required this.isBalanceHidden,
    required this.ref,
    required this.balanceVisibilityProvider,
  });

  final bool isBalanceHidden;
  final WidgetRef ref;
  final StateProvider<bool> balanceVisibilityProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 204,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    Assets.walletProfile,
                    color: AppColors.white,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    "My Wallet",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white),
                  )
                ],
              ),
              SizedBox(
                height: 25.h,
              ),
              Text(
                "Available Balance",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white),
              ),
              Row(
                children: [
                  Text(
                    isBalanceHidden ? '₦ •••••••' : '₦ 10,000.00',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  IconButton(
                    icon: Icon(
                      isBalanceHidden ? Icons.visibility_off : Icons.visibility,
                      color: Colors.orange,
                    ),
                    onPressed: () {
                      ref.read(balanceVisibilityProvider.notifier).state =
                          !isBalanceHidden;
                    },
                  ),
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  CustomBottomSheet.show(
                      context: context,
                      isDismissible: true,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Fund Wallet ",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.close))
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              "Bank Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.grey),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "Addosser MFB",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: AppColors.black),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              "Account Number",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.grey),
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              children: [
                                Text(
                                  "0123456789",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: AppColors.black),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                SvgPicture.asset(Assets.copyIcon, color: AppColors.primaryColor,),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              "Account Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.grey),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "Kanayo O. Kanayo",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: AppColors.black),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  // height: 46,
                                  // width: 172,
                                  decoration: BoxDecoration(
                                    color: Colors.orangeAccent,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Share Details",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      SvgPicture.asset(Assets.walletShare),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Copy Details",
                                        style: TextStyle(
                                            color: AppColors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      SvgPicture.asset(Assets.copyIcon),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ));
                },
                child: Container(
                  height: 43,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Assets.fundWallet),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        "Fund Wallet",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryColor),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
