import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saleko/app/widgets/search_box.dart';
import 'package:saleko/providers/provider.dart';
import 'package:saleko/utils/assets_manager.dart';
import 'package:saleko/utils/app_colors.dart';
import '../../providers/account_provider.dart';

class FilterPage extends ConsumerStatefulWidget {
  FilterPage({super.key});

  @override
  ConsumerState<FilterPage> createState() => FilterPageState();
}

class FilterPageState extends ConsumerState<FilterPage> {
  late AccountProvider accountProvider;
  bool isSelected = false;
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    accountProvider = ref.watch(RiverpodProvider.accountProvider);

    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(30.r)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Filter ",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.close))
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Category",
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w600),
                          ),
                          isSelected
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 7),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    "Clear all",
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                  ),
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                      SizedBox(height: 20.h),

                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Electronics",
                              style: TextStyle(color: AppColors.primaryColor),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return CheckboxListTile(
                                  value: _isChecked,
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      _isChecked = newValue ?? false;
                                    });
                                  },
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  activeColor: AppColors.black,
                                  checkColor: AppColors.white,
                                  tristate: true,
                                  contentPadding: EdgeInsets.zero,
                                  title: Text("SmartPhones"),
                                );
                              },
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),

                      // Brands section
                      Text(
                        "Brands",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10.h),

                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 90),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: AppColors.grey),
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(9)),
                              child: SearchBox(hint: "Search"),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              height: 250.h,
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: 20,
                                itemBuilder: (context, index) {
                                  return CheckboxListTile(
                                    value: _isChecked,
                                    onChanged: (bool? newValue) {
                                      setState(() {
                                        _isChecked = newValue ?? false;
                                      });
                                    },
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    activeColor: AppColors.black,
                                    checkColor: AppColors.white,
                                    tristate: true,
                                    contentPadding: EdgeInsets.zero,
                                    title: Text("Golden Penny"),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    SizedBox(height: 10.h),
                    Text(
                      "Stores",
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 90),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: AppColors.grey),
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(9)),
                            child: SearchBox(hint: "Search"),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            height: 250.h,
                            child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: 20,
                              itemBuilder: (context, index) {
                                return CheckboxListTile(
                                  value: _isChecked,
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      _isChecked = newValue ?? false;
                                    });
                                  },
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  activeColor: AppColors.black,
                                  checkColor: AppColors.white,
                                  tristate: true,
                                  contentPadding: EdgeInsets.zero,
                                  title: Text("Amala (1.5k orders)"),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
