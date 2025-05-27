import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saleko/utils/app_colors.dart';
import 'package:saleko/utils/screen_size.dart';

class CustomDobPicker extends StatefulWidget {
  final DateTime initialDate;
  final String headerText;
  final ValueChanged<DateTime> onApplyClicked;
  final CupertinoDatePickerMode? mode;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  const CustomDobPicker({
    Key? key,
    required this.onApplyClicked,
    required this.initialDate,
    this.mode,
    this.minimumDate,
    this.maximumDate,
    required this.headerText,
  }) : super(key: key);

  @override
  State<CustomDobPicker> createState() => _CustomDobPickerState();
}

class _CustomDobPickerState extends State<CustomDobPicker> {
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double sHeight = Responsive.height(context);
    final double sWidth = Responsive.width(context);
    return Container(
      height: sHeight * 0.6,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 25,
          ),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.close,
                color: AppColors.blackTextColor,
                size: 30,
              ),
            ),
          ),
          Center(
            child: Text(
              widget.headerText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 45,
          ),
          Container(
            height: 300,
            // decoration: BoxDecoration(
            //   border: Border.all(
            //     color: AppColors.primaryColor,
            //     width: 1,
            //   ),
            //   borderRadius: BorderRadius.circular(4),
            //   color: AppColors.white,
            // ),
            padding: const EdgeInsets.all(10),
            child: CupertinoTheme(
              data: const CupertinoThemeData(
                  brightness: Brightness.light, primaryColor: AppColors.red),
              child: CupertinoDatePicker(
                backgroundColor: AppColors.white,
                // initialDateTime: widget.initialDate,
                minimumDate: widget.minimumDate ??
                    DateTime.now().subtract(Duration(seconds: 1)),
                maximumDate: widget.maximumDate,
                use24hFormat: false,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (DateTime pickedDate) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                },
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                  height: 50,
                  width: sWidth,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            side: BorderSide(color: Colors.transparent),
                          )),
                      onPressed: () {
                        widget.onApplyClicked(selectedDate);
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Apply",
                            style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      )))),
        ],
      ),
    );
  }
}
