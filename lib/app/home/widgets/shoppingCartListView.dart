import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:te_find/providers/account_provider.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/assets_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class shoppingCartListView extends ConsumerStatefulWidget {
  const shoppingCartListView({
    super.key,
  });

  @override
  ConsumerState<shoppingCartListView> createState() =>
      _shoppingCartListViewState();
}

late AccountProvider accountProvider;

class _shoppingCartListViewState extends ConsumerState<shoppingCartListView> {
  @override
  Widget build(BuildContext context) {
    final isExpanded = ref.watch(showHideProvider);
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.only(bottom: 10.h),
        onExpansionChanged: (isExpanded) {
          ref.read(showHideProvider.notifier).toggle(isExpanded);
        },
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                Assets.userImage,
              ),
            ),
            SizedBox(width: 10),
            Text(
              "Jarin Boutique",
              style: TextStyle(
                  color: AppColors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
            Spacer(),
            Text(
              isExpanded ? 'Hide' : 'Show',
              style: TextStyle(
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        children: [
          Container(
            height: 232,
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.greenLightest,
                borderRadius: BorderRadius.circular(10)),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 55,
                            height: 50,
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(7),
                                image: DecorationImage(
                                    image: AssetImage(Assets.laptopPowerbank),
                                    fit: BoxFit.cover)),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ashluxe Tshirt Kalakuta",
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Ashluxe Store",
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "₦5,000",
                                style: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Spacer(),
                          Text(
                            "x1",
                            style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 10,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),

                      // Divider(thickness: 0.5,),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
