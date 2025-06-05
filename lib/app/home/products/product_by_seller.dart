import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/app/home/products/selectedProduct.dart';
import 'package:te_find/providers/provider.dart';
import 'package:te_find/services/navigation/route_names.dart';
import 'package:te_find/utils/progress_bar_manager/utility_app_bar.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/utils/app_colors.dart';
import '../../../models/CategoriesModel.dart';
import '../../../models/Products.dart';
import '../../../providers/account_provider.dart';
import '../../../providers/product_provider.dart';
import '../../../utils/assets_manager.dart';
import '../../widgets/see_all_product.dart';
import '../widgets/listings_gride_view.dart';
import '../widgets/product_gridview.dart';

class ProductBySeller extends ConsumerStatefulWidget {
  // final Products product;
  ProductBySeller({
    super.key,
    //  required this.product
  });

  @override
  ConsumerState<ProductBySeller> createState() => _ProductBySellerState();
}

class _ProductBySellerState extends ConsumerState<ProductBySeller> {
  late AccountProvider accountProvider;
  late ProductProvider productProvider;
  final NavigatorService _navigation = NavigatorService();
  final List<String> paymentMethod= [
    'Bank Tansfer', //SvgPicture.asset(Assets.wallet),
    'Paypal',
    'Cash on Delivery',
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
                      'Make an Offer',
                      style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ),
                 SizedBox(height: 10.h),
                Text(
                  'Select item',
                  style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 11),
                ),
                 SizedBox(height: 5.h),
                // Dropdown
                DropdownButtonFormField<String>(
                  borderRadius: BorderRadius.circular(16),
                  decoration: InputDecoration(
                    fillColor: AppColors.grey,
                    hintText: 'Choose an item',
                    hintStyle: TextStyle(fontSize: 12.sp, color: AppColors.greyLight),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: AppColors.greyLight, width: 1.0),
                    ),
                  ),
                  items: ['Item 1', 'Item 2', 'Item 3']
                      .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item, style: TextStyle(fontSize: 14.sp, color: Color.fromRGBO(249, 250, 251, 1)))
                  ))
                      .toList(),
                  onChanged: (value) {},
                ),
                SizedBox(height: 12.h),
                Text(
                  'Your Offer (₦)',
                  style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 11),
                ),
                SizedBox(height: 5.h),
                // Offer Input
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    //LengthLimitingTextInputFormatter(10),
                  ],
                  decoration: InputDecoration(
                    fillColor: Color.fromRGBO(249, 250, 251, 1), //AppColors.greyLight,
                    hintStyle: TextStyle(color: AppColors.grey, fontSize: 12.sp),
                    hintText: 'Enter amount in Naira',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: AppColors.grey, width: 1.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child:GestureDetector(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.grey)
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
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
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                        child: Row(
                          spacing: 6.w,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Send Offer",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
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


  double fiveStarCount = 31;
  double totalReviews = 36;

  @override
  void initState() {
    Future.microtask(() {
      setState(() {
        // productProvider.setMyProductByMerchant(
        //    widget.product.seller?.merchantId?? "");
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = ref.watch(RiverpodProvider.productProvider);
    return Scaffold(
        appBar: UtilityAppBar(
          centerTitle: false,
          text: "Seller Name", //${widget.product.seller?.shopTitle??""}",
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  height: 354.h,
                  decoration: BoxDecoration(color: AppColors.white),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          height: 96.h,
                          width: 96.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 2.w, color: AppColors.primaryColor),
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor,
                            image: DecorationImage(
                              image: AssetImage('assets/images/bag.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Amara Johnson",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Stars
                            Row(
                              children: List.generate(5, (index) {
                                if (index < 4) {
                                  return const Icon(Icons.star,
                                      color: Colors.amber, size: 18);
                                } else {
                                  return const Icon(Icons.star_half,
                                      color: Colors.amber, size: 18);
                                }
                              }),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '4.8',
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
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Selling quality items since 2023",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        Divider(),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "42",
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Item Listed",
                          style: GoogleFonts.roboto(
                            fontSize: 12,
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
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 30.0, left: 20, right: 20),
                  child: GestureDetector(
                         onTap: () => showMakeOfferDialog(context),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(
                                0, -2), // Giving shadow above the container
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
                SizedBox(
                  height: 20.h,
                ),
                DefaultTabController(
                  length: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: TabBar(
                          labelColor: AppColors.primaryColor,
                          unselectedLabelColor: AppColors.grey,
                          indicatorColor: AppColors.primaryColor,
                          tabs: const [
                            Tab(text: 'Listings'),
                            Tab(text: 'Reviews'),
                            Tab(text: 'About'),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 520.h,
                        child: TabBarView(
                          children: [
                            // Tab 1 Content
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: GridView.builder(
                                //physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    10, //productProvider.myProductByMerchant.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 0.7,
                                ),
                                itemBuilder: (context, index) {
                                  //  final product = productProvider.myProductByMerchant[index];
                                  return ListingsGrideView(
                                      //  product: product
                                      ); // Custom widget
                                },
                              ),
                            ),

                            // Review Contents
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: ProfileReviewWidget(
                                  fiveStarCount: fiveStarCount,
                                  totalReviews: totalReviews),
                            ),
                            // About Contents
                            SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.h, horizontal: 10.w),
                                      height: 208.h,
                                      decoration:
                                          BoxDecoration(color: AppColors.white),
                                      child: Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'About Amara',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Text(
                                              "Hello! I'm Amara, a fashion enthusiast based in Lagos. I sell authentic luxury items from my personal collection and items sourced from trusted suppliers. All items are guaranteed authentic or your money back. I take pride in providing excellent customer service and ensuring a smooth transaction experience.",
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.h, horizontal: 10.w),
                                      height: 208.h,
                                      width: double.infinity,
                                      decoration:
                                          BoxDecoration(color: AppColors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Seller Information',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Joined",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: AppColors.grey),
                                                  ),
                                                  Text(
                                                    "March 2023",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Total Sales",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: AppColors.grey),
                                                  ),
                                                  Text(
                                                    "87 items",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Divider(),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Location",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.grey),
                                          ),
                                          Row(
                                            spacing: 5.w,
                                            children: [
                                              SvgPicture.asset(Assets.location),
                                              Text(
                                                "Lekki, Lagos, Nigeria",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.h, horizontal: 10.w),
                                      height: 394.h,
                                      width: double.infinity,
                                      decoration:
                                          BoxDecoration(color: AppColors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Payment and Shipping',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            'Accepted Payment Methods',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.grey),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Wrap(
                                            spacing: 10, // space between items
                                            runSpacing: 10, // space between lines
                                            children: paymentMethod.map((tag) {
                                              return Container(
                                                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                                decoration: BoxDecoration(
                                                  color: AppColors.greyLight,
                                                  borderRadius: BorderRadius.circular(30),
                                                  border: Border.all(color: Colors.grey.shade300),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      blurRadius: 2,
                                                      offset: Offset(0, 1),
                                                    )
                                                  ],
                                                ),
                                                child: Text(
                                                  tag,
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              );
                                            }).toList(),),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Shipping Options",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors.grey),
                                              ),
                                              SizedBox(height: 5.h
                                                ,),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Standard Shipping",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Text(
                                                    "₦1,500",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5.h
                                                ,),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Express Shipping",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Text(
                                                    "₦1,500",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5.h
                                                ,),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Local Pickup",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Text(
                                                    "₦1,500",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 20.h),
                                              Text(
                                                "Return Policy",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors.grey),
                                              ),
                                              SizedBox(height: 5.h
                                                ,),
                                              Text(
                                                "Returns accepted within 3 days of delivery if item is not as described. Buyer pays return shipping. Contact me before returning any item. ",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                  FontWeight.w400,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ])),
        ));
  }
}

class ProfileReviewWidget extends StatelessWidget {
  const ProfileReviewWidget({
    super.key,
    required this.fiveStarCount,
    required this.totalReviews,
  });

  final double fiveStarCount;
  final double totalReviews;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          height: 205.h,
          decoration: BoxDecoration(color: AppColors.white),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 10,
                  children: [
                    Text(
                      "4.8",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            if (index < 4) {
                              return const Icon(Icons.star,
                                  color: Colors.amber, size: 18);
                            } else {
                              return const Icon(Icons.star_half,
                                  color: Colors.amber, size: 18);
                            }
                          }),
                        ),
                        Text(
                          'Based on 36 reviews',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  spacing: 10,
                  children: [
                    Row(
                      children: [
                        Text(
                          "5",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Icon(
                          Icons.star,
                          size: 12,
                        )
                      ],
                    ),
                    Expanded(
                      child: LinearProgressIndicator(
                        borderRadius: BorderRadius.circular(10),
                        minHeight: 10,
                        value: fiveStarCount / totalReviews,
                        backgroundColor: AppColors.grey,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primaryColor),
                      ),
                    ),
                    Text(
                      "31",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  spacing: 10,
                  children: [
                    Row(
                      children: [
                        Text(
                          "4",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Icon(
                          Icons.star,
                          size: 12,
                        )
                      ],
                    ),
                    Expanded(
                      child: LinearProgressIndicator(
                        borderRadius: BorderRadius.circular(10),
                        minHeight: 10,
                        value: fiveStarCount / totalReviews,
                        backgroundColor: AppColors.grey,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primaryColor),
                      ),
                    ),
                    Text(
                      "31",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  spacing: 10,
                  children: [
                    Row(
                      children: [
                        Text(
                          "3",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Icon(
                          Icons.star,
                          size: 12,
                        )
                      ],
                    ),
                    Expanded(
                      child: LinearProgressIndicator(
                        borderRadius: BorderRadius.circular(10),
                        minHeight: 10,
                        value: fiveStarCount / totalReviews,
                        backgroundColor: AppColors.grey,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primaryColor),
                      ),
                    ),
                    Text(
                      "31",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  spacing: 10,
                  children: [
                    Row(
                      children: [
                        Text(
                          "2",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Icon(
                          Icons.star,
                          size: 12,
                        )
                      ],
                    ),
                    Expanded(
                      child: LinearProgressIndicator(
                        borderRadius: BorderRadius.circular(10),
                        minHeight: 10,
                        value: fiveStarCount / totalReviews,
                        backgroundColor: AppColors.grey,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primaryColor),
                      ),
                    ),
                    Text(
                      "31",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  spacing: 10,
                  children: [
                    Row(
                      children: [
                        Text(
                          "1",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Icon(
                          Icons.star,
                          size: 12,
                        )
                      ],
                    ),
                    Expanded(
                      child: LinearProgressIndicator(
                        borderRadius: BorderRadius.circular(10),
                        minHeight: 10,
                        value: fiveStarCount / totalReviews,
                        backgroundColor: AppColors.grey,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primaryColor),
                      ),
                    ),
                    Text(
                      "31",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10.w,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          height: 217.h,
          decoration: BoxDecoration(color: AppColors.white),
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
                          image: AssetImage('assets/images/bag.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Oluwaseun Adebayo',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: List.generate(5, (index) {
                            if (index < 4) {
                              return const Icon(Icons.star,
                                  color: Colors.amber, size: 18);
                            } else {
                              return const Icon(Icons.star_half,
                                  color: Colors.amber, size: 18);
                            }
                          }),
                        ),
                      ],
                    ),
                    Text(
                      'March 25, 2025',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 55.w),
                  child: Column(
                    children: [
                      Text(
                        'Excellent seller! The handbag was exactly as described and in perfect condition. Fast shipping and great communication throughout the process.',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        spacing: 10.w,
                        children: [
                          Container(
                            height: 48.h,
                            width: 48.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: AppColors.primaryColor,
                              image: DecorationImage(
                                image: AssetImage('assets/images/bag.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            'Luxury Leather Handbag',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.grey),
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
      ],
    );
  }
}
