import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:te_find/app/profile/widgets/edit_dialog.dart';
import 'package:te_find/app/widgets/custom_button.dart';
import 'package:te_find/models/SignInResponse.dart';
import 'package:te_find/providers/account_provider.dart';
import 'package:te_find/providers/product_provider.dart';
import 'package:te_find/providers/provider.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/services/navigation/route_names.dart';
import 'package:te_find/utils/assets_manager.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/helpers.dart';
import 'package:te_find/utils/storage_util.dart';

import '../../models/Products.dart';
import '../home/widgets/listings_gride_view.dart';
import '../home/widgets/product_gridview.dart';
import '../widgets/custom_profile_listTIle.dart';
import '../widgets/custom_text_form_field.dart';

class ProfilePage extends ConsumerStatefulWidget {
  ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends ConsumerState<ProfilePage> {
  late AccountProvider accountProvider;
  late ProductProvider productProvider;
  final NavigatorService _navigation = NavigatorService();

  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    productProvider = ref.watch(RiverpodProvider.productProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style:
              GoogleFonts.roboto(fontSize: 18.sp, fontWeight: FontWeight.w500),
        ),
        actions: [
          InkWell(
            onTap: () {
              NavigatorService().navigateTo(notificationPage);
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color:
                            Colors.black.withOpacity(0.2), // corrected method
                        spreadRadius: 0.2,
                        blurRadius: 0.2,
                        offset: Offset(0, 0.2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/images/settingsIcon.svg",
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
        ],
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 10.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            height: 440.h,
            decoration: BoxDecoration(color: AppColors.white),
            child: Center(
              child: Column(
                children: [
                  // Container(
                  //   height: 96.h,
                  //   width: 96.w,
                  //   decoration: BoxDecoration(
                  //     border: Border.all(width: 2.w, color: AppColors.primaryColor),
                  //     shape: BoxShape.circle,
                  //     color: AppColors.primaryColor,
                  //     image: accountProvider.currentUser.image != null
                  //         ? DecorationImage(
                  //       image: NetworkImage(accountProvider.currentUser.image!),
                  //       fit: BoxFit.cover,
                  //     )
                  //         : null,
                  //   ),
                  // ),
                  Container(
                    height: 96.h,
                    width: 96.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 2.w, color: AppColors.primaryColor),
                      color: AppColors.primaryColor,
                    ),
                    child: accountProvider.currentUser.image != null
                        ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(accountProvider.currentUser.image!),
                          fit: BoxFit.cover,
                          onError: (exception, stackTrace) {
                            // Optional: you can handle fallback here too
                          },
                        ),
                      ),
                    )
                        : Center(
                      child: Text(
                        accountProvider.currentUser.name!.isNotEmpty
                            ? accountProvider.currentUser.name![0].toUpperCase()
                            : '',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "@${accountProvider.currentUser.username}",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Fashion enthusiast & sustainable shopper",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    height: 114.h,
                    width: 343.w,
                    decoration: BoxDecoration(
                        color: AppColors.lightGreen2,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Text(
                          "Wallet",
                          style: GoogleFonts.roboto(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.grey),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "₦125,500",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 7.w,
                          children: [
                            InkWell(
                              onTap: () {
                                addFunds(context);
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: AppColors.primaryColor,
                                  ),
                                  Text(
                                    'Top Up',
                                    style: GoogleFonts.roboto(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.primaryColor),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                withdrawFunds(context);
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.remove,
                                    color: AppColors.red,
                                  ),
                                  Text(
                                    'Withdraw',
                                    style: GoogleFonts.roboto(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.red),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 7.w,
                    children: [
                      Column(
                        children: [
                          Text(
                            "42",
                            style: GoogleFonts.roboto(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor),
                          ),
                          Text(
                            "Item Listed",
                            style: GoogleFonts.roboto(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.lightTextBlack),
                          ),
                        ],
                      ),
                      VerticalDivider(
                        color: AppColors.greenLighter,
                        indent: 6,
                        endIndent: 6,
                        thickness: 1,
                      ),
                      Column(
                        children: [
                          Text(
                            "18",
                            style: GoogleFonts.roboto(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor),
                          ),
                          Text(
                            "Item Sold",
                            style: GoogleFonts.roboto(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.lightTextBlack),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () {
                      NavigatorService().navigateTo(editProfileRoute);
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        height: 38.h,
                        width: 136.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                                color: AppColors.primaryColor, width: 1.w)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 7.w,
                          children: [
                            SvgPicture.asset('assets/images/edit.svg'),
                            Text(
                              "Edit Profile",
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryColor),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
              // height: 512.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.white,
              ),
              child: Column(
                children: [
                  FutureBuilder<List<Products>>(
                    future: productProvider.products,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container(
                          height: 230,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Center(
                            child: Shimmer.fromColors(
                              direction: ShimmerDirection.ltr,
                              period: const Duration(seconds: 10),
                              baseColor: AppColors.greyLight,
                              highlightColor: AppColors.primaryColor,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 12.h,
                                            width: 100.w,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      } else if (snapshot.data!.isNotEmpty) {
                        final products = snapshot.data!;
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left:8.0, right: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('My Listings',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  GestureDetector(
                                    onTap: () {
                                      NavigatorService().navigateTo(listingviewallProducts, arguments: products);
                                    },
                                    child: Text('View All',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.w500,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            GridView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length > 4
                                  ? 4
                                  : snapshot.data!.length,
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 7,
                                crossAxisSpacing: 7,
                                childAspectRatio: 0.80,
                              ),
                              itemBuilder: (context, index) {
                                Products product = snapshot.data![index];
                                return ListingsGrideView(
                                   newProducts: product
                                );
                              },
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 100,
                                ),
                                Text(
                                  'Network error',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('Network error'),
                                SizedBox(
                                  height: 100,
                                ),
                              ],
                            ));
                      } else {
                        return Center(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              const Text(
                                "No products found",
                                style: TextStyle(
                                    fontSize: 14, color: AppColors.black),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ],
              )),
          SizedBox(
            height: 10.h,
          ),
          Container(
            //height: 413.h,
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.h),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Account Setting',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w600, fontSize: 16)),
                    SizedBox(
                      height: 25.h,
                    ),
                    profileListTile(Assets.favorite, "Favourite", () {
                      NavigatorService().navigateTo(favouriteScreen);
                    }),
                    Divider(),
                    profileListTile(Assets.location, "Shipping Addresses", () {
                      shippingAddress(context);
                    }),
                    Divider(),
                    profileListTile(Assets.privacyIcon, "Privacy and Security",
                        () {
                          NavigatorService().navigateTo(privacyAnsSecurity);

                    }),
                    Divider(),
                    profileListTile(Assets.support, "Help and Support", () {
                      NavigatorService().navigateTo(helpAndSupport);
                    }),
                    Divider(),
                    profileListTile(Assets.about, "About", () {
                      NavigatorService().navigateTo(aboutUs);
                    }),
                  ]),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Center(
            child: CustomButton(
              onPressed: () {
                logout(context);
              },
              label: 'Log Out',
              buttonTextColor: AppColors.red,
              borderColor: AppColors.red,
              fillColor: AppColors.white,
            ),
          ),

          SizedBox(
            height: 30.h,
          ),
        ])),
      ),
    );
  }
}

void shippingAddress(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Close Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Shipping Address',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ),
                Divider(),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                  height: 110.h,
                  width: 308.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.greyLight)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 17.w,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            spacing: 5.w,
                            children: [
                              Text(
                                "Amaka Okafor",
                                style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: AppColors.lightGreen2,
                                    borderRadius: BorderRadius.circular(8)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 2),
                                child: Center(
                                  child: Text(
                                    'Default',
                                    style: GoogleFonts.roboto(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.primaryColor),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "+234 812 345 6789",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.lightTextBlack),
                          ),
                          Text(
                            "123 Victoria Island Way",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.lightTextBlack),
                          ),
                          Text(
                            "Lagos, Nigeria",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.lightTextBlack),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        spacing: 5.w,
                        children: [
                          // Icon(
                          //   Icons.edit,
                          //   size: 18,
                          // ),
                          SvgPicture.asset(
                            Assets.deleteIcon,
                            color: AppColors.red,
                            height: 18,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),

                CustomButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    NavigatorService().navigateTo(addNewAddressScreenRoute);
                  },
                  label: 'Edit Address',
                  fillColor: AppColors.primaryColor,
                ),
              ]),
        ),
      );
    },
  );
}

void addFunds(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Close Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add Funds',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                  height: 89.h,
                  width: 308.w,
                  decoration: BoxDecoration(
                      color: AppColors.lightGreen2,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Current Balance",
                        style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "₦125,500",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Amount to Add',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400, fontSize: 14),
                ),
                SizedBox(height: 5.h),
                CustomTextFormField(
                  //controller: accountProvider.lastNameController,
                  hint: "Enter Amount to Add",
                  // validator: Validators().isSignUpEmpty,
                ),
                Text(
                  'Minimum amount: ₦1,000',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: AppColors.grey),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Payment Method',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400, fontSize: 14),
                ),
                SizedBox(height: 10.h),
                PaymentMethodWidget(
                  image: 'debitIcon',
                  title: 'Debit/Credit Card',
                  onPressed: () {},
                ),
                SizedBox(height: 5.h),
                PaymentMethodWidget(
                  image: 'bankTransfer',
                  title: 'Bank Transfer',
                  onPressed: () {},
                ),
                SizedBox(height: 10.h),
                CustomButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    successFund(context);
                  },
                  label: 'Add Funds',
                  fillColor: AppColors.primaryColor,
                ),
              ]),
        ),
      );
    },
  );
}

