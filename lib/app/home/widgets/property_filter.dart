import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/app_colors.dart';
import '../../widgets/custom_button.dart';

class PropertyFilter extends StatefulWidget {
  const PropertyFilter({super.key});

  @override
  State<PropertyFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<PropertyFilter> {
  int selectedColorIndex = 0;
  int selectedSizeIndex = 2;

  final List<Color> colors = [
    Colors.black,
    Colors.white,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.pink,
    Colors.purple,
  ];

  final List<String> sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                )
              ],
            ),

            Text(
              'Size',
              style: GoogleFonts.roboto(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.lightTextBlack),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(sizes.length, (index) {
                bool isSelected = index == selectedSizeIndex;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedSizeIndex = index;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.teal),
                    ),
                    child: Text(
                      sizes[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 15),

            Text(
              'Color',
              style: GoogleFonts.roboto(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.lightTextBlack),
            ),
            SizedBox(height: 10),
            Row(
              children: List.generate(colors.length, (index) {
                bool isSelected = index == selectedColorIndex;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedColorIndex = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 5),
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(color: Colors.black, width: 2)
                          : null,
                    ),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: colors[index],
                        shape: BoxShape.circle,
                        border: colors[index] == Colors.white
                            ? Border.all(
                                color: Colors
                                    .grey) // white needs border to be visible
                            : null,
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 15),
            Text(
              'Price',
              style: GoogleFonts.roboto(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.lightTextBlack),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPriceBox('Min'),
                Icon(
                  Icons.remove,
                  color: AppColors.grey,
                ),
                _buildPriceBox('Max'),
              ],
            ),
            SizedBox(height: 30.h),

            Row(
              spacing: 10.w,
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      // Handle Apply
                      Navigator.pop(context);
                    },
                    label: 'Reset',
                    fillColor: AppColors.greyLight,
                    buttonTextColor: AppColors.lightTextBlack,
                  ),
                ),
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      // Handle Apply
                      Navigator.pop(context);
                    },
                    label: 'Apply Filter',
                    fillColor: AppColors.primaryColor,
                    buttonTextColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildPriceBox(String text) {
  return Container(
    width: 140.w,
    height: 48.h,
    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0), // Remove padding
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16.r),
      color: AppColors.greyLight,
    ),
    alignment: Alignment.center,
    child: TextFormField(
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
          border: InputBorder.none,
          hintText: text,
          hintStyle: GoogleFonts.roboto(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.lightTextBlack)),
      style: GoogleFonts.roboto(
        fontWeight: FontWeight.w500,
        color: AppColors.grey,
      ),
    ),
  );
}
