import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/app/widgets/custom_button.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/assets_manager.dart';

import '../../services/navigation/route_names.dart';

class CartDrawer extends ConsumerStatefulWidget {
  const CartDrawer({Key? key}) : super(key: key);

  @override
  ConsumerState<CartDrawer> createState() => _CartDrawerState();
}


class _CartDrawerState extends ConsumerState<CartDrawer> {

  int quantity = 1;

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
    return Drawer(
      backgroundColor: AppColors.white,
      width: MediaQuery.of(context).size.width * 0.90,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'Shopping Cart',
                style: GoogleFonts.roboto(
                    fontSize: 18, fontWeight: FontWeight.w500),
              ),
              trailing: IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Divider(),
            Expanded(child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                children: [
                  Container(
                    padding:  EdgeInsets.symmetric(horizontal: 10.w),
                    height: 112.h,
                    width: double.infinity,
                    decoration: BoxDecoration(color: AppColors.greyLight2, borderRadius: BorderRadius.circular(16.r)),
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
                              'Oversized Poplin Shirt',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              'Zara',
                              style: GoogleFonts.roboto(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.grey),
                            ),
                            SizedBox(height: 5,),
                            Row(
                              spacing: 7.w,
                              children: [
                                InkWell(
                                  onTap: (){
                                    decreaseQuantity();
                                  },
                                  child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: AppColors
                                            .grey,

                                      ),
                                      borderRadius:
                                      BorderRadius.circular(
                                          7)),
                                  child: Icon(
                                    Icons.remove,
                                    size: 15,
                                  )
                                  ),
                                ),
                                //SizedBox(width: 1.h,),
                                Text(
                                  "${quantity}",
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                             //   SizedBox(width: 3.h,),
                                InkWell(
                                  onTap: (){
                                    increaseQuantity();
                                  },
                                  child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          border: Border.all(
                                            width: 1,
                                            color: AppColors
                                                .grey,

                                          ),
                                          borderRadius:
                                          BorderRadius.circular(
                                              7)),
                                      child: Icon(
                                        Icons.add,
                                        size: 15,
                                      )
                                  ),
                                ),
                              //  SizedBox(width: 3.h,),
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
                        Spacer(),
                        SvgPicture.asset(Assets.deleteIcon, color: AppColors.grey,),
                      ],
                    ),
                  ),

                ],
              ),
            )),
            Spacer(),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SubTotal',
                        style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey
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
                  SizedBox(height: 10.h,),
                  CustomButton(

                    fillColor: AppColors.primaryColor,
                    buttonTextColor: Colors.white,
                    label: "Proceed to Checkout",
                    onPressed: () {
                      Navigator.of(context).pop();
                      NavigatorService().navigateTo(cartPageScreen);
                    },

                  )
                ],
              ),
            )


            //------Empty Cart Widget-----///
            // Expanded(
            //   child: Center(
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Container(
            //           height: 64.h,
            //           width: 64.w,
            //           decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.greyLight),
            //           child: Center(child: Icon(Icons.shopping_bag_outlined, color: AppColors.grey,),),
            //         ),
            //         SizedBox(height: 20.h,),
            //         Text(
            //           "Your cart is empty.",
            //           style: GoogleFonts.roboto(
            //               fontSize: 14,
            //               fontWeight: FontWeight.w400,
            //               color: AppColors.grey),
            //         ),
            //         SizedBox(height: 20.h,),
            //         Padding(
            //           padding:  EdgeInsets.symmetric(horizontal: 65.w),
            //           child: CustomButton(
            //             fillColor: AppColors.primaryColor,
            //             buttonTextColor: Colors.white,
            //             label: "Continue Shopping",
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
