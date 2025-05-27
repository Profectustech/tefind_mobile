import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDownMenu extends StatelessWidget {
  final String label;
  final List menuItems;
  final void Function(String?)? onSelected;

  const CustomDropDownMenu({
    super.key,
    required this.label,
    required this.menuItems,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      label: Text(label),
      width: 310.w,
      onSelected: onSelected,
      dropdownMenuEntries:
          menuItems.map<DropdownMenuEntry<String>>((dynamic value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}


