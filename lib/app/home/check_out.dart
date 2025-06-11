import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:te_find/app/home/products/product_detail_fullScreen.dart';
import 'package:te_find/app/home/widgets/shoppingCartListView.dart';
import 'package:te_find/app/widgets/couponTextFormField.dart';
import 'package:te_find/app/widgets/custom_bottom_sheet.dart';
import 'package:te_find/app/widgets/custom_button.dart';
import 'package:te_find/app/widgets/custom_text_form_field.dart';
import 'package:te_find/app/widgets/feature_widget.dart';
import 'package:te_find/models/product.dart';
import 'package:te_find/providers/app_nav_notifier.dart';
import 'package:te_find/providers/payment_provider.dart';
import 'package:te_find/providers/provider.dart';
import 'package:te_find/services/navigation/route_names.dart';
import 'package:te_find/utils/assets_manager.dart';
import 'package:te_find/utils/progress_bar_manager/utility_app_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:te_find/app/widgets/search_box.dart';
import 'package:te_find/providers/product_provider.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/progress_bar_manager/appbar.dart';

import '../../providers/account_provider.dart';
import '../../utils/helpers.dart';
import '../bottom_nav/nav_service.dart';

// Create a provider to manage the current page index
final currentIndexProvider = StateProvider<int>((ref) => 0);
final selectedOptionProvider = StateProvider<String>((ref) => 'Delivery');
final selectedPaymentProvider = StateProvider<String>((ref) => 'Payment');

class CheckOutPage extends ConsumerStatefulWidget {
  // final Product product;
  // final Product product;
  CheckOutPage({super.key});

  @override
  ConsumerState<CheckOutPage> createState() => _CheckOutPage();
  final NavigatorService _navigation = NavigatorService();
}

