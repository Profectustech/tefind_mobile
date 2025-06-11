import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:te_find/app/widgets/custom_button.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/services/navigation/route_names.dart';

import '../../../utils/app_colors.dart';
import '../../widgets/currency_formater.dart';
import '../../widgets/custom_text_form_field.dart';

class SellItems extends ConsumerStatefulWidget {
  const SellItems({super.key});

  @override
  ConsumerState createState() => _SellItemsState();
}

class _SellItemsState extends ConsumerState<SellItems> {
  int selectedIndex = -1;

  final List<Map<String, dynamic>> conditions = [
    {
      'label': 'New with tags',
      'icon': 'star.svg',
      'color': AppColors.primaryColor
    },
    {
      'label': 'New without tags',
      'icon': 'star.svg',
      'color': AppColors.primaryColor
    },
    {'label': 'Very Good', 'icon': 'thumbsUp.svg', 'color': AppColors.yellow},
    {'label': 'Good', 'icon': 'thumbsUp.svg', 'color': AppColors.yellow},
    {'label': 'Fair', 'icon': 'handLove.svg', 'color': AppColors.orange},
  ];

  int selectedColorIndex = 0;
  int selectedSizeIndex = 2; // Default to "M"

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

  void showMakeOfferDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset('assets/images/sucessListing.svg'),
                SizedBox(height: 10.h),
                Text(
                  'Success!',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Your Item has been listed successfully',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.lightTextBlack),
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                    NavigatorService().navigateReplacementTo(listingviewallProducts);
                  },
                  fillColor: AppColors.primaryColor,
                  label: 'Go to Listing',
                  buttonTextColor: AppColors.white,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  List<File> selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> takePicture() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null && selectedImages.length < 6) {
      setState(() {
        selectedImages.add(File(pickedFile.path));
      });
    } else if (selectedImages.length >= 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        showToast('You can only select up to 6 images.') as SnackBar,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios,
          size: 20,
        ),
        title: Text(
          'Sell items',
          style:
              GoogleFonts.roboto(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
        actions: [
          Text(
            'Cancel',
            style: GoogleFonts.roboto(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.grey),
          ),
          SizedBox(
            width: 5.w,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Photo*',
                    style: GoogleFonts.roboto(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    '(${selectedImages.length}/6)',
                    style: GoogleFonts.roboto(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  takePicture();
                },
                child: Container(
                  height: 160.h,
                  width: 343.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColors.greyLight),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 48.h,
                          width: 48.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.greyLight,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.camera_alt_rounded,
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'Add Photos',
                          style: GoogleFonts.roboto(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          'Tap to upload',
                          style: GoogleFonts.roboto(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),

              selectedImages.isNotEmpty
                  ? SizedBox(
                      height: 80.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedImages.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 10.w),
                                height: 70.h,
                                width: 70.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: FileImage(selectedImages[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedImages.removeAt(index);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    padding: EdgeInsets.all(2),
                                    child: Icon(Icons.close, size: 16),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  : Text(
                      'First image will be the cover photo. You can add up to 6 photos.',
                      style: GoogleFonts.roboto(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey,
                      ),
                    ),

              SizedBox(
                height: 15.h,
              ),
              Text(
                'Title*',
                style: GoogleFonts.roboto(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightTextBlack),
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomTextFormField(
                //controller: accountProvider.lastNameController,
                hint: "e.g Vintage Jacket",
                // validator: Validators().isSignUpEmpty,
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'Gender*',
                style: GoogleFonts.roboto(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightTextBlack),
              ),
              SizedBox(
                height: 5.h,
              ),
              // Container(
              //   padding:
              //   const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(8),
              //     border: Border.all(color: Colors.black),
              //   ),
              //   child: DropdownButtonFormField(
              //     decoration: const InputDecoration(border: InputBorder.none),
              //     value: accountProvider.emailPhone,
              //       icon: const Icon(
              //         Icons.expand_more,
              //         size: 28,
              //       ),
              //       hint: const Text(
              //         'Email or phone number',
              //         style: TextStyle(
              //             fontWeight: FontWeight.w200, color: Colors.grey),
              //       ),
              //       items: ['Male, Female'] {
              //       return DropdownMenuItem(
              //         value: item,
              //         child: Text(
              //           item,
              //           style: const TextStyle(fontWeight: FontWeight.w500),
              //         ),
              //       );
              //     }).toList(),
              //     onChanged: (String? newValue) {
              //     },
              //   ),
              // ),
              CustomTextFormField(
                //controller: accountProvider.lastNameController,
                hint: "Select Gender",
                // validator: Validators().isSignUpEmpty,
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'Category*',
                style: GoogleFonts.roboto(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightTextBlack),
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomTextFormField(
                //controller: accountProvider.lastNameController,
                hint: "Select Cateory",
                // validator: Validators().isSignUpEmpty,
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'SubCategory*',
                style: GoogleFonts.roboto(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightTextBlack),
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomTextFormField(
                //controller: accountProvider.lastNameController,
                hint: "Select SubCateory",
                // validator: Validators().isSignUpEmpty,
              ),
              SizedBox(
                height: 15.h,
              ),
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
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                'Condition*',
                style: GoogleFonts.roboto(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightTextBlack),
              ),
              SizedBox(
                height: 15.h,
              ),

              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1.35, // Adjust as needed (width / height)
                children: List.generate(conditions.length, (index) {
                  bool isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.green[35] : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primaryColor
                              : AppColors.greyLight,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/${conditions[index]['icon']}',
                            height: 30,
                          ),
                          SizedBox(height: 6),
                          Text(
                            textAlign: TextAlign.center,
                            conditions[index]['label'],
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Description*',
                style: GoogleFonts.roboto(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightTextBlack),
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomTextFormField(
                maxLength: 500,
                maxLines: 5,
                //controller: accountProvider.lastNameController,
                hint: "Describe your item (color, size, brand, etc.)",
                // validator: Validators().isSignUpEmpty,
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'Price*',
                style: GoogleFonts.roboto(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightTextBlack),
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomTextFormField(
                hint: "0.00",
                prefixText: "₦ ",
                inputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyInputFormatter(),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                spacing: 5.w,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.grey,
                  ),
                  Expanded(
                    child: Text(
                      'Set a competitive price to sell faster. Check similar items for reference.',
                      style: GoogleFonts.roboto(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              CustomButton(
                onPressed: () => showMakeOfferDialog(context),
                label: 'Post Listing',
                fillColor: AppColors.primaryColor,
                buttonTextColor: Colors.white,
              ),
              SizedBox(
                height: 15.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
