import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/app/widgets/custom_button.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/services/navigation/route_names.dart';

import '../../utils/app_colors.dart';
import '../../utils/assets_manager.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  int quantity = 1;
  int selectedOption = 0;

  void increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart',
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  height: 118.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16.r)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 7.w,
                    children: [
                      Container(
                        height: 80.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage('assets/images/cloth.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Zara',
                            style: GoogleFonts.roboto(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.grey),
                          ),
                          Row(
                            children: [
                              Text(
                                'Oversized Poplin Shirt',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.15,
                              ),
                              SvgPicture.asset(
                                Assets.deleteIcon,
                                color: AppColors.grey,
                              ),
                            ],
                          ),
                          Text(
                            'Size: M • Color: Floral',
                            style: GoogleFonts.roboto(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.grey),
                          ),
                          Row(
                            spacing: 70.w,
                            children: [
                              Text(
                                '₦22,500',
                                style: GoogleFonts.roboto(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                height: 30.h,
                                width: 90.w,
                                padding: EdgeInsets.symmetric(horizontal: 2.w),
                                decoration: BoxDecoration(
                                    color: AppColors.greyLight,
                                    borderRadius: BorderRadius.circular(16.r)),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        decreaseQuantity();
                                      },
                                      child: Container(
                                          width: 28,
                                          height: 28,
                                          decoration: BoxDecoration(
                                              color: AppColors.greyLight2,
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(16.r),
                                                  bottomLeft:
                                                      Radius.circular(16.r))),
                                          child: Icon(
                                            Icons.remove,
                                            size: 15,
                                          )),
                                    ),
                                    Container(
                                      width: 34.w,
                                      height: 28.h,
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${quantity}",
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                    //   SizedBox(width: 3.h,),
                                    InkWell(
                                      onTap: () {
                                        increaseQuantity();
                                      },
                                      child: Container(
                                          width: 28,
                                          height: 28,
                                          decoration: BoxDecoration(
                                              color: AppColors.greyLight2,
                                              borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(16.r),
                                                  bottomRight:
                                                      Radius.circular(16.r))),
                                          child: Icon(
                                            Icons.add,
                                            size: 15,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Spacer(),
                      // SvgPicture.asset(
                      //   Assets.deleteIcon,
                      //   color: AppColors.grey,
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SubTotal',
                      style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.lightTextBlack),
                    ),
                    Text(
                      '₦22,500',
                      style: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discount',
                      style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.lightTextBlack),
                    ),
                    Text(
                      '₦0.00',
                      style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.red),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'Delivery',
                  style: GoogleFonts.roboto(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Transform.scale(
                            scale: 0.7,
                            child: Radio<int>(
                              value: 1,
                              activeColor: AppColors.primaryColor,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              groupValue: selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value!;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Separate delivery(3-5 days) ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(
                      '₦90.99',
                      style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Transform.scale(
                            scale: 0.7,
                            child: Radio<int>(
                              value: 2,
                              activeColor: AppColors.primaryColor,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              groupValue: selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value!;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Corporate delivery (1-2 days) ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(
                      '₦900.00',
                      style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Divider(),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: GoogleFonts.roboto(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '₦22,500',
                      style: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 125.h,
        child: Padding(
          padding: EdgeInsets.only(bottom: 30.0.h, left: 20.w, right: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                onPressed: () {
                  NavigatorService().navigateTo(successfulTransactionscreen);
                },
                label: 'Proceed to Checkout',
                fillColor: AppColors.primaryColor,
                buttonTextColor: AppColors.whiteTextColor,
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomButton(
                onPressed: () {
                  NavigatorService()
                      .navigateReplacementTo(bottomNavigationRoute);
                },
                borderColor: AppColors.greyLight,
                label: 'Continue to Shopping',
                fillColor: AppColors.white,
                buttonTextColor: AppColors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
