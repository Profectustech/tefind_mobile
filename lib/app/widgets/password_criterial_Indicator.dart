
import 'package:flutter/material.dart';
import 'package:te_find/utils/app_colors.dart';

Widget buildCriteriaIndicator (String label, bool isValid) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: isValid ? AppColors.primaryColor : AppColors.shadowGrey,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(width: 4),
        if (isValid) Icon(Icons.check, color: Colors.white, size: 16),
      ],
    ),
  );
}

