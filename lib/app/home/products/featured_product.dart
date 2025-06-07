
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_colors.dart';
import '../widgets/featured_product_detail.dart';

class FeaturedProductContainer extends StatelessWidget {
  const FeaturedProductContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: GestureDetector(
          onDoubleTap: () {},
          onTap: () {
            // NavigatorService().navigateTo(
            //   productDetailScreenRoute,
            //   // arguments: widget.newProducts,
            // );
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        FeaturedProductDetail()));
          },
          child:
          Stack(alignment: Alignment.center, children: [
            Container(
              height: 232.h,
              width: 240.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  color: AppColors.white),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 160.h,
                        //    width: 240.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(26),
                              topRight: Radius.circular(26)),
                          color: AppColors.primaryColor,
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/bag.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Luxury Leather Handbag",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors
                                      .blackTextColor),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Text(
                                  "₦45,000",
                                  overflow:
                                  TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight:
                                      FontWeight.w600,
                                      color: AppColors
                                          .primaryColor),
                                ),
                                Row(
                                  spacing: 4.w,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/visibility.svg'),
                                    Text(
                                      "124",
                                      overflow: TextOverflow
                                          .ellipsis,
                                      style:
                                      GoogleFonts.roboto(
                                        fontSize: 12,
                                        fontWeight:
                                        FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                    ],
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: []),
                      child: Center(
                        child: Icon(
                          Icons.favorite_border_outlined,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 80,
                    left: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.w, vertical: 5.h),
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius:
                          BorderRadius.circular(28.r)),
                      child: Text(
                        "New",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ])),
    );
  }
}
