import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:saleko/app/widgets/custom_profile_listTIle.dart';
import 'package:saleko/utils/assets_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saleko/utils/progress_bar_manager/utility_app_bar.dart';
import '../../utils/app_colors.dart';
import '../widgets/close_account_listTile.dart';
import '../widgets/custom_button.dart';

class DeleteAccount extends ConsumerStatefulWidget {
  const DeleteAccount({super.key});

  @override
  ConsumerState createState() => _DeleteAccountState();
}

class _DeleteAccountState extends ConsumerState<DeleteAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UtilityAppBar(text: "Delete Account", hasActions: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 20),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Assets.deleteIcon,color: AppColors.black,),
                      SizedBox(
                        width: 10.w,
                      ),
                      Flexible(
                        child: Text(
                          "This action will erase all your data from our database, and you will be cease to be a Saleko user.",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Divider(
                    thickness: 0.5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Assets.returnIcn),
                      SizedBox(
                        width: 10.w,
                      ),
                      Flexible(
                        child: Text(
                          "You’ll have to create a new account to undo this action after the recovery period and use our services again.",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 20,
              ),
              height: 47.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColors.tabColorGreen,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Before you go, you can ",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 10),
              child: Column(
                children: [
                  closeAccountListTile(
                      Assets.deleteAccountWallet,
                      "Reach out to your Customer Service for any pending issues",
                      () {},
                      addSpacer: false),
                  SizedBox(
                    height: 10.h,
                  ),
                  Divider(
                    thickness: 0.2,
                  ),
                  closeAccountListTile(
                      Assets.messageQuestion,
                      "Request wallet balance withdrawal to your local bank account",
                      () {},
                      addSpacer: false),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    height: 227.h,
                    decoration: BoxDecoration(
                        color: AppColors.pink,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Column(
                        children: [
                          SvgPicture.asset(Assets.sadEmoji),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "We are sad to see you go",
                            style: TextStyle(
                                color: AppColors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Flexible(
                              child: Text(
                            "Saleko will retain your account information for a recovery period of 30 days, during which your login access will remain active. If you do not log in within this period, your account will be permanently deleted.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  CustomButton(
                    label: "Delete My Account ",
                    fillColor:
                    AppColors.primaryColor,
        
                    onPressed: (){},
                  ),
                  SizedBox(height: 15.h,),
                  
                 Text("Cancel", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
