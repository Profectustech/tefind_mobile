import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/app/widgets/bottom_modals.dart';

import '../../utils/app_colors.dart';
import '../home/widgets/listings_gride_view.dart';

class ListingViewAll extends ConsumerStatefulWidget {
  const ListingViewAll({super.key});

  @override
  ConsumerState createState() => _ListingViewAllState();
}

class _ListingViewAllState extends ConsumerState<ListingViewAll> {
  List<String> items = ["All", "Active", "Sold", "Hidden", ];
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Listings',
          style:
              GoogleFonts.roboto(fontSize: 18.sp, fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  ListView.builder(
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
                          height: 32.h,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 3),
                          padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 0),
                          decoration: BoxDecoration(
                            color: current == index
                                ? AppColors.primaryColor
                                : AppColors.greyLight,
                            borderRadius: BorderRadius.circular(16.r),
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
                  SizedBox(width: 10.w,),
                  InkWell(
                    onTap: (){
                      BottomModals.sortingModal(context: context );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      height: 32.h,
                      width: 77.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Newest',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.lightTextBlack
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.lightTextBlack,)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            IndexedStack(index: current, children: [

              Column(
                children: [
                  SizedBox(height: 20.h,),
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 10, //productProvider.myProductByMerchant.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 7,
                      crossAxisSpacing: 7,
                      childAspectRatio: 0.80,
                    ),
                    itemBuilder: (context, index) {
                      //  final product = productProvider.myProductByMerchant[index];
                      return ListingsGrideView(
                        //  product: product
                      ); // Custom widget
                    },
                  ),
                ],
              ),
              //---water----//

              //---Waste----//

            ]),


          ],
        ),),
      )),
    );
  }
}
