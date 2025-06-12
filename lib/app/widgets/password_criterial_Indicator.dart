
import 'package:flutter/material.dart';
import 'package:te_find/utils/app_colors.dart';

Widget buildCriteriaIndicator (String label, bool isValid) {
  return Row(
    spacing: 5,
    children: [
      Icon(
        isValid ? Icons.check_circle : Icons.circle_outlined,
        color: isValid ? AppColors.successGreen : AppColors.lightTextBlack,
        size: 16,
      ),
      Text(
        label,
        style: TextStyle(
          color: AppColors.lightTextBlack,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
      SizedBox(width: 4),
      if (isValid) Icon(Icons.check, color: Colors.white, size: 16),
    ],
  );
}

