import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saleko/app/widgets/search_box.dart';
import 'package:saleko/providers/provider.dart';
import 'package:saleko/utils/assets_manager.dart';
import 'package:saleko/utils/app_colors.dart';
import '../../../models/filter_model.dart';
import '../../../providers/account_provider.dart';

class SellerFilter extends ConsumerStatefulWidget {
  SellerFilter({super.key});

  @override
  ConsumerState<SellerFilter> createState() => SellerFilterState();
}

class SellerFilterState extends ConsumerState<SellerFilter> {
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
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                      SizedBox(height: 10.h,),
                      Text(
                        "Categories",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 19),
                      ),
                      ListView.builder(
                        shrinkWrap: true, // Dynamically adjusts height
                        physics:
                            NeverScrollableScrollPhysics(), // Disable scrolling
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return ExpansionTile(
                            title: Text(
                              category.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                            children: category.subCategories.map((subCategory) {
                              return CheckboxListTile(
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                activeColor: AppColors.black,
                                checkColor: AppColors.white,
                                tristate: true,
                                contentPadding: EdgeInsets.zero,
                                title: Row(
                                  children: [
                                    Text(
                                      subCategory.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      "(${subCategory.count})",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                value: subCategory.isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    subCategory.isChecked = value ?? false;
                                  });
                                },
                              );
                            }).toList(),
                          );
                        },
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
                      "Brand",
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
                          SearchBox(hint: "Search"),
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
                    SizedBox(height: 10.h),
                    Text(
                      "Store",
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
                          SearchBox(hint: "Search"),
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
                    SizedBox(height: 10.h,),
                    Text(
                      "Promotional Offer",
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
                          SearchBox(hint: "Search"),
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
                                  title: Text("Items on Sale"),
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
            ],
          ),
        ),
      ),
    );
  }
}
