import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:te_find/app/home/products/product_detail_fullScreen.dart';
import 'package:te_find/app/widgets/feature_widget.dart';
import 'package:te_find/models/Products.dart';
import 'package:te_find/providers/product_provider.dart';
import 'package:te_find/providers/provider.dart';
import 'package:te_find/services/navigation/route_names.dart';
import 'package:te_find/utils/assets_manager.dart';
import 'package:te_find/utils/helpers.dart';
import 'package:te_find/utils/progress_bar_manager/utility_app_bar.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../models/productModel.dart';
import '../../../providers/account_provider.dart';
import 'package:html/parser.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

import '../../widgets/global.dart';
import '../../widgets/other_items.dart';
import '../widgets/product_gridview.dart';
import 'make_offer_dialog.dart';

// Create a provider to manage the current page index
final currentIndexProvider = StateProvider<int>((ref) => 0);

class FeaturedProductDetail extends ConsumerStatefulWidget {
  /// final Products newProducts;
  FeaturedProductDetail({
    super.key,
    //   required this.newProducts
  });

  @override
  ConsumerState<FeaturedProductDetail> createState() =>
      _FeaturedProductDetailState();
}

// to format html to flutter text
String stripHtmlTags(String htmlText) {
  var document = parse(htmlText);
  return document.body?.text ?? "";
}

//To format the date
String formatDate(String? dateString) {
  if (dateString == null || dateString.isEmpty) return "";

  try {
    DateTime date = DateTime.parse(dateString);
    return DateFormat("MMMM d").format(date);
  } catch (e) {
    return "";
  }
}

class _FeaturedProductDetailState extends ConsumerState<FeaturedProductDetail>
    with SingleTickerProviderStateMixin {
  late AccountProvider accountProvider;
  late ProductProvider productProvider;
  final NavigatorService _navigation = NavigatorService();
  late TabController _tabController;
  int quantity = 1;

  addQuantity() {
    setState(() {
      quantity++;
    });
  }

  removeQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  //navigation
  void signUp() {
    _navigation.navigateTo(signupScreenRoute);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // Two tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    productProvider = ref.watch(RiverpodProvider.productProvider);
    final currentPageIndex = ref.watch(currentIndexProvider);

    return Scaffold(
      appBar: UtilityAppBar(
        text: "Product Name",
        centerTitle: false,
        hasActions: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Stack(
              children: [
                Container(
                  height: 280.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    image: DecorationImage(
                      image: AssetImage('assets/images/bag.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
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
                  bottom: 10,
                  left: 10,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 25.w, vertical: 5.h),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(28.r)),
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
                Positioned(
                  bottom: 10.h,
                  left: 170.w,
                  child: AnimatedSmoothIndicator(
                    activeIndex: currentPageIndex,
                    count: 3,
                    effect: ScrollingDotsEffect(
                      spacing: 4.0,
                      dotWidth: 8.0,
                      dotHeight: 7.0,
                      strokeWidth: 8,
                      dotColor: AppColors.grey,
                      activeDotColor: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 164.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.r)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Luxury Leather Handbag",
                      style: GoogleFonts.roboto(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "₦45,000",
                          style: GoogleFonts.roboto(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryColor),
                        ),
                        InkWell(
                          onTap: () {
                            globalScaffoldKey.currentState?.openEndDrawer();
                          },
                          child: Center(
                              child: Container(
                            width: 66.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                                color: AppColors.containerWhite,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Add To Cart",
                                  style: GoogleFonts.roboto(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryColor),
                                )
                              ],
                            ),
                          )),
                        )
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      spacing: 15.w,
                      children: [
                        Row(
                          spacing: 2.w,
                          children: [
                            SvgPicture.asset(Assets.conditionIcon),
                            Text(
                              "Like New",
                              style: GoogleFonts.roboto(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black),
                            )
                          ],
                        ),
                        Row(
                          spacing: 2.w,
                          children: [
                            SvgPicture.asset(Assets.location),
                            Text(
                              "Lekki, Lagos",
                              style: GoogleFonts.roboto(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      spacing: 2.w,
                      children: [
                        SvgPicture.asset(Assets.timeIcon),
                        Text(
                          "Posted on ${formatDate("2023-10-01")}",
                          style: GoogleFonts.roboto(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 97.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.r)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 15.w,
                  children: [
                    Container(
                      height: 48.h,
                      width: 48.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/bag.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Amara Johnson",
                          style: GoogleFonts.roboto(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black),
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          spacing: 5.w,
                          children: [
                            Text(
                              "Joined",
                              style: GoogleFonts.roboto(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.greyText),
                            ),
                            Text(
                              "March 2023",
                              style: GoogleFonts.roboto(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black),
                            )
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        NavigatorService().navigateTo(
                          productBySeller,
                          // arguments: widget.newProducts,
                        );
                      },
                      child: Center(
                          child: Container(
                        width: 73.w,
                        height: 28.h,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: AppColors.primaryColor),
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "View Profile",
                              style: GoogleFonts.roboto(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor),
                            )
                          ],
                        ),
                      )),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 410.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.r)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description",
                      style: GoogleFonts.roboto(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Authentic luxury leather handbag in excellent condition. This elegant piece features premium full-grain leather with minimal signs of use.",
                      style: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductInformation(
                          subject: "Brand",
                          value: "Milano Luxury",
                        ),
                        ProductInformation(
                          subject: "Material",
                          value: "Genuine Leather",
                        ),
                        ProductInformation(
                          subject: "Color",
                          value: "Rich Brown",
                        ),
                        ProductInformation(
                          subject: "Dimensions",
                          value: "30cm x 22cm x 12cm",
                        ),
                        ProductInformation(
                          subject: "Hardware",
                          value: "Gold-tone",
                        ),
                        ProductInformation(
                          subject: "Condition",
                          value: "Like new, minimal wear",
                        ),
                      ],
                    ),
                    Text(
                      "Includes original dust bag and authenticity card. Perfect for both casual and formal occasions. This timeless piece will elevate any outfit.",
                      style: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      "No trades. Serious inquiries only.",
                      style: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 192.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.r)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Item Location",
                      style: GoogleFonts.roboto(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                        height: 120.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColors.greenLightest,
                            borderRadius: BorderRadius.circular(16.r)),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 20.h),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.w, vertical: 5.h),
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius:
                                            BorderRadius.circular(28.r)),
                                    child: Text(
                                      "Lekki, Lagos",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.black),
                                    ),
                                  ),
                                ]))),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Similar Items",
                    style: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 241.h,
                    child: ListView.builder(
                      padding: EdgeInsets.only(left: 5),
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        // Products negotiableProducts =
                        // productProvider
                        //     .negotiableProduct![index];
                        return OtherItems();
                        ;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30.0, left: 20, right: 20),
        child: GestureDetector(
        //  onTap: () => showMakeOfferDialog(context),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -2), // Giving shadow above the container
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            child: Row(
              spacing: 6.w,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.offerIcon),
                Text(
                  "Make Offer",
                  style: TextStyle(
                      fontSize: 14,
                      color: AppColors.white,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductInformation extends StatelessWidget {
  final String subject;
  final String value;

  const ProductInformation({
    super.key,
    required this.value,
    required this.subject,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "$subject:",
              style: GoogleFonts.roboto(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.roboto(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
