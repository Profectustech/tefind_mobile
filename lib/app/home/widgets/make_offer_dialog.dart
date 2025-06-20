import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/Products.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/assets_manager.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';


void showMakeOfferDialog(BuildContext context, Products product) {
  showDialog(
    context: context,
    barrierDismissible: false,
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
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  CachedNetworkImage(
                    // imageUrl:
                    //     widget.newProducts.imageUrls?[0].localUrl ?? "",
                    imageUrl: product.images?.isNotEmpty ??
                        false
                        ? product.images[0] ?? ""
                        : "",
                    imageBuilder: (context, imageProvider) => ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Container(
                        height: 60.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Container(
                      height: 60.h,
                      width: 60.w,
                      child: Center(
                        child: SizedBox(
                          width: 30.w,
                          height: 30.h,
                          child: const CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => ClipRRect(
                      borderRadius: BorderRadius.circular(185.r),
                      child: Image.asset(
                        Assets.laptopPowerbank,
                        height: 60.h,
                        width: 60.w,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Listed Price: ",
                            style: GoogleFonts.roboto(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.grey),
                          ),
                          Text(
                            "₦${product.price}",
                            style: GoogleFonts.roboto(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 15.h),
              Text(
                'Your Offer (₦)',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500, fontSize: 11),
              ),
              SizedBox(height: 6.h),
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  fillColor: Color.fromRGBO(249, 250, 251, 1),
                  hintStyle:
                  GoogleFonts.roboto(color: AppColors.grey, fontSize: 12.sp),
                  hintText: 'Enter amount in Naira',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: AppColors.grey, width: 1.0),
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Minimum: ₦45,000",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "Maximum: ₦45,000",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Text(
                'Message (Optional)',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 5.h),
              CustomTextFormField(
                maxLines: 3,
                hint: 'Add a Message to the seller...',
              ),
              SizedBox(height: 20.h),
              CustomButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                fillColor: AppColors.primaryColor,
                label: 'Send Offer',
                buttonTextColor: AppColors.white,
              ),
            ],
          ),
        ),
      );
    },
  );
}
