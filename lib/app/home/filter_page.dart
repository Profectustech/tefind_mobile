import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/app_colors.dart';
import '../widgets/custom_button.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<FilterPage> {
  RangeValues _priceRange = const RangeValues(0, 50000);
  final double _minPrice = 0;
  final double _maxPrice = 100000;
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

  final Set<String> selectedCategories = {'Tops'};

  final Map<String, List<String>> categoryGroups = {
    "Condition's": [
      'New with Tags',
      'New without tags',
      'Very good',
      'Good',
      'Good',
    ],
    "Categories": ["Women's", "Men's", 'Shoes', 'Bags', 'Jewelry', 'Kids'],
    // "Shoes": ["Women's Shoes", "Men's Shoes", 'Athletic Shoes', 'Boots'],
    // "Accessories": [
    //   'Bags',
    //   'Jewelry',
    //   'Watches',
    //   'Hats',
    //   'Sunglasses',
    //   'Belts'
    // ],
  };

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Filters',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black)),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                )
              ],
            ),

            Divider(),
            Text("Price Range", style: GoogleFonts.roboto(color: Colors.black)),
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPriceBox("₦ ${_priceRange.start.toInt()}"),
                _buildPriceBox("₦ ${_priceRange.end.toInt()}"),
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

            Text(
              'Size',
              style: GoogleFonts.roboto(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.lightTextBlack),
            ),
            SizedBox(height: 10.h),
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
            SizedBox(height: 10.h),

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
            SizedBox(height: 10),
            // Category Groups
            ...categoryGroups.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(entry.key,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.sp)),
                    SizedBox(height: 10.h),
                    Wrap(
                      spacing: 10.w,
                      runSpacing: 20,
                      children: entry.value.map((cat) {
                        final isSelected = selectedCategories.contains(cat);
                        return InkWell(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selectedCategories.remove(cat);
                              } else {
                                selectedCategories.add(cat);
                              }
                            });
                          },
                          borderRadius: BorderRadius.circular(16.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primaryColor
                                    : AppColors.greyLight,
                              ),
                              borderRadius: BorderRadius.circular(16.r),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(width: 6.w),
                                Text(
                                  cat,
                                  style: GoogleFonts.roboto(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            }),
            SizedBox(height: 15.h),
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
                  borderColor: AppColors.primaryColor,
                    fillColor: AppColors.white,
                    buttonTextColor: AppColors.primaryColor,
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
  return Text(
    text,
    style:
        GoogleFonts.roboto(fontWeight: FontWeight.w500, color: AppColors.black),
  );
}
