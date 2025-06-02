import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:te_find/models/SignInResponse.dart';
import 'package:te_find/providers/account_provider.dart';
import 'package:te_find/providers/provider.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/services/navigation/route_names.dart';
import 'package:te_find/utils/assets_manager.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/helpers.dart';
import 'package:te_find/utils/storage_util.dart';

import '../widgets/custom_profile_listTIle.dart';

class ProfilePage extends ConsumerStatefulWidget {
  ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends ConsumerState<ProfilePage> {
  late AccountProvider accountProvider;
  final NavigatorService _navigation = NavigatorService();

  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Profile",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white),
                  ),
                ],
              ),
              if (accountProvider.currentUser.email != null) ...[
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  children: [
                    Container(
                      width: 62,
                      height: 62,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.greenFade,
                          image: DecorationImage(
                              image: AssetImage(
                                Assets.userImage,
                              ),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${accountProvider.currentUser.firstName} ${accountProvider.currentUser.lastName}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white),
                        ),
                        Text(
                          "${accountProvider.currentUser.email}",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.white),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ]),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 50.h),
              width: double.infinity,
              // height: 800,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 30, right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Personal",
                      style: TextStyle(
                          fontSize: 20,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600),
                    ),
                    profileListTile(Assets.userProfile, "Personal Details", () {
                      if (accountProvider.currentUser.lastName != null) {
                        accountProvider.onTapDetailPage();
                      } else {
                        showErrorToast(message: 'Kindly login first');
                      }
                    }),
                    Divider(
                      endIndent: 18,
                    ),
                    profileListTile(Assets.locationProfile, "Delivery Address",
                        () {
                      if (accountProvider.currentUser.email != null) {
                        accountProvider.onTapDeliveryAddress();
                      } else {
                        showErrorToast(message: 'Kindly login first');
                      }
                    }),
                    Divider(
                      endIndent: 18,
                    ),
                    // profileListTile(Assets.walletProfile, "Wallet", () {
                    //   accountProvider.onTapWallet();
                    // }),
                    // Divider(
                    //   endIndent: 18,
                    // ),
                    // profileListTile(Assets.orderProfile, "My Orders", () {
                    //   accountProvider.onTapMyOrder();
                    // }),
                    // Divider(
                    //   endIndent: 18,
                    // ),
                    profileListTile(Assets.wishlistProfile, "My Wishlist", () {
                      if (accountProvider.currentUser.email != null) {
                        accountProvider.onTapWishlist();
                      } else {
                        showErrorToast(message: 'Kindly login first');
                      }
                    }),
                    // Divider(
                    //   endIndent: 18,
                    // ),
                    // profileListTile(Assets.negotiationProfile, "Negotiations",
                    //     () {
                    //   accountProvider.negotiationPage();
                    // }),
                    Divider(
                      endIndent: 18,
                    ),
                    profileListTile(Assets.settingProfile, "Settings", () {
                      if (accountProvider.currentUser.email != null) {
                        accountProvider.onTapSettings();
                      } else {
                        showErrorToast(message: 'Kindly login first');
                      }

                    }),
                    Divider(
                      endIndent: 18,
                    ),
                    // profileListTile(Assets.sellerProfile, "Become a seller",
                    //     () {
                    //   accountProvider.sellersPage();
                    // }),
                    // Divider(
                    //   endIndent: 18,
                    // ),
                    profileListTile(Assets.logOutIcon, "LogOut", () {
                      StorageUtil.clearData();
                      _navigation.pushNamedAndRemoveUntil(loginScreenRoute);
                    }),
                    Divider(
                      endIndent: 18,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "More",
                      style: TextStyle(
                          fontSize: 20,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600),
                    ),
                    profileListTile(Assets.FAQs, "FAQs", () {
                      accountProvider.faqPage();
                    }),
                    Divider(
                      endIndent: 18,
                    ),
                    profileListTile(Assets.helpProfile, "Help", () {
                      accountProvider.helpPage();
                    }),
                    Divider(
                      endIndent: 18,
                    ),
                    profileListTile(Assets.legalProfile, "Legal", () {
                      accountProvider.legalTerms();
                    }),
                  ],
                ),
              )),
        ])),
      ),
    );
  }
}
