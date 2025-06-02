import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:te_find/app/bottom_nav/nav_service.dart';
import 'package:te_find/app/home/check_out.dart';
import 'package:te_find/app/home/products/product_detail_fullScreen.dart';
import 'package:te_find/app/widgets/custom_button.dart';
import 'package:te_find/providers/payment_provider.dart';
import 'package:te_find/providers/provider.dart';
import 'package:te_find/services/navigation/route_names.dart';
import 'package:te_find/utils/assets_manager.dart';
import 'package:te_find/utils/helpers.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:te_find/app/widgets/search_box.dart';
import 'package:te_find/providers/product_provider.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/progress_bar_manager/appbar.dart';

import '../../providers/account_provider.dart';

class CartPage extends ConsumerStatefulWidget {
  CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => CartPageState();
}

class CartPageState extends ConsumerState<CartPage> {
  late AccountProvider accountProvider;
  late ProductProvider productProvider;
  late PaymentProvider paymentProvider;
  late NavStateProvider navStateProvider;
  final NavigatorService _navigation = NavigatorService();
  void signUp() {
    _navigation.navigateTo(signupScreenRoute);
  }

  @override
  void initState() {
    Future.microtask(() {
      productProvider.loopCartToAuth();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // when the cart provider is set i will use it
    // final cartsProduct = ref.watch(productsProvider);
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    productProvider = ref.watch(RiverpodProvider.productProvider);
    navStateProvider = ref.watch(RiverpodProvider.navStateProvider);
    paymentProvider = ref.watch(RiverpodProvider.paymentProvider);

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My Carts",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor),
              ),
              productProvider.cartModel?.data?.isEmpty ?? true
                  ? SizedBox()
                  : Text(
                      "${productProvider.cartModel?.data?.first.items?.length} items",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.grey),
                    )
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            width: double.infinity,
            height: 48.h,
            decoration: BoxDecoration(
              color: AppColors.greenLightest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Subtotal:",
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  productProvider.cartModel?.data?.isEmpty ?? true
                      ? currencyFormat.format(0.0)
                      : currencyFormat.format(double.parse(
                          productProvider.cartModel?.data?.first.subTotal ??
                              '0')),
                  style: TextStyle(
                      fontSize: 20,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          productProvider.cartModel?.data?.isNotEmpty ?? false
              ? Expanded(
                  child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount:
                      productProvider.cartModel?.data?.first.items?.length,
                  itemBuilder: (context, index) {
                    final product =
                        productProvider.cartModel?.data?.first.items?[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                          //height: 130.h,
                          width: 154.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.greenLightest),
                          padding: EdgeInsets.only(left: 10),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            FullScreenImagePage(
                                          imageUrl:
                                              product?.images?.first ?? '',
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 80.h,
                                    width: 80.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blueGrey.withOpacity(0.05),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: product?.images?.first ?? '',
                                      imageBuilder: (context, imageProvider) =>
                                          ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        child: Container(
                                          height: 115,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) => Center(
                                        child: SizedBox(
                                          width: 30.w,
                                          height: 30.h,
                                          child:
                                              const CircularProgressIndicator(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        child: Image.asset(
                                          Assets
                                              .laptopPowerbank, // Default image in case of error
                                          height: 115,
                                          width: double.infinity,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 11.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                width: 150.w,
                                                child: Text(
                                                  product?.name ?? '',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: AppColors.black,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                )),
                                            Text(
                                              product?.seller?.shopTitle ?? '',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: AppColors.grey,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 35.w,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              productProvider.removeFromCart(
                                                productId: accountProvider
                                                            .currentUser
                                                            .email !=
                                                        null
                                                    ? product?.product?.id ?? 0
                                                    : product?.sku ?? 0,
                                                cartItemId: product?.id ?? 0,
                                                cartId: product?.cartId ?? 0,
                                              );
                                            },
                                            child: CircleAvatar(
                                              radius: 13,
                                              backgroundColor: AppColors.red,
                                              child: SvgPicture.asset(
                                                Assets.delete,
                                              ),
                                            ))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      currencyFormat.format(
                                          double.parse(product?.price ?? '0')),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        // Text(
                                        //   "FEW UNITS LEFT",
                                        //   style: TextStyle(
                                        //       fontSize: 10,
                                        //       color: AppColors.red,
                                        //       fontWeight: FontWeight.w400),
                                        // ),
                                        // SizedBox(
                                        //   width: 100,
                                        // ),
                                        // SizedBox(
                                        //   width: 50.w,
                                        // ),
                                        InkWell(
                                            onTap: () {
                                              if (product?.quantity != 1) {
                                                productProvider.updateCart(
                                                  productId: accountProvider
                                                              .currentUser
                                                              .email !=
                                                          null
                                                      ? product?.product?.id ??
                                                          0
                                                      : product?.sku ?? 0,
                                                  quantity:
                                                      (product?.quantity ?? 2) -
                                                          1,
                                                  cartId: product?.cartId ?? 0,
                                                );
                                              }
                                            },
                                            child: Container(
                                                width: 25,
                                                height: 25,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 2,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7)),
                                                child: Icon(
                                                  Icons.remove,
                                                  size: 15,
                                                ))),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          "${product?.quantity}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              productProvider.updateCart(
                                                productId: accountProvider
                                                            .currentUser
                                                            .email !=
                                                        null
                                                    ? product?.product?.id ?? 0
                                                    : product?.sku ?? 0,
                                                quantity:
                                                    (product?.quantity ?? 1) +
                                                        1,
                                                cartId: product?.cartId ?? 0,
                                              );
                                            },
                                            child: Container(
                                                width: 25,
                                                height: 25,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 2,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7)),
                                                child: Icon(
                                                  Icons.add,
                                                  size: 15,
                                                ))),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )),
                    );
                  },
                ))
              : SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Image.asset(
                        height: 200,
                        width: 200,
                        Assets.cartEmpty,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Your cart is empty',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Great deals are waiting for you.',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: AppColors.grey)),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                          width: 200,
                          //  padding: EdgeInsets.only(left: 70, right: 70),
                          child: CustomButton(
                            label: "Start Shopping",
                            onPressed: () {
                              navStateProvider.setCurrentTabTo(newTabIndex: 0);
                              _navigation
                                  .pushAndRemoveUntil(bottomNavigationRoute);
                            },
                          )),
                    ],
                  ),
                ),
        ]),
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
        child: GestureDetector(
          onTap: () {
            if (accountProvider.currentUser.email != null) {
              paymentProvider
                  .changeCartId(productProvider.cartModel?.data?.first.id ?? 0);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CheckOutPage()));
            } else {
              _navigation.navigateTo(loginScreenRoute);
            }
          },
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
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Checkout (${productProvider.cartModel?.data?.isEmpty ?? true ? currencyFormat.format(0.0) : currencyFormat.format(double.parse(productProvider.cartModel?.data?.first.grandTotal ?? '0'))})",
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