void withdrawFunds(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Close Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Withdraw Funds',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                  height: 89.h,
                  width: 308.w,
                  decoration: BoxDecoration(
                      color: AppColors.lightGreen2,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Available Balance",
                        style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "₦125,500",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Amount to Withdraw',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400, fontSize: 14),
                ),
                SizedBox(height: 5.h),
                CustomTextFormField(
                  //controller: accountProvider.lastNameController,
                  hint: "Enter Amount to Withdraw",
                  // validator: Validators().isSignUpEmpty,
                ),
                Text(
                  'Minimum amount to withdraw: ₦1,000',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: AppColors.grey),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Select Bank Account',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400, fontSize: 14),
                ),
                SizedBox(height: 10.h),
                BankWidget(
                  image: 'GTbank',
                  title: 'GTBank',
                  onPressed: () {},
                ),
                SizedBox(height: 5.h),
                PaymentMethodWidget(
                  image: 'addition',
                  title: 'Add New Bank',
                  onPressed: () {},
                ),

                SizedBox(height: 10.h),
                CustomButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    successWithdrawFund(context);
                  },
                  label: 'Withdraw Funds',
                  fillColor: AppColors.primaryColor,
                ),
              ]),
        ),
      );
    },
  );
}

class PaymentMethodWidget extends StatelessWidget {
  final String image;
  final String title;
  final Function()? onPressed;
  const PaymentMethodWidget({
    super.key,
    required this.image,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        height: 47.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.greyLight, width: 1),
        ),
        child: Row(
          children: [
            SvgPicture.asset('assets/images/$image.svg'),
            SizedBox(width: 15.w),
            Text(
              title,
              style:
                  GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            Spacer(),
            IconButton(
              onPressed: onPressed,
              icon: const Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void successFund(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/images/sucessListing.svg'),
              SizedBox(height: 10.h),
              Text(
                'Top Up Successful!',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 10.h),
              Text(
                '₦100,000 has been added to your wallet',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.lightTextBlack),
              ),
              SizedBox(height: 20.h),
              CustomButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                fillColor: AppColors.primaryColor,
                label: 'Done',
                buttonTextColor: AppColors.white,
              )
            ],
          ),
        ),
      );
    },
  );
}