class _CheckOutPage extends ConsumerState<CheckOutPage>
    with SingleTickerProviderStateMixin {
  late AccountProvider accountProvider;
  late ProductProvider productProvider;
  late PaymentProvider paymentProvider;
  late NavStateProvider navStateProvider;
  final NavigatorService _navigation = NavigatorService();
  late TabController _tabController;
  //navigation
  void payment() {
    _navigation.navigateTo(payWithWallet);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Future.microtask(() {
      accountProvider.getPickUpAddress();
      productProvider.fetchCart();
    });
  }
  // @override
  // void initState() {
  //   super.initState();
  // / Two for shopping cart and delivery tabs
  // }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // For botton nav bar
    final currentTabIndex = ref.watch(tabIndexProvider);
    _tabController.index = currentTabIndex;
    // for the rest widget
    accountProvider = ref.watch(RiverpodProvider.accountProvider);
    productProvider = ref.watch(RiverpodProvider.productProvider);
    navStateProvider = ref.watch(RiverpodProvider.navStateProvider);
    paymentProvider = ref.watch(RiverpodProvider.paymentProvider);
    final addressList = accountProvider.addressList ?? [];
    final selectedAddress = accountProvider.getSelectedAddress(addressList);
    final pickUpList = accountProvider.pickUpAddress ?? [];
    final selectedPickUpAddress =
        accountProvider.getSelectedPickUpAddress(pickUpList);

    // for delivery and pickup radio bottons
    final selectedOption = ref.watch(selectedOptionProvider);
    // for payment method radio bottom
    final paymentOption = ref.watch(selectedPaymentProvider);

    return Scaffold(
        appBar: UtilityAppBar(
          text: "Checkout",
          hasActions: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TabBar(
                      labelStyle:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                      controller: _tabController,
                      // newly added
                      onTap: (index) {
                        ref
                            .read(tabIndexProvider.notifier)
                            .setTabIndex(index); // to help Update state
                      },
                      indicatorColor: AppColors.primaryColor,
                      labelColor: AppColors.primaryColor,
                      unselectedLabelColor: AppColors.grey,
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                          width: 4.0, // Adjust thickness of the indicator
                          color: AppColors.primaryColor, // Indicator color
                        ),
                        insets: EdgeInsets.symmetric(
                            horizontal: -40), // Adjust width of the indicator
                      ),
                      tabs: [
                        Tab(
                          text: "Shoping Cart",
                        ),
                        Tab(text: "Delivery and Payment"),
                      ],
                    ),
                    Container(
                      height: 700,
                      child: TabBarView(controller: _tabController, children: [
                        //  Shopping cart
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                productProvider.cartModel?.data?.isNotEmpty ??
                                        false
                                    ? SizedBox(
                                        height: 500.h,
                                        child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount: productProvider.cartModel
                                              ?.data?.first.items?.length,
                                          itemBuilder: (context, index) {
                                            final product = productProvider
                                                .cartModel
                                                ?.data
                                                ?.first
                                                .items?[index];
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10.h),
                                              child: Container(
                                                  height: 145.h,
                                                  width: 154.w,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.r),
                                                      color: AppColors
                                                          .greenLightest),
                                                  padding: EdgeInsets.only(
                                                      left: 10.w),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5.h),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        FullScreenImagePage(
                                                                  imageUrl: product
                                                                          ?.images
                                                                          ?.first ??
                                                                      '',
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: Container(
                                                            height: 80.h,
                                                            width: 80.w,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: Colors
                                                                  .blueGrey
                                                                  .withOpacity(
                                                                      0.05),
                                                            ),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: product
                                                                      ?.images
                                                                      ?.first ??
                                                                  '',
                                                              imageBuilder:
                                                                  (context,
                                                                          imageProvider) =>
                                                                      ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15.r),
                                                                child:
                                                                    Container(
                                                                  height: 115,
                                                                  width: double
                                                                      .infinity,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      image:
                                                                          imageProvider,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              placeholder:
                                                                  (context,
                                                                          url) =>
                                                                      Center(
                                                                child: SizedBox(
                                                                  width: 30.w,
                                                                  height: 30.h,
                                                                  child:
                                                                      const CircularProgressIndicator(
                                                                    color: AppColors
                                                                        .primaryColor,
                                                                  ),
                                                                ),
                                                              ),
                                                              errorWidget:
                                                                  (context, url,
                                                                          error) =>
                                                                      ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15.r),
                                                                child:
                                                                    Image.asset(
                                                                  Assets
                                                                      .laptopPowerbank, // Default image in case of error
                                                                  height: 115,
                                                                  width: double
                                                                      .infinity,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 11.w,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                        width: 150
                                                                            .w,
                                                                        child:
                                                                            Text(
                                                                          product?.name ??
                                                                              '',
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              color: AppColors.black,
                                                                              fontWeight: FontWeight.w400),
                                                                        )),
                                                                    Text(
                                                                      product?.seller
                                                                              ?.shopTitle ??
                                                                          '',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color: AppColors
                                                                              .grey,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  width: 35.w,
                                                                ),
                                                                InkWell(
                                                                    onTap: () {
                                                                      productProvider
                                                                          .removeFromCart(
                                                                        productId: accountProvider.currentUser.email != null
                                                                            ? product?.product?.id ??
                                                                                0
                                                                            : product?.sku ??
                                                                                0,
                                                                        cartItemId:
                                                                            product?.id ??
                                                                                0,
                                                                        cartId:
                                                                            product?.cartId ??
                                                                                0,
                                                                      );
                                                                    },
                                                                    child:
                                                                        CircleAvatar(
                                                                      radius:
                                                                          13,
                                                                      backgroundColor:
                                                                          AppColors
                                                                              .red,
                                                                      child: SvgPicture
                                                                          .asset(
                                                                        Assets
                                                                            .delete,
                                                                      ),
                                                                    ))
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10.h,
                                                            ),
                                                            Text(
                                                              currencyFormat.format(
                                                                  double.parse(
                                                                      product?.price ??
                                                                          '0')),
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color:
                                                                      AppColors
                                                                          .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                InkWell(
                                                                    onTap: () {
                                                                      if (product
                                                                              ?.quantity !=
                                                                          1) {
                                                                        productProvider
                                                                            .updateCart(
                                                                          productId:
                                                                              product?.product?.id ?? 0,
                                                                          quantity:
                                                                              (product?.quantity ?? 2) - 1,
                                                                          cartId:
                                                                              product?.cartId ?? 0,
                                                                        );
                                                                      }
                                                                    },
                                                                    child: Container(
                                                                        width: 25,
                                                                        height: 25,
                                                                        decoration: BoxDecoration(
                                                                            border: Border.all(
                                                                              width: 2,
                                                                              color: AppColors.primaryColor,
                                                                            ),
                                                                            borderRadius: BorderRadius.circular(7)),
                                                                        child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          size:
                                                                              15,
                                                                        ))),
                                                                SizedBox(
                                                                  width: 5.w,
                                                                ),
                                                                Text(
                                                                  "${product?.quantity}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      color: AppColors
                                                                          .primaryColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                                SizedBox(
                                                                  width: 5.w,
                                                                ),
                                                                InkWell(
                                                                    onTap: () {
                                                                      productProvider
                                                                          .updateCart(
                                                                        productId:
                                                                            product?.product?.id ??
                                                                                0,
                                                                        quantity:
                                                                            (product?.quantity ?? 0) +
                                                                                1,
                                                                        cartId:
                                                                            product?.cartId ??
                                                                                0,
                                                                      );
                                                                    },
                                                                    child: Container(
                                                                        width: 25,
                                                                        height: 25,
                                                                        decoration: BoxDecoration(
                                                                            border: Border.all(
                                                                              width: 2,
                                                                              color: AppColors.primaryColor,
                                                                            ),
                                                                            borderRadius: BorderRadius.circular(7)),
                                                                        child: Icon(
                                                                          Icons
                                                                              .add,
                                                                          size:
                                                                              15,
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
                                        ),
                                      )
                                    : SizedBox(
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
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
                                              Text(
                                                  'Great deals are waiting for you.',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                                      navStateProvider
                                                          .setCurrentTabTo(
                                                              newTabIndex: 0);
                                                      _navigation
                                                          .pushAndRemoveUntil(
                                                              bottomNavigationRoute);
                                                    },
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),

                        // Delivery and payment
                        SingleChildScrollView(
                          // physics: NeverScrollableScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Delivery Container
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: GestureDetector(
                                          onTap: () {
                                            ref
                                                .read(selectedOptionProvider
                                                    .notifier)
                                                .state = 'Delivery';
                                          },
                                          child: Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color:
                                                  selectedOption == 'Delivery'
                                                      ? AppColors.primaryColor
                                                      : AppColors.greenLightest,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                top: 5,
                                                bottom: 5,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Doorstep Delivery',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: selectedOption ==
                                                              'Delivery'
                                                          ? AppColors.white
                                                          : AppColors
                                                              .primaryColor,
                                                    ),
                                                  ),
                                                  Radio<String>(
                                                    activeColor:
                                                        AppColors.white,
                                                    value: 'Delivery',
                                                    groupValue: selectedOption,
                                                    onChanged: (value) {
                                                      // This ensures the Radio button still works if clicked
                                                      ref
                                                          .read(
                                                              selectedOptionProvider
                                                                  .notifier)
                                                          .state = value!;
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                        width: 40.w,
                                      ),

                                      // Pickup

                                      GestureDetector(
                                        onTap: () {
                                          ref
                                              .read(selectedOptionProvider
                                                  .notifier)
                                              .state = 'Pickup';
                                        },
                                        child: Container(
                                          width: 112,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: selectedOption == 'Pickup'
                                                ? AppColors.primaryColor
                                                : AppColors.greenLightest,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5,
                                                bottom: 5,
                                                left: 10,
                                                right: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Pickup',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: selectedOption ==
                                                            'Pickup'
                                                        ? AppColors.white
                                                        : AppColors
                                                            .primaryColor,
                                                  ),
                                                ),
                                                Radio<String>(
                                                  activeColor: AppColors.white,
                                                  value: 'Pickup',
                                                  groupValue: selectedOption,
                                                  onChanged: (value) {
                                                    ref
                                                        .read(
                                                            selectedOptionProvider
                                                                .notifier)
                                                        .state = value!;
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                selectedOption == 'Delivery'
                                    ? GestureDetector(
                                        onTap: () {
                                          CustomBottomSheet.show(
                                            isDismissible: true,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 10.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Delivery Address",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      IconButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          icon:
                                                              Icon(Icons.close))
                                                    ],
                                                  ),
                                                  SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        ListTile(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          2.h),
                                                          leading: CircleAvatar(
                                                            backgroundColor:
                                                                Colors.teal
                                                                    .shade100,
                                                            child: Container(
                                                              height: 27.h,
                                                              width: 27.w,
                                                              decoration: BoxDecoration(
                                                                  color: AppColors
                                                                      .primaryColor,
                                                                  shape: BoxShape
                                                                      .circle),
                                                              child: const Icon(
                                                                  Icons
                                                                      .location_on,
                                                                  color:
                                                                      AppColors
                                                                          .white,
                                                                  size: 20),
                                                            ),
                                                          ),
                                                          title: Text(
                                                            "Current Location",
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 14),
                                                          ),
                                                          trailing: const Icon(
                                                              Icons
                                                                  .chevron_right),
                                                          onTap: () {
                                                            accountProvider
                                                                .getDefaultLocation();
                                                            accountProvider
                                                                    .selectedAddressIndex =
                                                                null;
                                                            setState(() {});
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                        ...List.generate(
                                                          accountProvider
                                                                  .addressList
                                                                  ?.length ??
                                                              0,
                                                          (index) {
                                                            final address =
                                                                accountProvider
                                                                        .addressList?[
                                                                    index];
                                                            return Column(
                                                              children: [
                                                                ListTile(
                                                                  contentPadding:
                                                                      EdgeInsets.symmetric(
                                                                          vertical:
                                                                              2.h),
                                                                  leading:
                                                                      CircleAvatar(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .teal
                                                                            .shade100,
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          27.h,
                                                                      width:
                                                                          27.w,
                                                                      decoration: BoxDecoration(
                                                                          color: AppColors
                                                                              .primaryColor,
                                                                          shape:
                                                                              BoxShape.circle),
                                                                      child: const Icon(
                                                                          Icons
                                                                              .location_on,
                                                                          color: AppColors
                                                                              .white,
                                                                          size:
                                                                              20),
                                                                    ),
                                                                  ),
                                                                  title: Text(
                                                                    address?.addressTitle ??
                                                                        "",
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            14),
                                                                  ),
                                                                  subtitle:
                                                                      Text(
                                                                    '${address?.address}, ${address?.city} ${address?.state}',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: AppColors
                                                                            .grey),
                                                                  ),
                                                                  trailing:
                                                                      const Icon(
                                                                          Icons
                                                                              .chevron_right),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      accountProvider
                                                                              .selectedAddressIndex =
                                                                          index;
                                                                    });
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                ),
                                                                const Divider(
                                                                    height: 1),
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: 110,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: AppColors.greenLightest,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                            Assets.location),
                                                        SizedBox(
                                                          width: 10.w,
                                                        ),
                                                        Text(
                                                          "Delivery Address",
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: AppColors
                                                                  .black),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Text(
                                                      '${selectedAddress.address} ${selectedAddress.city} ${selectedAddress.state}', // "24, Ajanlekoko Street, Orisunmbare,\nAlimosho, Lagos State.",
                                                      style: TextStyle(
                                                          color: AppColors.grey,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    SizedBox(height: 10.h),
                                                    Row(
                                                      children: [
                                                        Text(
                                                            "${accountProvider.currentUser.name}}",
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .black,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                        SizedBox(
                                                          width: 20.w,
                                                        ),
                                                        Text(
                                                            "${accountProvider.currentUser.phoneNumber ?? ''}",
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .black,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Spacer(),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: AppColors.primaryColor,
                                                  size: 20,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          CustomBottomSheet.show(
                                              isDismissible: true,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20.0,
                                                        vertical: 10.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Pickup Address",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        IconButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            icon: Icon(
                                                                Icons.close)),
                                                      ],
                                                    ),
                                                    SingleChildScrollView(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          ...List.generate(
                                                            accountProvider
                                                                    .pickUpAddress
                                                                    ?.length ??
                                                                0,
                                                            (index) {
                                                              final address =
                                                                  accountProvider
                                                                          .pickUpAddress?[
                                                                      index];
                                                              return Column(
                                                                children: [
                                                                  ListTile(
                                                                    contentPadding:
                                                                        EdgeInsets.symmetric(
                                                                            vertical:
                                                                                2.h),
                                                                    leading:
                                                                        CircleAvatar(
                                                                      backgroundColor: Colors
                                                                          .teal
                                                                          .shade100,
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            27.h,
                                                                        width:
                                                                            27.w,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                AppColors.primaryColor,
                                                                            shape: BoxShape.circle),
                                                                        child: const Icon(
                                                                            Icons
                                                                                .location_on,
                                                                            color:
                                                                                AppColors.white,
                                                                            size: 20),
                                                                      ),
                                                                    ),
                                                                    title: Text(
                                                                      address?.city ??
                                                                          "",
                                                                      style: const TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                    subtitle:
                                                                        Text(
                                                                      '${address?.address1}, ${address?.state}',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              AppColors.grey),
                                                                    ),
                                                                    trailing:
                                                                        const Icon(
                                                                            Icons.chevron_right),
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        accountProvider.selectedPickUpIndex =
                                                                            index;
                                                                      });
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  ),
                                                                  const Divider(
                                                                      height:
                                                                          1),
                                                                ],
                                                              );
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ));
                                        },
                                        child: Container(
                                          height: 74,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: AppColors.greenLightest,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 20),
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                            Assets.pickupLogo),
                                                        SizedBox(
                                                          width: 10.w,
                                                        ),
                                                        Text(
                                                          "Pickup Location",
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: AppColors
                                                                  .black),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Text(
                                                      '${selectedPickUpAddress.address1}',
                                                      style: TextStyle(
                                                          color: AppColors.grey,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                GestureDetector(
                                                  child: Icon(
                                                    Icons.arrow_forward_ios,
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                // Other widget
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text("Payment Summary",
                                    style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Container(
                                  //height: 210,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: AppColors.greenLightest,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Subtotal",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.grey),
                                            ),
                                            Text(
                                              "${productProvider.cartModel?.data?.isEmpty ?? true ? currencyFormat.format(0.0) : currencyFormat.format(double.parse(productProvider.cartModel?.data?.first.grandTotal ?? '0'))}",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.grey),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Service charge",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors.grey),
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Image.asset(Assets.questionMark)
                                              ],
                                            ),
                                            Text(
                                              "0.00",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.grey),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Delivery fee",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors.grey),
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Image.asset(Assets.questionMark)
                                              ],
                                            ),
                                            Text(
                                              "₦2,000",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.grey),
                                            )
                                          ],
                                        ),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Total",
                                              style: TextStyle(
                                                  fontSize: 19.85,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.grey),
                                            ),
                                            Text(
                                              "₦27,000",
                                              style: TextStyle(
                                                  fontSize: 19.85,
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                      AppColors.primaryColor),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: paymentTextFormField(),
                                            ),
                                            SizedBox(width: 15),
                                            ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColors.primaryColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8), // Rounded corners for the button
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 15),
                                              ),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Apply Code",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: AppColors.white,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(width: 5),
                                                  SvgPicture.asset(
                                                      Assets.coupon)
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40.h,
                                ),
                                // Text("Payment Method",
                                //     style: TextStyle(
                                //         color: AppColors.black,
                                //         fontSize: 14,
                                //         fontWeight: FontWeight.w600)),
                                // SizedBox(
                                //   height: 10.h,
                                // ),
                                // Container(
                                //   height: 200,
                                //   width: double.infinity,
                                //   decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(10),
                                //       color: AppColors.greenLightest),
                                //   child: Padding(
                                //     padding: const EdgeInsets.only(
                                //         top: 15,
                                //         bottom: 5,
                                //         left: 10,
                                //         right: 10),
                                //     child: Column(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.start,
                                //       children: [
                                //         // to activate the radiobutton when the widget is pressed!
                                //         GestureDetector(
                                //           onTap: () {
                                //             ref
                                //                 .read(selectedPaymentProvider
                                //                     .notifier)
                                //                 .state = 'Wallet';
                                //           },
                                //           child: Row(
                                //             crossAxisAlignment:
                                //                 CrossAxisAlignment.start,
                                //             children: [
                                //               SvgPicture.asset(Assets.wallet),
                                //               SizedBox(
                                //                 width: 5.w,
                                //               ),
                                //               Column(
                                //                 crossAxisAlignment:
                                //                     CrossAxisAlignment.start,
                                //                 children: [
                                //                   Text(
                                //                     "Wallet",
                                //                     style: TextStyle(
                                //                         fontSize: 14,
                                //                         fontWeight:
                                //                             FontWeight.w400,
                                //                         color: AppColors.black),
                                //                   ),
                                //                   Text(
                                //                     "Bal: 300,000",
                                //                     style: TextStyle(
                                //                         fontSize: 12,
                                //                         fontWeight:
                                //                             FontWeight.w600,
                                //                         color: AppColors
                                //                             .primaryColor),
                                //                   ),
                                //                 ],
                                //               ),
                                //               Spacer(),
                                //               Radio<String>(
                                //                 activeColor:
                                //                     AppColors.primaryColor,
                                //                 value: 'Wallet',
                                //                 groupValue: paymentOption,
                                //                 onChanged: (value) {
                                //                   ref
                                //                       .read(
                                //                           selectedPaymentProvider
                                //                               .notifier)
                                //                       .state = value!;
                                //                 },
                                //               ),
                                //             ],
                                //           ),
                                //         ),
                                //         Divider(),
                                //         GestureDetector(
                                //           // to activate the radiobutton when the widget is pressed!
                                //           onTap: () {
                                //             ref
                                //                 .read(selectedPaymentProvider
                                //                     .notifier)
                                //                 .state = 'Monnify';
                                //           },
                                //           child: Row(
                                //             children: [
                                //               Image.asset(
                                //                 Assets.monnifyLogo,
                                //                 scale: 2.5,
                                //               ),
                                //               SizedBox(
                                //                 width: 5.w,
                                //               ),
                                //               Text(
                                //                 "Monnify",
                                //                 style: TextStyle(
                                //                     fontSize: 14,
                                //                     fontWeight: FontWeight.w400,
                                //                     color: AppColors.black),
                                //               ),
                                //               Spacer(),
                                //               Radio<String>(
                                //                 activeColor:
                                //                     AppColors.primaryColor,
                                //                 value: 'Monnify',
                                //                 groupValue: paymentOption,
                                //                 onChanged: (value) {
                                //                   ref
                                //                       .read(
                                //                           selectedPaymentProvider
                                //                               .notifier)
                                //                       .state = value!;
                                //                 },
                                //               ),
                                //             ],
                                //           ),
                                //         ),
                                //         Divider(),
                                //         GestureDetector(
                                //           // to activate the radiobutton when the widget is pressed!
                                //           onTap: () {
                                //             ref
                                //                 .read(selectedPaymentProvider
                                //                     .notifier)
                                //                 .state = 'Paystack';
                                //           },
                                //           child: Row(
                                //             children: [
                                //               Image.asset(Assets.paystack),
                                //               SizedBox(
                                //                 width: 5.w,
                                //               ),
                                //               Text(
                                //                 "Paystack",
                                //                 style: TextStyle(
                                //                     fontSize: 14,
                                //                     fontWeight: FontWeight.w400,
                                //                     color: AppColors.black),
                                //               ),
                                //               Spacer(),
                                //               Radio<String>(
                                //                 activeColor:
                                //                     AppColors.primaryColor,
                                //                 value: 'Paystack',
                                //                 groupValue: paymentOption,
                                //                 onChanged: (value) {
                                //                   ref
                                //                       .read(
                                //                           selectedPaymentProvider
                                //                               .notifier)
                                //                       .state = value!;
                                //                 },
                                //               ),
                                //             ],
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: 20.h,
                                // ),
                                CustomButton(
                                  onPressed: () {
                                    paymentProvider.initiatePayment();
                                  },
                                  label: "Proceed",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    )
                  ],
                ),
              ),
            ]),
          ),
        ),
        bottomNavigationBar: currentTabIndex == 0
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset:
                            Offset(0, -2), // Giving shadow above the container
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Modify Cart",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Add to Cart Button
                      ElevatedButton(
                        onPressed: () {
                          ref.read(tabIndexProvider.notifier).setTabIndex(1);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                        ),
                        child: Text(
                          "Proceed",
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : null);
  }
}
