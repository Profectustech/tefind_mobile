import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saleko/app/change_password.dart';
import 'package:saleko/providers/account_provider.dart';
import 'package:saleko/providers/product_provider.dart';
import 'package:saleko/providers/provider.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:saleko/utils/assets_manager.dart';
import 'package:saleko/utils/progress_bar_manager/utility_app_bar.dart';

class PersonalDetailPage extends ConsumerStatefulWidget {
  const PersonalDetailPage({super.key});

  @override
  ConsumerState<PersonalDetailPage> createState() => _PersonalDetailPageState();
}

final bool isVerified = false;

class _PersonalDetailPageState extends ConsumerState<PersonalDetailPage> {
  late AccountProvider accountProvider;
  late ProductProvider productProvider;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      accountProvider.getCustomerAddress();
    });
  }
  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    productProvider = ref.watch(RiverpodProvider.productProvider);
    return Scaffold(
      appBar: UtilityAppBar(
        text: "Personal Details",
        hasActions: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              personalDetails(
                Label: 'First Name',
                sublabel: '${accountProvider.currentUser.firstName}',
              ),
              personalDetails(
                Label: 'Last Name',
                sublabel: '${accountProvider.currentUser.lastName}',
              ),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Phone Number",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Image.asset(Assets.ProfilePhone)
                    ],
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${accountProvider.currentUser.phoneNumber ?? 'Not updated'}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      if (accountProvider.currentUser.phoneNumber != null) ...[
                        isVerified
                            ? Image.asset(Assets.PhoneNumberVerified)
                            : Container(
                                height: 24,
                                width: 81,
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Text(
                                    "Verify Now",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              )
                      ]
                    ],
                  ),
                ],
              ),
              Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email Address",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey,
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${accountProvider.currentUser.email}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      isVerified
                          ? Image.asset(Assets.PhoneNumberVerified)
                          : Container(
                              height: 24,
                              width: 81,
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Text(
                                  "Verify Now",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
                ],
              ),
              Divider(),
              personalDetails(
                Label: 'Home Address Name',
                sublabel:
                    '${accountProvider.addressList?.first.address ?? ""}  ${accountProvider.addressList?.first.city?? ""} ${accountProvider.addressList?.first.state?? ""}' ??"",
              ),
              // personalDetails(
              //   Label: 'Date of Birth',
              //   sublabel: '05/10/1995',
              // ),
              // personalDetails(
              //   Label: 'Gender',
              //   sublabel: 'Female',
              // ),
              // personalDetails(
              //   Label: 'Account Created',
              //   sublabel: '05/10/2022',
              // ),
              // personalDetails(
              //   Label: 'NIN',
              //   sublabel: '0123456789',
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class personalDetails extends StatelessWidget {
  final String Label;
  final String sublabel;
  const personalDetails({
    required this.Label,
    required this.sublabel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.grey,
          ),
        ),
        SizedBox(
          height: 7.h,
        ),
        Text(
          sublabel,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Divider(),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