void successWithdrawFund(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/images/sucessListing.svg'),
              SizedBox(height: 10.h),
              Text(
                'Withdrawal Initiated!',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 10.h),
              Text(
                textAlign: TextAlign.center,
                '₦5,000,000 will be sent to your bank account within 24 hours',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.lightTextBlack),
              ),
              SizedBox(height: 20.h),
              CustomButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                fillColor: AppColors.primaryColor,
                label: 'Done',
                buttonTextColor: AppColors.white,
              )
            ],
          ),
        ),
      );
    },
  );
}

class BankWidget extends StatelessWidget {
  final String image;
  final String title;
  final Function()? onPressed;
  const BankWidget({
    super.key,
    required this.image,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
        height: 50.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.greyLight, width: 1),
        ),
        child: Row(
          children: [
            Image.asset('assets/images/$image.png'),
            SizedBox(width: 15.w),
            Column(
              children: [
                Text(
                  title,
                  style: GoogleFonts.roboto(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Text(
                  '*****1234',
                  style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey),
                ),
              ],
            ),
            Spacer(),
            SvgPicture.asset(
              'assets/images/selected.svg',
            ),
          ],
        ),
      ),
    );
  }
}

void logout(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Log Out',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 10.h),
              Text(
                'Are you sure you want to log out?',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.lightTextBlack),
              ),
              SizedBox(height: 20.h),
              Row(
                spacing: 5.w,
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      fillColor: AppColors.greyLight,
                      label: 'Cancel',
                      buttonTextColor: AppColors.lightTextBlack,
                    ),
                  ),
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        Navigator.pop(context);
                        StorageUtil.clearData();
                        NavigatorService()
                            .navigateReplacementTo(loginScreenRoute);
                      },
                      fillColor: AppColors.red,
                      label: 'Log out',
                      buttonTextColor: AppColors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
