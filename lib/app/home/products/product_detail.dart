import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saleko/app/home/products/product_detail_fullScreen.dart';
import 'package:saleko/app/widgets/feature_widget.dart';
import 'package:saleko/models/Products.dart';
import 'package:saleko/providers/product_provider.dart';
import 'package:saleko/providers/provider.dart';
import 'package:saleko/services/navigation/route_names.dart';
import 'package:saleko/utils/assets_manager.dart';
import 'package:saleko/utils/helpers.dart';
import 'package:saleko/utils/progress_bar_manager/utility_app_bar.dart';
import 'package:saleko/services/navigation/navigator_service.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../models/productModel.dart';
import '../../../providers/account_provider.dart';
import 'package:html/parser.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

// Create a provider to manage the current page index
final currentIndexProvider = StateProvider<int>((ref) => 0);

class ProductDetail extends ConsumerStatefulWidget {
  final Products newProducts;
  ProductDetail({super.key, required this.newProducts});

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

class _ProductDetailState extends ConsumerState<ProductDetail>
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

    return Scaffold(
      appBar: UtilityAppBar(text: "Details"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      final imageUrl =
                          widget.newProducts.imageUrls?[0].localUrl ?? "";
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FullScreenImagePage(imageUrl: imageUrl),
                        ),
                      );
                    },
                    child: CachedNetworkImage(
                      imageUrl: widget.newProducts.imageUrls?[0].localUrl ?? "",
                      imageBuilder: (context, imageProvider) => ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: Container(
                          height: 330,
                          width: 270,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      placeholder: (context, url) => SizedBox(
                        height: 330,
                        width: 270,
                        child: Center(
                          child: SizedBox(
                            width: 30.w,
                            height: 30.h,
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: Container(
                          height: 330,
                          width: 270,
                          child: Image.asset(
                            Assets.laptopPowerbank,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: SizedBox(
                    width: double.infinity,
                    height: 241.h,
                    child: ListView.builder(
                      padding: EdgeInsets.only(
                        left: 20,
                      ),
                      scrollDirection: Axis.vertical,
                      itemCount: widget.newProducts.imageUrls!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullScreenImagePage(
                                      imageUrl: widget.newProducts
                                              .imageUrls![index].localUrl ??
                                          ''),
                                ),
                              );
                            },
                            child: CachedNetworkImage(
                              // imageUrl:
                              //     widget.newProducts.imageUrls![index].localUrl ??
                              //         '',
                              imageUrl:
                                  widget.newProducts.imageUrls?.isNotEmpty ??
                                          false
                                      ? widget.newProducts.imageUrls![index]
                                              .localUrl ??
                                          ""
                                      : "",
                              imageBuilder: (context, imageProvider) =>
                                  ClipRRect(
                                borderRadius: BorderRadius.circular(15.r),
                                child: Container(
                                  //   padding: EdgeInsets.only(bottom: 10),
                                  height: 75,
                                  width: 75,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => SizedBox(
                                height: 75.w,
                                width: 75.w,
                                child: Center(
                                  child: SizedBox(
                                    width: 30.w,
                                    height: 30.h,
                                    child: CircularProgressIndicator(
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => ClipRRect(
                                borderRadius: BorderRadius.circular(15.r),
                                child: Image.asset(
                                  Assets.laptopPowerbank,
                                  height: 75,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ))
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              //
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      // onTap: () {
                      //   _navigation.navigateTo(
                      //     productBySeller,
                      //     arguments: widget.newProducts,
                      //   );
                      // },
                      onTap: () async {
                        final products = await productProvider
                            .selectedProductBySeller(widget.newProducts.seller?.merchantId??"");
                        if (products != null) {
                          productProvider.pushToAllScreen(
                            "Product Seller",
                            products,
                          );
                        }},
                      child: Container(
                        child: Row(
                          children: [
                            SvgPicture.asset(Assets.customerService),
                            SizedBox(width: 10.w),
                            Text(
                              "${widget.newProducts.seller?.shopTitle}",
                              style: TextStyle(
                                  color: AppColors.greenText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "${widget.newProducts.name}", //"Laptop Power Bank | Oraimo LP6JH",
                      style: TextStyle(
                          fontSize: 20,
                          color: AppColors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Brand: ${widget.newProducts.brandName ?? ""} | Category: ${widget.newProducts.categoryName} | In Stock: ${widget.newProducts.qty} UNITS",
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.greenText,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 198, 205, 203),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite_outline_outlined,
                                  color: AppColors.primaryColor,
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                              color: AppColors.greenFade,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.share_outlined,
                                  color: AppColors.primaryColor,
                                )),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        widget.newProducts.specialPrice != "0.0000"
                            ? Text(
                                "${currencyFormat.format(double.parse(widget.newProducts.price ?? "0.0"))}",
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: AppColors.greyText,
                                    decorationThickness: 2,
                                    color: AppColors.greyText,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              )
                            : Container(),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          widget.newProducts.specialPrice != "0.0000"
                              ? "${currencyFormat.format(double.parse(widget.newProducts.specialPrice ?? "0.0"))}"
                              : "${currencyFormat.format(double.parse(widget.newProducts.price ?? "0.0"))}",
                          // "#${widget.newProducts.price}",
                          style: GoogleFonts.roboto(
                              color: AppColors.red,
                              fontSize: 30,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        // discount
                        // Container(
                        //   width: 54.w,
                        //   height: 28.h,
                        //   decoration: BoxDecoration(
                        //       color: AppColors.red,
                        //       borderRadius: BorderRadius.circular(10)),
                        //   child: Center(
                        //       child: Text(
                        //     "15% off",
                        //     style: TextStyle(
                        //       color: AppColors.white,
                        //       fontSize: 12,
                        //     ),
                        //   )),
                        // ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          "Offer ends ${formatDate(widget.newProducts?.specialPriceTo)}",
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: 12,
                            decoration: TextDecoration.underline,
                            decorationThickness: 1,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),

                    //Tab bars for Description and Delivery details
                    // TabBar(
                    //   labelStyle:
                    //       TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    //   controller: _tabController,
                    //   indicatorColor: AppColors.primaryColor,
                    //   labelColor: AppColors.primaryColor,
                    //   unselectedLabelColor: AppColors.grey,
                    //   tabs: [
                    //     Tab(
                    //       text: "Description",
                    //     ),
                    //     Tab(text: "Delivery Details"),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height,
                    //   child: TabBarView(controller: _tabController,
                    //       children: [
                    //     //  Description Detail Tab Content
                    //     Padding(
                    //       padding: const EdgeInsets.symmetric(vertical: 20),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           HtmlWidget(
                    //             widget.newProducts.description ??
                    //                 "", // Handle null case
                    //             textStyle: TextStyle(
                    //               fontSize: 14,
                    //               color: AppColors.black,
                    //               fontWeight: FontWeight.w200,
                    //             ),
                    //           ),
                    //           SizedBox(height: 30.h),
                    //           Text(
                    //             "Features",
                    //             style: TextStyle(
                    //                 fontSize: 16,
                    //                 color: AppColors.blackTextColor,
                    //                 fontWeight: FontWeight.w600),
                    //           ),
                    //           SizedBox(
                    //             height: 10.h,
                    //           ),
                    //           feature_widget(
                    //             title:
                    //                 'Durable leather is easily cleanable so you can keep your look fresh.',
                    //           ),
                    //           SizedBox(
                    //             height: 10.h,
                    //           ),
                    //           feature_widget(
                    //             title:
                    //                 'Water-repellent finish and internal membrane help keep your feet dry.',
                    //           ),
                    //           SizedBox(
                    //             height: 10.h,
                    //           ),
                    //           feature_widget(
                    //             title:
                    //                 'Toe piece with star pattern adds durability.',
                    //           ),
                    //           SizedBox(
                    //             height: 10.h,
                    //           ),
                    //           feature_widget(
                    //             title:
                    //                 'Synthetic insulation helps keep you warm.',
                    //           ),
                    //           SizedBox(
                    //             height: 10.h,
                    //           ),
                    //           // feature_widget(
                    //           //   title:
                    //           //       'Originally designed for performance hoops, the Air unit delivers lightweight cushioning.',
                    //           // ),
                    //           // SizedBox(
                    //           //   height: 10.h,
                    //           // ),
                    //           // feature_widget(
                    //           //   title:
                    //           //       'Plush tongue wraps over the ankle to help keep out the moisture and cold.',
                    //           // ),
                    //           // SizedBox(
                    //           //   height: 10.h,
                    //           // ),
                    //           // feature_widget(
                    //           //   title:
                    //           //       'Rubber outsole with aggressive traction pattern adds durable grip.',
                    //           // ),
                    //           // SizedBox(
                    //           //   height: 10.h,
                    //           // ),
                    //           // feature_widget(
                    //           //   title:
                    //           //       'Durable leather is easily cleanable so you can keep your look fresh.',
                    //           // ),
                    //         ],
                    //       ),
                    //     ),
                    //
                    //     // Deliervy Detail Tab Content
                    //     Padding(
                    //       padding: const EdgeInsets.all(16.0),
                    //       child: Text(
                    //         "Delivery Detail view. "
                    //         "It provides information about the Delivery details and mmore.",
                    //         style: TextStyle(
                    //           fontSize: 14,
                    //           color: AppColors.black,
                    //         ),
                    //       ),
                    //     ),
                    //   ]),
                    // )
                    Container(
                      height: 300,
                      child: Column(
                        children: [
                          TabBar(
                            labelStyle: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                            controller: _tabController,
                            indicatorColor: AppColors.primaryColor,
                            labelColor: AppColors.primaryColor,
                            unselectedLabelColor: AppColors.grey,
                            tabs: [
                              Tab(
                                text: "Description",
                              ),
                              Tab(text: "Delivery Details"),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                // Description Tab
                                SingleChildScrollView(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      HtmlWidget(
                                          widget.newProducts.description ?? ""),
                                      SizedBox(height: 30.h),
                                      Text("Features",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                      SizedBox(height: 10.h),
                                      feature_widget(
                                        title:
                                            'Durable leather is easily cleanable so you can keep your look fresh.',
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      feature_widget(
                                        title:
                                            'Water-repellent finish and internal membrane help keep your feet dry.',
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      feature_widget(
                                        title:
                                            'Toe piece with star pattern adds durability.',
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      feature_widget(
                                        title:
                                            'Synthetic insulation helps keep you warm.',
                                      ),
                                    ],
                                  ),
                                ),

                                // Delivery Tab
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text("Delivery details go here."),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
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
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: removeQuantity,
                      child: Icon(Icons.remove, color: AppColors.white),
                    ),
                    SizedBox(width: 15),
                    Text(
                      "$quantity",
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 16),
                    GestureDetector(
                      onTap: addQuantity,
                      child: Icon(Icons.add, color: AppColors.white),
                    ),
                  ],
                ),
              ),
              // Add to Cart Button
              ElevatedButton(
                onPressed: () {
                  productProvider.addToCart(
                      widget.newProducts.sku ?? '', quantity);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                ),
                child: Text(
                  "Add to Cart",
                  style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
