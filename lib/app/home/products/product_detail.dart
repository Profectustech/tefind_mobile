import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/other_items.dart';
import '../widgets/make_offer_dialog.dart';
import '../widgets/product_gridview.dart';

// Create a provider to manage the current page index
//final currentIndexProvider = StateProvider<int>((ref) => 0);

class ProductDetail extends ConsumerStatefulWidget {
  final Products newProducts;
  ProductDetail({
    super.key,
      required this.newProducts
  });

  @override
  ConsumerState<ProductDetail> createState() => _ProductDetailState();
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

int expandedIndex = -1;

class _ProductDetailState extends ConsumerState<ProductDetail>
    with SingleTickerProviderStateMixin {
  late AccountProvider accountProvider;
  late ProductProvider productProvider;
  final NavigatorService _navigation = NavigatorService();
  late TabController _tabController;
  int quantity = 1;
  late PageController _pageController;
  int currentPageIndex = 0;


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
    _pageController = PageController();
    _tabController = TabController(length: 2, vsync: this); // Two tabs
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  bool isExpanded = false;
  bool isDescriptionExpanded = false;
  bool isDeliveryExpanded = false;
  bool isSafetyTips = false;
  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    productProvider = ref.watch(RiverpodProvider.productProvider);
    //final currentPageIndex = ref.watch(currentIndexProvider);

    return Scaffold(
      appBar: UtilityAppBar(
        text: widget.newProducts.name,
        centerTitle: false,
        hasActions: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Stack(
                  children: [
                    // 1. PageView for swiping images
                    SizedBox(
                      height: 300.h,
                      width: double.infinity,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: widget.newProducts.images.length,
                        onPageChanged: (index) {
                          setState(() {
                            currentPageIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return CachedNetworkImage(
                            imageUrl: widget.newProducts.images[index] ?? '',
                            imageBuilder: (context, imageProvider) => Container(
                              height: 300.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Center(
                              child: SizedBox(
                                width: 30.w,
                                height: 30.h,
                                child: const CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              Assets.laptopPowerbank,
                              height: 130.h,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(Icons.favorite_border_outlined),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          color: AppColors.yellow,
                          borderRadius: BorderRadius.circular(28.r),
                        ),
                        child: Text(
                          "Good",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10.h,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: AnimatedSmoothIndicator(
                          activeIndex: currentPageIndex,
                          count: widget.newProducts.images.length,
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
                    ),
                  ],
                ),
                SizedBox(
              height: 5.h,
            ),
            Container(
              height: 124.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.r)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "₦${widget.newProducts.price}",
                          style: GoogleFonts.roboto(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                    Text(
                      "${widget.newProducts.name}",
                      style: GoogleFonts.roboto(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      spacing: 15.w,
                      children: [
                        Row(
                          spacing: 2.w,
                          children: [
                            SvgPicture.asset(Assets.location),
                            Text(
                              "Lagos, Nigeria",
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
                            SvgPicture.asset(Assets.timeIcon),
                            Text(
                              "Posted on ${formatDate("${widget.newProducts.createdAt}")}",
                              style: GoogleFonts.roboto(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 100.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.r)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 10.w,
                      children: [
                        Text(
                          "Condition",
                          style: GoogleFonts.roboto(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              Assets.conditionIcon,
                              color: AppColors.yellow,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              "Good",
                              style: GoogleFonts.roboto(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "Gently used with minor signs of wear. No stains or damages.",
                      style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                ),
                child: AnimatedSize(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.fastOutSlowIn,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sized and Measurements',
                            style: GoogleFonts.roboto(
                                fontSize: 16.sp, fontWeight: FontWeight.w500),
                          ),
                          Icon(
                            isExpanded ? Icons.expand_less : Icons.expand_more,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      if (isExpanded) ...[
                        SizedBox(height: 16),
                        Text(
                          'Sizes and Measurement comes in Here',
                          style: TextStyle(color: Colors.black),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isDescriptionExpanded = !isDescriptionExpanded;
                });
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                ),
                child: AnimatedSize(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.fastOutSlowIn,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Description',
                            style: GoogleFonts.roboto(
                                fontSize: 16.sp, fontWeight: FontWeight.w500),
                          ),
                          Icon(
                            isDescriptionExpanded
                                ? Icons.expand_less
                                : Icons.expand_more,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      if (isDescriptionExpanded) ...[
                        SizedBox(height: 16.h),
                        Text(
                          widget.newProducts.description,
                          style: GoogleFonts.roboto(
                              color: AppColors.lightTextBlack),
                        ),
                        SizedBox(height: 16.h),
                      ]
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isDeliveryExpanded = !isDeliveryExpanded;
                });
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                ),
                child: AnimatedSize(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.fastOutSlowIn,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delivery and Payment',
                            style: GoogleFonts.roboto(
                                fontSize: 16.sp, fontWeight: FontWeight.w500),
                          ),
                          Icon(
                            isDeliveryExpanded
                                ? Icons.expand_less
                                : Icons.expand_more,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      if (isDeliveryExpanded) ...[
                        SizedBox(height: 16.h),
                        Column(
                          children: [
                            DeliveryPaymentOptions(
                              title: 'Delivery Available',
                              value: 'Within Lagos: ₦1,500',
                              image: 'delivery',
                              color: AppColors.lightGreen,
                            ),
                            SizedBox(height: 15.h),
                            DeliveryPaymentOptions(
                              title: 'Pickup Available',
                              value: 'Lekki, Nigeria',
                              image: 'delivery location',
                              color: AppColors.cyan,
                            ),
                            SizedBox(height: 15.h),
                            DeliveryPaymentOptions(
                              title: 'Payment Method',
                              value:
                                  'Cash, Bank Transfer, Secure In-App Payment',
                              image: 'delivery wallet',
                              color: AppColors.lightPurple,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                      ]
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 182.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.r)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Seller Information",
                      style: GoogleFonts.roboto(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 10.w,
                      children: [
                        Container(
                          height: 48.h,
                          width: 48.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/amara.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                 widget.newProducts.createdBy,//  "Amara Johnson",
                                  style: GoogleFonts.roboto(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.black),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Stars
                                Row(
                                  children: List.generate(5, (index) {
                                    double rating = widget.newProducts.rating.toDouble();
                                    if (index < rating.floor()) {
                                      return const Icon(Icons.star, color: Colors.amber, size: 18); // full star
                                    } else if (index < rating && rating - index >= 0.5) {
                                      return const Icon(Icons.star_half, color: Colors.amber, size: 18); // half star
                                    } else {
                                      return const Icon(Icons.star_border, color: Colors.amber, size: 18); // empty star
                                    }
                                  }),
                                ),

                                 SizedBox(width: 4.h),
                                Text(
                                  widget.newProducts.rating.toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '(36 reviews)',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Member since May 2023",
                              style: GoogleFonts.roboto(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.greyText),
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
                            width: 53.w,
                            height: 26.h,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: AppColors.primaryColor),
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "View",
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
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      spacing: 30.w,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                             widget.newProducts.stock.toString(),// "87",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Items",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.grey),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "187",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Sales",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.grey),
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
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0.w,
              ),
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
                    height: 238.h,
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
            GestureDetector(
              onTap: () {
                setState(() {
                  isSafetyTips = !isSafetyTips;
                });
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                ),
                child: AnimatedSize(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.fastOutSlowIn,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Safety Tips',
                            style: GoogleFonts.roboto(
                                fontSize: 16.sp, fontWeight: FontWeight.w500),
                          ),
                          Icon(
                            isSafetyTips
                                ? Icons.expand_less
                                : Icons.expand_more,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      if (isSafetyTips) ...[
                        SizedBox(height: 16.h),
                        Column(
                          children: [
                            Row(
                              spacing: 10.w,
                              children: [
                                Icon(
                                  Icons.check,
                                  color: AppColors.primaryColor,
                                  size: 20,
                                ),
                                Expanded(
                                  child: Text(
                                    'Meet in a public place for item inspection and exchange',
                                    style: GoogleFonts.roboto(
                                        color: AppColors.lightTextBlack,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15.h),
                            Row(
                              spacing: 10.w,
                              children: [
                                Icon(
                                  Icons.check,
                                  color: AppColors.primaryColor,
                                  size: 20,
                                ),
                                Expanded(
                                  child: Text(
                                    'Inspect the item thoroughly before making payment',
                                    style: GoogleFonts.roboto(
                                        color: AppColors.lightTextBlack,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15.h),
                            Row(
                              spacing: 10.w,
                              children: [
                                Icon(
                                  Icons.check,
                                  color: AppColors.primaryColor,
                                  size: 20,
                                ),
                                Expanded(
                                  child: Text(
                                    'Use secure payment methods available in the app',
                                    style: GoogleFonts.roboto(
                                        color: AppColors.lightTextBlack,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15.h),
                            Row(
                              spacing: 10.w,
                              children: [
                                Icon(
                                  Icons.check,
                                  color: AppColors.primaryColor,
                                  size: 20,
                                ),
                                Expanded(
                                  child: Text(
                                    'Be wary of deals that seem too good to be true',
                                    style: GoogleFonts.roboto(
                                        color: AppColors.lightTextBlack,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15.h),
                            Center(
                              child: GestureDetector(
                                onTap: ()=>_leaveReport(context),
                                child: Row(
                                  spacing: 5.w,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset('assets/images/flag.svg'),
                                    Text(
                                      'Report This Item',
                                      style: TextStyle(color: AppColors.red),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ]),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30.0, left: 20, right: 20),
        child: Row(
          spacing: 5.w,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => showMakeOfferDialog(context, widget.newProducts),
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
            Expanded(
              child: CustomButton(
                borderColor: AppColors.primaryColor,
                fillColor: AppColors.white,
                buttonTextColor: AppColors.primaryColor,
                label: 'Buy Now',
                onPressed: () {
                  // Handle Buy Now action
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}


void _leaveReport(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Report This Item',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  IconButton(onPressed: () {
                    Navigator.pop(context);
                  }, icon: Icon(Icons.close))
                ],
              ),
              Divider(thickness: 0.5,),
              Text(
                'Category',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextFormField(
                //controller: accountProvider.lastNameController,
                hint: 'Select Category to Report',
                // validator: Validators().isSignUpEmpty,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Message',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextFormField(
                maxLines: 4,
                //controller: accountProvider.lastNameController,
                hint: 'Type your message here',
                // validator: Validators().isSignUpEmpty,
              ),
              SizedBox(height: 20.h),
              CustomButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                fillColor: AppColors.primaryColor,
                label: 'Send Report',
                buttonTextColor: AppColors.white,
              )
            ],
          ),
        ),
      );
    },
  );
}


class DeliveryPaymentOptions extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final String image;
  const DeliveryPaymentOptions({
    super.key,
    required this.title,
    required this.value,
    required this.color,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5.w,
      children: [
        Container(
            height: 32.h,
            width: 32.w,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/images/$image.svg',
                width: 18.w,
                height: 18.h,
              ),
            )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.roboto(
                  fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
            Text(
              value,
              style: GoogleFonts.roboto(
                  color: AppColors.lightTextBlack, fontSize: 12.sp),
            ),
          ],
        ),
      ],
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
