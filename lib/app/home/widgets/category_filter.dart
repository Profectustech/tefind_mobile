import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_colors.dart';
import '../../widgets/custom_button.dart';

class CategoryFilter extends StatefulWidget {
  const CategoryFilter({super.key});

  @override
  State<CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  final Set<String> selectedCategories = {'Tops'};

  final Map<String, List<String>> categoryGroups = {
    "Women's": [
      'Dresses',
      'Tops',
      'Bottoms',
      'Outerwear',
      'Activewear',
      'Swimwear'
    ],
    "Men's": [
      'Shirts',
      'T-shirts',
      'Pants',
      'Outerwear',
      'Activewear',
      'Swimwear'
    ],
    "Shoes": ["Women's Shoes", "Men's Shoes", 'Athletic Shoes', 'Boots'],
    "Accessories": [
      'Bags',
      'Jewelry',
      'Watches',
      'Hats',
      'Sunglasses',
      'Belts'
    ],
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
                Text('Categories',
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
            SizedBox(height: 10.h),

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
                      spacing: 10,
                      runSpacing: 10,
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
                                color:  AppColors.greyLight,
                              ),
                              borderRadius: BorderRadius.circular(16.r),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  isSelected
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank,
                                  size: 18.sp,
                                  color: isSelected
                                      ? AppColors.primaryColor
                                      : Colors.grey,
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  cat,
                                  style: GoogleFonts.roboto(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400
                                  ),
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

            SizedBox(height: 20.h),

            CustomButton(
              onPressed: () {
                // Handle Apply
                Navigator.pop(context);
              },
              label: 'Apply',
              fillColor: AppColors.primaryColor,
              buttonTextColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
