import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_find/app/negotiation%20screen/negotiation_detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/assets_manager.dart';
import '../../models/Products.dart';
import '../../providers/product_provider.dart';
import '../../providers/provider.dart';
import '../../services/navigation/navigator_service.dart';
import '../../services/navigation/route_names.dart';
import '../../utils/helpers.dart';
import 'custom_bottom_sheet.dart';
import 'custom_button.dart';
import 'custom_text_form_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NegotiationGrideview extends ConsumerStatefulWidget {
  const NegotiationGrideview({
    super.key,
    required this.NegotiableProduct,
  });

  final Products NegotiableProduct;

  @override
  ConsumerState<NegotiationGrideview> createState() => _NegotiationGrideviewState();
}

class _NegotiationGrideviewState extends ConsumerState<NegotiationGrideview> {
  late ProductProvider productProvider;
  @override
  Widget build(BuildContext context) {
    final productProvider = ref.watch(RiverpodProvider.productProvider);
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: GestureDetector(
        onTap: () {
          NavigatorService().navigateTo(
            productDetailScreenRoute,
            arguments: widget.NegotiableProduct,
          );
        },
        child: Container(
          height: 241.h,
          width: 154.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.white,
          ),
          padding: const EdgeInsets.only(left: 10),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image.asset(
                  //   Assets.laptopPowerbank,
                  //   width: 137.w,
                  //   height: 133.h,
                  // ),
                  CachedNetworkImage(
                    imageUrl:
                    widget.NegotiableProduct.imageUrls?[0].azureUrl ?? "",
                    imageBuilder: (context, imageProvider) => ClipRRect(
                      borderRadius: BorderRadius.circular(15.r),
                      child: Container(
                        height: 130,
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
                        child: const CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => ClipRRect(
                      borderRadius: BorderRadius.circular(15.r),
                      child: Image.asset(
                        Assets.laptopPowerbank,
                        height: 130,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${widget.NegotiableProduct.name}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackTextColor),
                  ),
                  widget.NegotiableProduct.qty! < 10
                      ? Text(
                    // allProducts[index].title
                    "FEW ITEMS LEFT  ${widget.NegotiableProduct.qty!}",
                    style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                        color: AppColors.red),
                  )
                      : Container(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      widget.NegotiableProduct.specialPrice != "0.0000"
                          ? Text(
                        "${currencyFormat.format(double.parse(widget.NegotiableProduct.price ?? "0.0"))}",
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            decorationColor: AppColors.greyText,
                            decorationThickness: 2,
                            color: AppColors.greyText,
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                      )
                          : Container(),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        widget.NegotiableProduct.specialPrice != "0.0000"
                            ? "${currencyFormat.format(double.parse(widget.NegotiableProduct.specialPrice ?? "0.0"))}"
                            : "${currencyFormat.format(double.parse(widget.NegotiableProduct.price ?? "0.0"))}",
                        // "#${widget.newProducts.price}",
                        style: GoogleFonts.roboto(
                            color: AppColors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  SizedBox(height: 12.h),
                  GestureDetector(
                    onTap: () {
                      CustomBottomSheet.show(
                        context: context,
                        isDismissible: true,
                        child: SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                              top: 20,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Negotiate Product",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(Icons.close),
                                    ),
                                  ],
                                ),
                                Divider(),
                                SizedBox(height: 30.h),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 0.55,
                                          color: AppColors.grey,
                                        ),
                                      ),
                                      child: Image.asset(
                                        Assets.laptopPowerbank,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${widget.NegotiableProduct.name}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.blackTextColor),
                                          ),
                                          SizedBox(height: 5.h),
                                          Text(
                                            "Original Price: ${currencyFormat.format(double.parse(widget.NegotiableProduct.price ?? "0.0"))}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 30.h),
                                Text(
                                  "How many would you like to purchase? *",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.grey,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                CustomTextFormField(
                                  hint: 'Enter number of product e.g 5',
                                ),
                                SizedBox(height: 25.h),
                                Text(
                                  "How much are you willing to pay for each? *",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.grey,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                CustomTextFormField(
                                  hint: 'e.g 400,000',
                                ),
                                SizedBox(height: 10.h),
                                Row(
                                  children: [
                                    Text(
                                      "Total price:",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.grey,
                                      ),
                                    ),
                                    SizedBox(width: 5.h),
                                    Text(
                                      "₦0",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                CustomButton(
                                  label: "Negotiate",
                                  fillColor: AppColors.primaryColor,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NegotiationDetailPage(),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: 20.h),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 126.w,
                      height: 26.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(Assets.negotiationIcon),
                          SizedBox(width: 5.w),
                          Text(
                            "Negotiate",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: () {},
                ),
              ),
              Positioned(
                top: 7,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.primaryColor,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: Text(
                    "New",
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
