import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_colors.dart';
import '../../widgets/custom_button.dart';

class PriceModalContent extends StatefulWidget {
  const PriceModalContent({super.key});

  @override
  State<PriceModalContent> createState() => _PriceModalContentState();
}

class _PriceModalContentState extends State<PriceModalContent> {
  RangeValues _priceRange = const RangeValues(0, 50000);
  final double _minPrice = 0;
  final double _maxPrice = 100000;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Price Range',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black)),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.close),
            )
          ],
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("₦${_minPrice.toInt()}",
                style: GoogleFonts.roboto(color: Colors.grey)),
            Text("₦${_maxPrice.toInt()}+",
                style: GoogleFonts.roboto(color: Colors.grey)),
          ],
        ),
        SizedBox(height: 5.h),
        RangeSlider(
          values: _priceRange,
          min: _minPrice,
          max: _maxPrice,
          divisions: 100,
          activeColor: AppColors.primaryColor,
          inactiveColor: Colors.grey.shade300,
          onChanged: (RangeValues values) {
            setState(() {
              _priceRange = values;
            });
          },
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildPriceBox("₦ ${_priceRange.start.toInt()}"),
            _buildPriceBox("₦ ${_priceRange.end.toInt()}"),
          ],
        ),
        SizedBox(height: 30.h),
        CustomButton(
          onPressed: () {
            // Handle apply action
            Navigator.pop(context, _priceRange);
          },
          label: 'Apply',
          fillColor: AppColors.primaryColor,
          buttonTextColor: Colors.white,
        ),
      ],
    );
  }

  Widget _buildPriceBox(String text) {
    return Container(
      width: 140.w,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white,
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: GoogleFonts.roboto(fontWeight: FontWeight.w500, color: AppColors.grey),
      ),
    );
  }
}
