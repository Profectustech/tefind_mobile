import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_colors.dart';
import '../../widgets/custom_button.dart';

class Condition extends StatefulWidget {
  const Condition({super.key});

  @override
  State<Condition> createState() => _ConditionState();
}

class _ConditionState extends State<Condition> {
  final Set<String> selectedConditions = {'Like new', 'Good'};
  final List<_ConditionOption> conditionOptions = [
  _ConditionOption(
  title: 'New with tags',
  subtitle: 'Unused item with original tags attached',
  color: AppColors.green,
  ),
  _ConditionOption(
  title: 'Like new',
  subtitle: 'Unused item without tags',
  color: AppColors.primaryColor,
  ),
  _ConditionOption(
  title: 'Good',
  subtitle: 'Used item with minor signs of wear',
  color: AppColors.orange,
  ),
  _ConditionOption(
  title: 'Fair',
  subtitle: 'Used item with visible signs of wear',
  color: AppColors.grey,
  ),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Item Condition',
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
        SizedBox(height: 5.h),
        ...conditionOptions.map((option) => buildConditionTile(option)),
        SizedBox(height: 20.h),
        CustomButton(
          onPressed: () {
            // Handle apply action
            Navigator.pop(context);
          },
          label: 'Apply',
          fillColor: AppColors.primaryColor,
          buttonTextColor: Colors.white,
        ),
      ],
    );
  }


  Widget buildConditionTile(_ConditionOption option) {
    final isSelected = selectedConditions.contains(option.title);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedConditions.remove(option.title);
          } else {
            selectedConditions.add(option.title);
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.greyLight),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/images/badge2.svg',
              color: option.color,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(option.title,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(option.subtitle,
                      style: GoogleFonts.roboto(
                          color: Colors.grey, fontSize: 12.sp)),
                ],
              ),
            ),
            Checkbox(
              activeColor: AppColors.primaryColor,
              value: isSelected,
              onChanged: (_) {
                setState(() {
                  if (isSelected) {
                    selectedConditions.remove(option.title);
                  } else {
                    selectedConditions.add(option.title);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}


class _ConditionOption {
  final String title;
  final String subtitle;
  final Color color;

  _ConditionOption({
    required this.title,
    required this.subtitle,
    required this.color,
  });
}
