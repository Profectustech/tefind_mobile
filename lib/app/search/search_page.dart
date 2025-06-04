import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/app/widgets/bottom_modals.dart';
import 'package:te_find/utils/progress_bar_manager/utility_app_bar.dart';

import '../../utils/app_colors.dart';
import '../../utils/assets_manager.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final List<Map<String, dynamic>> search = [
    {
      'title': 'summer fashion(2.3k)',
      'icon': SvgPicture.asset('assets/images/fire.svg'),
    },
    {
      'title': 'designer bags(1.1k)',
      'icon': SvgPicture.asset('assets/images/fire.svg'),
    },
    {
      'title': 'athletics wear (950)',
      'icon': SvgPicture.asset('assets/images/fire.svg'),
    },
  ];

  void showMakeOfferDialog(BuildContext context) {
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
                      'Delete Saved Search',
                      style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Text(
                  'Are you sure you want to delete this saved search? This action cannot be undone.',
                  style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.lightTextBlack),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.grey)
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        child: Row(
                          spacing: 6.w,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Close",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      child: Row(
                        spacing: 6.w,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Delete",
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColors.white,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Search',
            style: GoogleFonts.roboto(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0.w,
              vertical: 8.0.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  height: 40.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: SearchBar(
                          // controller: controller ,
                          elevation: MaterialStateProperty.all(0.0),
                          backgroundColor: MaterialStateProperty.all(
                            AppColors.white,
                          ),
                          padding: MaterialStateProperty.all(
                            EdgeInsets.only(left: 10.0, right: 0),
                          ),
                          leading: SvgPicture.asset(
                            "assets/images/searchIcon.svg",
                            color: AppColors.greenLighter,
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11.42.r),
                            ),
                          ),
                          onChanged: (v) {
                            // if (onChanged != null) {
                            //   onChanged!(v);
                            // }
                          },
                          hintText:
                              'Search for products, brands, or categories',
                          hintStyle: MaterialStateProperty.all(
                            TextStyle(
                              color: AppColors.greenLighter,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SvgPicture.asset(Assets.filter),
                    ],
                  ),
                ),
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FilterOptions(
                      image: 'dollarIcon',
                      title: 'Price',
                      onTap: () {
                        BottomModals.priceModal(context: context);
                      },
                    ),
                    FilterOptions(
                      image: 'condition',
                      title: 'Condition',
                      onTap: () {
                        BottomModals.condition(context: context);
                      },
                    ),
                    FilterOptions(
                      image: 'category',
                      title: 'Category',
                      onTap: () {
                        BottomModals.categoryModal(context: context);

                        // Implement filter action
                      },
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Recent Searches',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        )),
                    GestureDetector(
                      onTap: () {},
                      child: Text('Clear All',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.access_time_sharp,
                          color: AppColors.grey, size: 18), // SvgPicture
                      SizedBox(width: 8),
                      Text(
                        'Summer dresses',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.close,
                        color: AppColors.grey,
                        size: 18,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h),
                Text(
                  'Trending Searches',
                  style: GoogleFonts.roboto(
                    color: AppColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 16.h),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: search.map((tag) {
                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 1,
                            offset: Offset(0, 0.5),
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          tag['icon'], // SvgPicture
                          SizedBox(width: 8),
                          Text(
                            tag['title'],
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Saved Searches',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        )),
                    GestureDetector(
                      onTap: () {
                        BottomModals.manageSearch(context: context);
                      },
                      child: Text('Manage',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset('assets/images/badge.svg'),
                          SizedBox(width: 8),
                          Text(
                            'Designer bags under ₦50,000',
                            style: GoogleFonts.roboto(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: ()=>showMakeOfferDialog(context),
                            child: Container(
                                height: 32.h,
                                width: 32.w,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.greyLight),
                                child: Center(
                                  child: SvgPicture.asset(
                                    Assets.deleteIcon,
                                    color: AppColors.grey,
                                    height: 15.h,
                                    width: 15.w,
                                  ),
                                )),
                          ),
                          Transform.scale(
                            scale: 0.8,
                            child: Switch.adaptive(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              value: true,
                              activeTrackColor: AppColors.primaryColor,
                              activeColor: Colors.white,
                              inactiveTrackColor: Colors.grey[300],
                              inactiveThumbColor: Colors.white,
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.greyLight,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          'Designer',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Results(32)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        )),
                    InkWell(
                      onTap: () {
                        BottomModals.saveSearch(context: context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 7.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset('assets/images/badge.svg'),
                            SizedBox(
                              width: 5.h,
                            ),
                            Text(
                              'Save Search',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class FilterOptions extends StatelessWidget {
  final String image;
  final String title;
  final Function()? onTap;
  const FilterOptions({
    super.key,
    required this.image,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset('assets/images/$image.svg'),
            SizedBox(
              width: 5.h,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              width: 5.h,
            ),
            Icon(
              Icons.keyboard_arrow_down_sharp,
              size: 15,
              color: AppColors.grey,
            )
          ],
        ),
      ),
    );
  }
}
