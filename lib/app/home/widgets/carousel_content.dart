import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/utils/assets_manager.dart';
import 'package:te_find/utils/progress_bar_manager/utility_app_bar.dart';

import '../../../utils/app_colors.dart';
import 'fl_chart.dart';

class CarouselContent extends ConsumerStatefulWidget {
  const CarouselContent({super.key});

  @override
  ConsumerState createState() => _CarouselContentState();
}

List<String> items = ["C02", "Water", "Waste"];
int current = 0;

class _CarouselContentState extends ConsumerState<CarouselContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UtilityAppBar(
        text: 'Sustainable Fashion',
        centerTitle: false,
        hasActions: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
          ),
          child: Column(
            children: [
              Container(
                height: 200.h,
                width: double.infinity,
                //foregroundDecoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
                decoration: BoxDecoration(
                  // color: AppColors.primaryColor,
                  image: DecorationImage(
                    image: AssetImage('assets/images/susfashion.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Make a Difference With Every\nPurchase',
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white)),
                      Text('Join the movement for sustainable fashion',
                          style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.white)),
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      height: 141.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        children: [
                          Text('Your Collective Impact',
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.lightTextBlack)),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text('12,579',
                                      style: GoogleFonts.roboto(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryColor)),
                                  Text('kg CO₂ Saved',
                                      style: GoogleFonts.roboto(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.lightTextBlack)),
                                ],
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text('34,750',
                                          style: GoogleFonts.roboto(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.primaryColor)),
                                      Text('Liters Water\nConserved',
                                          style: GoogleFonts.roboto(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.lightTextBlack)),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text('5,280',
                                          style: GoogleFonts.roboto(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.primaryColor)),
                                      Text('kg CO₂ Saved',
                                          style: GoogleFonts.roboto(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.lightTextBlack)),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text('Why Shop Sustainably?',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        )),
                    SizedBox(
                      height: 10.h,
                    ),
                    SustainablyShopBenefit(
                      imagePath: 'reserve',
                      color: AppColors.lightGreen,
                      title: 'Reduced Carbon Footprint',
                      description:
                          'Second-hand clothing produces up to 82% less carbon emissions than new items.',
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SustainablyShopBenefit(
                      imagePath: 'water',
                      color: AppColors.cyan,
                      title: 'Water Conservation',
                      description:
                          'Each reused garment saves approximately 2,700 liters of water used in production.',
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SustainablyShopBenefit(
                      imagePath: 'recycle',
                      color: AppColors.lightYellow,
                      title: 'Waste Reduction',
                      description:
                          'Extends clothing lifecycle and diverts textiles from landfills where they take 200+ years to decompose..',
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      height: 360.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.2), // corrected method
                            spreadRadius: 0.2,
                            blurRadius: 0.2,
                            offset: Offset(0, 0.2),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Our Environmental Impact',
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              )),
                          SizedBox(
                            height: 10.h,
                          ),
                          SizedBox(
                            height: 30,
                            child: ListView.builder(
                              itemCount: items.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (cxt, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      current = index;
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    decoration: BoxDecoration(
                                      color: current == index
                                          ? AppColors.primaryColor
                                          : AppColors.greyLight,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        items[index],
                                        style: GoogleFonts.roboto(
                                          color: current == index
                                              ? Colors.white
                                              : AppColors.lightTextBlack,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          IndexedStack(index: current, children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 15.h,
                                ),
                                EnvironmentImpactChart(),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  'Compared to fast fashion, our marketplace has saved the, equivalent of planting 1,250 trees. ',
                                  style: GoogleFonts.roboto(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.lightTextBlack),
                                ),
                              ],
                            ),
                            //---water----//
                            Column(
                              children: [
                                SizedBox(
                                  height: 15.h,
                                ),
                                EnvironmentImpactChart(),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  'Compared to fast fashion, our marketplace has saved the, equivalent of planting 1,250 trees. ',
                                  style: GoogleFonts.roboto(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.lightTextBlack),
                                ),
                              ],
                            ),
                            //---Waste----//
                            Column(
                              children: [
                                SizedBox(
                                  height: 15.h,
                                ),
                                EnvironmentImpactChart(),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  'Compared to fast fashion, our marketplace has saved the, equivalent of planting 1,250 trees. ',
                                  style: GoogleFonts.roboto(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.lightTextBlack),
                                ),
                              ],
                            ),
                          ]),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Eco-Friendly Sellers',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            )),
                        GestureDetector(
                          onTap: () {
                            // NavigatorService().navigateTo(categories);
                          },
                          child: Text('View All',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Stack(alignment: Alignment.center, children: [
                      Container(
                        height: 216.h,
                        width: 165.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.white),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 100.h,
                                  //    width: 240.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12)),
                                    color: AppColors.primaryColor,
                                    image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/bag.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Amara's Eco\nCollection",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.black),
                                      ),
                                      SizedBox(height: 5.h),
                                      Row(
                                        children: [
                                          Row(
                                            children: List.generate(5, (index) {
                                              if (index < 4) {
                                                return const Icon(Icons.star,
                                                    color: Colors.amber,
                                                    size: 18);
                                              } else {
                                                return const Icon(
                                                    Icons.star_half,
                                                    color: Colors.amber,
                                                    size: 18);
                                              }
                                            }),
                                          ),
                                          Text(
                                            '(4.8)',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/images/recycle.svg',
                                                color: AppColors.green,
                                              ),
                                              Text(
                                                "120 items recycled",
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.roboto(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors.green),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 2.h),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/images/leaf.svg'),
                                        Text('Verified',
                                            style: GoogleFonts.roboto(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.white,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text('Success Stories',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        )),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 10.w),
                      height: 300.h,
                      width: 312.w,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 10,
                              children: [
                                Container(
                                  height: 48.h,
                                  width: 48.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primaryColor,
                                    image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/bag.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Folake Adeyemi',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      'Fashion Designer',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 10.w,
                              children: [
                                Container(
                                  height: 100.h,
                                  width: 128.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: AppColors.primaryColor,
                                    image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/bag.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 24.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: AppColors.black
                                                .withOpacity(0.4),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(4),
                                              bottomRight: Radius.circular(4),
                                            )),
                                        child: Center(
                                          child: Text(
                                            'Before',
                                            style: GoogleFonts.roboto(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 100.h,
                                  width: 128.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: AppColors.primaryColor,
                                    image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/bag.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 24.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: AppColors.black
                                                .withOpacity(0.4),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(4),
                                              bottomRight: Radius.circular(4),
                                            )),
                                        child: Center(
                                          child: Text(
                                            'After',
                                            style: GoogleFonts.roboto(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Column(
                              children: [
                                Text(
                                  "I source materials from the platform to create upcycled fashion pieces. It's reduced my material costs by 60% while helping me create truly unique designs.",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.lightTextBlack),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  spacing: 5.w,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/recycle.svg',
                                      color: AppColors.green,
                                    ),
                                    Text(
                                      "Saved 45kg of texttile waste",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.roboto(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.green),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Container(
                      height: 151.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            'Start Your Sustainable Journey',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            'Every purchase makes a difference to our planet',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.white,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 10.h),
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(16.r)),
                            child: Text(
                              'Start Shopping',
                              style: GoogleFonts.roboto(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 6.h),
                      height: 153.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.2), // corrected method
                            spreadRadius: 0.2,
                            blurRadius: 0.2,
                            offset: Offset(0, 0.2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Our Environmental Commitment',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "We're dedicated to reducing fashion's environmental",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.lightTextBlack,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 7.w,
                            children: [
                              Container(
                                  height: 40.h,
                                  width: 40.w,
                                  decoration: BoxDecoration(
                                      color: AppColors.greyLight,
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      Assets.instagramIcon,
                                      color: AppColors.lightTextBlack,
                                    ),
                                  )),
                              Container(
                                  height: 40.h,
                                  width: 40.w,
                                  decoration: BoxDecoration(
                                      color: AppColors.greyLight,
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      Assets.facebookIcon,
                                      color: AppColors.lightTextBlack,
                                    ),
                                  )),
                              Container(
                                  height: 40.h,
                                  width: 40.w,
                                  decoration: BoxDecoration(
                                      color: AppColors.greyLight,
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      Assets.twitterIcon,
                                      color: AppColors.lightTextBlack,
                                    ),
                                  )),
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
                      spacing: 5.w,
                      children: [

                        Text(
                          "Privacy Policy",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.lightTextBlack,
                          ),
                        ),

                        VerticalDivider(
                          color: AppColors.lightTextBlack,
                          thickness: 1,
                          width: 1.w,
                        ),

                        Text(
                          "Terms of Service",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.lightTextBlack,
                          ),
                        ),

                        VerticalDivider(
                          color: AppColors.lightTextBlack,
                          thickness: 1,
                          width: 1.w,
                        ),

                        Text(
                          "Contact us ",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.lightTextBlack,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:5.h), 
                    Center(
                      child: Text(
                        "© 2025 . All rights reserved. ",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.lightTextBlack,
                        ),
                      ),
                    ),



                    SizedBox(
                      height: 50.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SustainablyShopBenefit extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final Color color;
  const SustainablyShopBenefit({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      height: 110.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            height: 40.h,
            width: 25.63.w,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Center(
                child: SvgPicture.asset(
              'assets/images/$imagePath.svg',
            )),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.roboto(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  description,
                  style: GoogleFonts.roboto(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
