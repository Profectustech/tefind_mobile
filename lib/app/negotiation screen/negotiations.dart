import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saleko/providers/product_provider.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:saleko/utils/assets_manager.dart';
import 'package:saleko/utils/progress_bar_manager/utility_app_bar.dart';
import 'package:saleko/utils/screen_size.dart';

class Negotiations extends ConsumerStatefulWidget {
  const Negotiations({super.key});

  @override
  ConsumerState<Negotiations> createState() => _NegotiationsState();
}

class _NegotiationsState extends ConsumerState<Negotiations> {
  final balanceVisibilityProvider = StateProvider<bool>((ref) => false);
  @override
  Widget build(BuildContext context) {
    final transactions = ref.watch(transactionProvider);
    return Scaffold(
      appBar: UtilityAppBar(text: "Negotiations", hasActions: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 67,
                                width: 75.09,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Container(
                                    height: 55.69,
                                    width: 61.84,
                                    decoration: BoxDecoration(
                                      color: AppColors.greenLightest,
                                      border: Border.all(width: 0.5, color: AppColors.grey),
                                      image: DecorationImage(
                                        image: AssetImage(Assets.sneakers),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Ashluxe Tshirt Kalakuta",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: Responsive.width(context) * 0.11),

                                      Container(
                                        width: 80.w,
                                        height: 22.h,
                                        decoration: BoxDecoration(
                                            color: AppColors.primaryColor,
                                            borderRadius:
                                            BorderRadius.circular(10)),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [

                                            Text(
                                              "View Details",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.white),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Original Price;",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: AppColors.grey,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                      SizedBox(width: 10.w,),
                                      Text(
                                        "₦20,000.35",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: AppColors.grey,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                      SizedBox(width: 10.w,),
                                      Text(
                                        "(QTY:3)",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: AppColors.grey,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Negotiated Price:",
                                        style: TextStyle(
                                          fontSize: 11.73,
                                          color: AppColors.red,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 10.w,),
                                      Text(
                                        "₦15,000.00",
                                        style: TextStyle(
                                          fontSize: 11.73,
                                          color: AppColors.red,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 5.h,),

                          Divider() //
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
