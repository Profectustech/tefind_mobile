import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/utils/progress_bar_manager/utility_app_bar.dart';

import '../../../utils/app_colors.dart';

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
                          horizontal: 10.w, vertical: 20.h),
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
                          horizontal: 10.w, vertical: 20.h),
                      height: 360.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.white,
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
                            height: 40,
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
                                SizedBox(height: 20.h,),
                                Text('Compared to fast fashion, our marketplace has saved the, equivalent of planting 1,250 trees. '
                                , style: GoogleFonts.roboto(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.lightTextBlack
                                  ),),
                              ],
                            ),
                            //---water----//
                            Column(
                              children: [
                                SizedBox(height: 20.h,),
                                Text('Compared to fast fashion, our marketplace has saved the, equivalent of planting 1,250 trees. '
                                  , style: GoogleFonts.roboto(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.lightTextBlack
                                  ),),
                              ],
                            ),
                            //---Waste----//
                            Column(
                              children: [
                                SizedBox(height: 20.h,),
                                Text('Compared to fast fashion, our marketplace has saved the, equivalent of planting 1,250 trees. '
                                  , style: GoogleFonts.roboto(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.lightTextBlack
                                  ),),
                              ],
                            ),
                          ]),

                        ],
                      ),
                    ),
                    SizedBox(height: 20.h,),
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
                          onTap: (){
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
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      height: 106.h,
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
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  description,
                  style: GoogleFonts.roboto(
                    fontSize: 14,
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
